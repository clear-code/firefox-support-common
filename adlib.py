#
# ADLIB - The Arcane Document Library
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Copyright (C) Clear Code, Inc. 2019-2021
#
# HOW TO USE
# ----------
#
# >>> import adlib
# >>> adlib.load('esr60/Install')
#
# OUTPUT DATA SCHEMA
# -----------
#
#   {
#     'id': 'Privacy-2',
#     'category': 'Privacy',
#     'index': '2',
#     'title': 'フォームの入力履歴の保存の可否',
#     'options': [
#        {'option_id':    'Privacy-2-3',
#         'option_index': '3',
#         'option_title': '保存しない（ポリシーで設定）',
#         'dependency':   '何々の場合',
#         'config':       '"DisableFormHistory": true'},
#        ...
#     ]
#   }

import re
import textwrap
from collections import OrderedDict

# Our configuration database is just a collection of text files.
# Each file contains a set of configuration items like this:
#
# Install-1: インストーラの表示名
#
#    :1: 任意の名前
#
#    !define PRODUCT_FULL_NAME  "（名前）"
#
# ITEM_MATCHER matches configuration titles.
# OPTION_MATCHER matches option titles.

ITEM_MATCHER = re.compile(r'^(\S+): (.+)')
OPTION_MATCHER = re.compile(r'^ +:(\d+): (.*about:[^:]+|[^:]+)(: (.+))?')

def is_comment(line):
    return line.startswith("#")

class Loader:

    def __init__(self):
        self.data = []
        self.config = ''

    def feed(self, line):
        line = line.rstrip()

        if is_comment(line):
            return

        matched = re.match(ITEM_MATCHER, line)
        if matched:
            return self.new_item(matched.group(1), matched.group(2))

        matched = re.match(OPTION_MATCHER, line)
        if matched:
            return self.new_option(matched.group(1), matched.group(2), matched.group(4))

        self.config += line[4:] + '\n'

    def new_item(self, id, title):
        self.flush()

        category, index = id.rsplit('-', 1)
        item = {
            'id':       id,
            'category': category,
            'index':    index,
            'title':    title,
            'options':  [],
        }
        self.data.append(item)

    def new_option(self, index, title, dependency):
        self.flush()
        if not dependency:
            dependency = ''

        last_item = self.data[-1]
        id = '%s-%s' % (last_item['id'], index)
        option = {
            'option_id':    id,
            'option_index': index,
            'option_title': title,
            'dependency':   dependency,
            'config':       '',
        }
        last_item['options'].append(option)

    def flush(self):
        if not self.data:
            return

        last_item = self.data[-1]
        if not last_item['options']:
            return

        last_option = last_item['options'][-1]
        last_option['config'] = self.config.strip()
        self.config = ''


# This class is for verification manuals. It reads verify.txt
# and returns a simple dictionary.

class VariableLoader:

    def __init__(self):
        self.data = {}
        self.key  = None

    def feed(self, line):
        line = line.rstrip()

        if is_comment(line):
            return

        if line.startswith("    "):
            if self.key:
                self.data[self.key] += line[4:] + '\n'
            return

        if ':' in line:
            key, value = line.split(':', maxsplit=1)
            self.key = key.strip()
            self.data[self.key] = value.strip()

        if self.key:
            self.data[self.key] += '\n'

    def flush(self):
        for key in self.data:
            self.data[key] = self.data[key].strip()


# And finally, we define a set of public functions with easy interfaces.
# For example, if you want to load verify.txt, do this:
#
#   import adlib
#   vars = adlib.load_variables("verify.txt")

def load(path):
    loader = Loader()

    with open(path) as fp:
        for line in fp:
            loader.feed(line)

    loader.flush()

    return loader.data

def load_as_dict(path):
    try:
        items = load(path)
    except IOError:
        return {}

    configs = OrderedDict()
    for item in items:
        for option in item['options']:
            configs[option['option_id']] = {
                'config':       option['config'],
                'option_title': option['option_title'],
                'dependency':   option['dependency'],
            }
    return configs

def load_variables(path):
    loader = VariableLoader()

    with open(path) as fp:
        for line in fp:
            loader.feed(line)

    loader.flush()

    return loader.data
