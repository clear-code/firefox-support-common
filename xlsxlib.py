import os
import sys
import re

BASEDIR = os.path.dirname(os.path.realpath(__file__))
sys.path.append(BASEDIR)

import adlib

#
# Global settings

ESR_PREVIOUS = 'esr128'
ESR_CURRENT  = 'esr140'

WORKBOOKS = [
    ('基本設定', [
        'Install',
        'Application',
        'Admin',
        'Security',
        'Privacy',
        'Startup',
        'Websearch',
        'Location',
        'Download',
        'Tab',
        'Network',
        'Update',
        'Ui',
        'Script',
        'Plugin',
        'External',
        'Stability',
        'Appearance',
        'Performance',
        'Addon-IEView',
        'Addon-FireIE',
        'Addon-Acrobat',
        'Addon-Skysea',
    ]),
    ('機能無効化', [
        'MenuShortcut',
    ]),
]

DEFAULT_FORMAT = {
    'valign':    'top',
    'border':    1,
    'font_size': 8,
    'font_name': 'MS Gothic',
    'text_wrap': 1,
}

CATEGORY_COLUMNS = [ # label, width, key, format
    ('カテゴリー',              10, 'category', 'default'),
]

HEADING_COLUMNS = [ # label, width, key, format
    ('項目設定番号',            10, 'index',    None),
    ('カスタマイズ項目 (目的)', 30, 'title',    None),
]

LEADING_COLUMNS = [ # label, width, key, format
    ('選択肢番号',              5,  'option_index',    None),
    ('選択肢',                  20, 'option_title',    None),
    ('設定内容の雛形\n(%s)' % ESR_CURRENT.upper(),
                                40, 'template_config', None),
]

def variation_columns(version, prev_version):
    return [ # label, width, key, format
        ('反映した設定値\n(%s)' % version,           40, None, None),
        ('%s→%sでの変更' % (prev_version, version), 10, None, None),
    ]

VERIFICATION_COLUMNS = [ # label, width, key, format
    ('検証手順書対応番号', 10, 'verification_chapter', 'default'),
    ('',                   12, None,                   'noborder'),
]

PREV_VERSION_COLUNBS = [ # label, width, key, format
    ('設定内容の雛形\n(%s)' % ESR_PREVIOUS.upper(), 40, 'template_prev_config', None),
    ('反映した設定値\n(%s)' % ESR_PREVIOUS.upper(), 40, 'applied_prev_config',  None),
]

check_template_mode = False

#
# XLSX writer

class ConfigurationSheet:

    def __init__(self, confs, formats, sheet):
        self._confs   = confs
        self._formats = formats
        self._sheet   = sheet

    def iterate_all_confs(self):
        return self._confs.items()

    def write_cell(self, row, column, contents, format):
        self._sheet.write(row, column, contents, self._formats[format])

    def _set_cell_visual(self, row, column, width, format = None):
        if format:
            self._sheet.set_column(row, column, width, self._formats[format])
        else:
            self._sheet.set_column(row, column, width)

    def write_header(self):
        sheet = self._sheet

        sheet.freeze_panes(1, 0)
        sheet.set_row(0, 25)

        column_offset = 0
        column_offset += self._write_header_columns(CATEGORY_COLUMNS, 0)
        column_offset += self._write_header_columns(HEADING_COLUMNS, column_offset)
        column_offset += self._write_header_columns(LEADING_COLUMNS, column_offset)

        last_variation = ESR_PREVIOUS.upper()
        for variation in self._confs.keys():
            if variation == ESR_PREVIOUS.upper():
                continue
            columns = variation_columns(variation, last_variation)
            column_offset += self._write_header_columns(columns, column_offset)
            last_variation = variation

        column_offset += self._write_header_columns(VERIFICATION_COLUMNS, column_offset)
        column_offset += self._write_header_columns(PREV_VERSION_COLUNBS, column_offset)

    def _write_header_columns(self, columns, column_offset):
        for index, column in enumerate(columns):
            label, width, _key, _format = column
            self.write_cell(0, column_offset + index, label, 'center')
            self._set_cell_visual(column_offset + index, column_offset + index, width)
        return len(columns)

    def merge_category_heading(self, row, items):
        for index, _column in enumerate(CATEGORY_COLUMNS):
            self._sheet.merge_range(row, index, row + self._count_options(items) - 1, index, '')

    def _count_options(self, items):
        return sum(len(item['options']) for item in items)

    def try_merge_item_heading(self, row, item):
        if len(item['options']) <= 1:
            return
        sheet = self._sheet
        column_offset = len(CATEGORY_COLUMNS)
        for index, _column in enumerate(HEADING_COLUMNS):
            sheet.merge_range(row, column_offset + index, row + len(item['options']) - 1, column_offset + index, '')

    def write_legend(self, row):
        self.write_cell(row,     1, '',                                     'selected')
        self.write_cell(row,     2, '前バージョンから引き続き利用する項目', 'noborder')
        self.write_cell(row + 1, 1, '',                                     'selected_changed')
        self.write_cell(row + 1, 2, '前バージョンから異同がある項目',       'noborder')
        self.write_cell(row + 2, 1, '',                                     'deprecated')
        self.write_cell(row + 2, 2, '廃止済みの項目',                       'noborder')
        if check_template_mode:
            self.write_cell(row + 3, 1, '',                                   'check_template')
            self.write_cell(row + 3, 2, '新しい設定値に追従できていない項目',    'noborder')

class ConfigurationRow:

    def __init__(self, sheet, index, item, option, category,
                 prev_conf, prev_items, verification_chapters):
        self._sheet                 = sheet
        self._index                 = index
        self._item                  = item
        self._option                = option
        self._category              = category
        self._prev_conf             = prev_conf
        self._verification_chapters = verification_chapters
        self._verification_chapter  = ''

        self._prev_config           = self._get_option_config(self._prev_conf)
        self._template_prev_config  = self._get_option_config(prev_items)
        self._template_curr_config  = option['config'].strip()

    def _get_option_config(self, conf_or_items):
        found_option = conf_or_items.get(self._option['option_id'])
        if not found_option:
          return ''
        return found_option['config']

    def write(self):
        column_offset = 0
        column_offset += self._write_item_columns(CATEGORY_COLUMNS)

        # Heading column must be written for all rows, otherwise merged cells will have
        # a partial border line just for the first row.
        heading_format = 'default'
        if self._is_deprecated(self._item['title']):
            heading_format = 'deprecated'
        column_offset += self._write_item_columns(HEADING_COLUMNS, heading_format, column_offset)

        # Don't output leading columns here, because they depends on the format calculated for variation columns
        column_offset += len(LEADING_COLUMNS)
        column_count, format = self._write_item_variations_columns(column_offset)
        column_offset += column_count

        # Now we are ready to fill leading columns!
        self._write_item_columns(LEADING_COLUMNS, format, len(CATEGORY_COLUMNS + HEADING_COLUMNS))

        column_offset += self._write_item_columns(VERIFICATION_COLUMNS, format, column_offset)
        column_offset += self._write_item_columns(PREV_VERSION_COLUNBS, format, column_offset)

    def _write_column(self, column, contents, format):
        self._sheet.write_cell(self._index, column, contents, format)

    def _write_item_columns(self, columns, format = 'default', column_offset = 0):
        for index, column in enumerate(columns):
            label, width, key, override_format = column
            self._write_column(column_offset + index, self._get_column_value(key), override_format or format)
        return len(columns)

    def _get_column_value(self, key):
        if key == 'category':
            return self._category
        elif key == 'index':
            return int(self._item['index'])
        elif key == 'title':
            return self._item['title']
        elif key == 'option_index':
            return int(self._option['option_index'])
        elif key == 'option_title':
            return self._option['option_title']
        elif key == 'template_config':
            return self._template_curr_config
        elif key == 'verification_chapter':
            return self._verification_chapter;
        elif key == 'template_prev_config':
            return self._template_prev_config;
        elif key == 'applied_prev_config':
            return self._prev_config;
        else:
            return ''

    def _write_item_variations_columns(self, column_offset):
        option_id = self._option['option_id']

        column_count         = 0
        row_format           = 'default'
        verification_chapter = ''

        last_conf   = self._prev_conf
        last_config = self._prev_config
        for version, conf in self._sheet.iterate_all_confs():
            if version == ESR_PREVIOUS.upper():
                continue

            config         = self._get_option_config(conf)
            format, status = self._determine_format_and_status(conf, last_conf, last_config)

            if last_conf == self._prev_conf:
              row_format = format

            if option_id in conf:
                self._verification_chapter = self._verification_chapters.get(option_id, '省略')

            self._write_column(column_offset + column_count,     config, format)
            self._write_column(column_offset + column_count + 1, status, format)

            column_count += 2
            last_conf   = conf
            last_config = config

        return [column_count, row_format]

    def _determine_format_and_status(self, conf, last_conf, last_config):
        option    = self._option
        option_id = option['option_id']

        status   = ''
        format   = 'default'
        config   = self._get_option_config(conf)
        modified = self._sanitize_config(last_config) != self._sanitize_config(config)
        check_template = self._is_follow_new_template(option_id, config)

        if self._is_deprecated(self._item['title']) or self._is_deprecated(option['option_title']):
            format = 'deprecated'
        elif option_id in conf:
            if option_id not in last_conf:
                format, status = 'selected_changed', '新規'
            elif modified:
                if check_template:
                    print('WARNING: %s %s column should be updated:' % (option_id, ESR_CURRENT.upper()))
                    format, status = 'check_template', '雛形要確認(変更あり)'
                else:
                    format, status = 'selected_changed', '変更あり'
            elif check_template:
                print('WARNING: %s %s is same as %s, but a bit different from current %s template:' %
                      (option_id, ESR_CURRENT.upper(), ESR_PREVIOUS.upper(), ESR_CURRENT.upper()))
                format, status = 'check_template', '雛形要確認(変更なし)'
            else:
                format, status = 'selected', ''
        elif last_conf == self._prev_conf:
            if self._modified_from_prev_version():
              if self._added_at_this_version():
                  format, status = 'changed', '新規（未設定）'
              else:
                  format, status = 'changed', '変更あり（未設定）'
        else:
            if modified:
                status = '削除'

        return [format, status]

    def _modified_from_prev_version(self):
        return self._sanitize_config(self._template_curr_config) != self._sanitize_config(self._template_prev_config)

    def _added_at_this_version(self):
        return self._template_prev_config == ''

    def _is_deprecated(self, string):
        return '廃止' in string

    def _sanitize_config(self, config):
        return re.sub(' *[^:]+:\n', '', config).strip()

    def _omit_redundant_config(self, config):
        config = re.sub('.*\*\.cfg', '*.cfg', config, flags=(re.DOTALL)).strip()
        config = self._omit_gpo_config(config)
        return config

    def _omit_gpo_config(self, config):
        # eliminate GPO: and the following configuration lines
        return re.sub('GPO:.*', '', config, flags=(re.DOTALL)).strip()

    def _is_follow_new_template(self, option_id, config):
        if not check_template_mode:
            return False
        if option_id in ('Install-1-2', 'Install-2-2', 'Install-7-2'):
            # Ignore always customized value
            return False
        if len(config) == 0:
            return False
        return self._sanitize_config(self._omit_redundant_config(self._template_curr_config)) != self._sanitize_config(config)

def generate_xlsx(workbook, confs, verification_chapters, exclude_worksheets):
    formats = create_formats(workbook)
    prev_conf = confs[ESR_PREVIOUS.upper()]

    for title, sources in WORKBOOKS:
        if title in exclude_worksheets:
            continue

        sheet = ConfigurationSheet(
            confs,
            formats,
            workbook.add_worksheet(title),
        )
        sheet.write_header()

        row_index = 1
        for source in sources:
            # We always output items based on sources for the current version.
            # In other words, the "current version" needs to define all deprecated/obsolete items
            # if they still need to be visible in the output sheet.
            base_items = adlib.load(os.path.join(BASEDIR, ESR_CURRENT, source))
            prev_items = adlib.load_as_dict(os.path.join(BASEDIR, ESR_PREVIOUS, source))

            sheet.merge_category_heading(row_index, base_items)

            for item in base_items:
                sheet.try_merge_item_heading(row_index, item)

                for option in item['options']:
                    row = ConfigurationRow(
                        sheet,
                        row_index,
                        item,
                        option,
                        source,
                        prev_conf,
                        prev_items,
                        verification_chapters,
                    )
                    row.write()
                    row_index += 1

        sheet.write_legend(row_index + 1)

def create_formats(workbook):
    def new_format(**kwargs):
        return workbook.add_format(dict(DEFAULT_FORMAT, **kwargs))
    return {
        'default':          new_format(),
        'noborder':         new_format(border = 0),
        'center':           new_format(align = 'center'),
        'changed':          new_format(bold = True),
        'deprecated':       new_format(bg_color = '#dddddd'),
        'question':         new_format(bg_color = '#90ee90'),
        'selected':         new_format(bg_color = '#fffa95'),
        'selected_changed': new_format(bg_color = '#ffb571'),
        'check_template':   new_format(bg_color = '#ff00ff'),
    }
