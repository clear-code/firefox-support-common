% Firefoxカスタマイズ内容の検証手順
% 株式会社クリアコード
% 20XX年X月X日

<!-- VERIFICATIONS ARE FROM HERE -->
<!--======================================================================-->

# はじめに

## 環境

- 対象のFirefoxのバージョンは{{firefox_version}}とする。
- 検証環境は{{windows_version}}とする。
- 参照する設定資料は{{configuration_sheet_name}}とする。

## 基本の設定

- メタインストーラの名称は `{{meta_installer_name}}`、ファイル名は `{{meta_installer_file_name}}` とする。
- メタインストーラの表示バージョンは{{meta_installer_version}}とする。
- Firefoxのインストール先は `{{install_path}}` とする。
- デスクトップのショートカットは `{{desktop_shortcut_path}}` に作成するものとする。
- スタートメニューのショートカットは `{{start_menu_shortcut_path}}` に作成するものとする。

{{#Admin-1-2 || Network-2-3 || Security-4-2 || Security-4-5}}
## 検証の準備

{{#is_upgrade}}
* 現行バージョンのFirefoxのセットアップ手順を確認し、現行環境を復元できる用意を整えておく。
{{/is_upgrade}}
{{#Admin-1-2}}
* リモート設定ファイルを参照できない環境で検証する場合、MCD用設定ファイルの「Admin-1-2」に対応する設定をコメントアウトし、ローカル設定ファイルのみを使用するように設定する。
{{/Admin-1-2}}
{{#Network-2-3}}
* プロキシ自動設定スクリプトを参照できない環境で検証する場合、「Network-2-3」でのPACファイルの参照先URLを `data:application/javascript,` と設定する。
{{/Network-2-3}}
{{#Security-4-2 || Security-4-5}}
* ポップアップの許可対象サイトを参照できない環境で検証する場合、ポップアップの許可対象サイト一覧に `example.com` を加えるよう設定する。
{{/Security-4-2 || Security-4-5}}
* 検証環境からインターネット上のWebサイトに接続できる状態にしておく。フィルタリングソフトウェア、ファイアウォール等で接続が制限されている場合、一部の検証を実施できない場合がある。
* 以下のページから検証用テストケース集をダウンロードし、検証環境に用意しておく。
  `https://github.com/clear-code/firefox-support-common/`
{{#Security-21}}
* 脆弱性があるバージョンのプラグインの自動無効化の挙動を確認するため、安全でないバージョンのプラグインのインストールが可能なようにしておく。
{{/Security-21}}

{{/Admin-1-2 || Network-2-3 || Security-4-2 || Security-4-5}}

<!--======================================================================-->

# インストール時の挙動に関するカスタマイズ

## インストーラの作成

### 確認する項目

{{#Install-2}} - Install-2-\* {{/Install-2}}
{{#Install-9}} - Install-9-\* {{/Install-9}}

### 検証

1. メタインストーラ作成キット一式を用意する。
    - 確認項目
{{#Install-2}}
        1. メタインストーラ作成キット一式の格納フォルダ名が `{{meta_installer_file_name}}` で始まる。(Install-2-\*)
{{/Install-2}}
1. 不要なファイルを削除する。
    - `{{meta_installer_file_name}}\*.exe`
1. fainstall.iniを開き、検証環境に合わせて内容を修正する。
    - フルパスが指定されている箇所で当該パスのドライブが存在しない場合、検証用としてファイル中の `（ドライブレター）:\` の指定をすべて `C:\（ドライブレター）\ `に置換する。
      以下、ファイルの作成先はすべて置換後のパスで読み替える。
1. `{{meta_installer_file_name}}.bat` を実行する。
{{#Install-9}}
    - 確認項目
{{#Install-9-1}}
        1. `{{meta_installer_file_name}}.exe` が作成される。(Install-9-1)
{{/Install-9-1}}
{{#Install-9-2}}
        1. `{{meta_installer_file_name}}-{{meta_installer_version}}.exe` が作成される。(Install-9-2)
{{/Install-9-2}}
{{/Install-9}}


{{#is_upgrade}}
## 現行環境への上書きインストール

### 確認する項目

{{#Install-7-2}} - Install-7-2{{/Install-7-2}}
{{#Admin-1-1 || Admin-1-2}} - Admin-1-1/2{{/Admin-1-1 || Admin-1-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. `{{meta_installer_file_name}}\*.exe` が作成済みの状態にする。
1. 現行バージョンのFirefoxがセットアップ済みの状態にしておく。
1. コントロールパネル→プログラムと機能で以下がインストールされているならばアンインストールする。
    1. {{meta_installer_name}}
1. 以下のファイル、フォルダを削除する。
    1. `C:\Program Files (x86)\ClearCode Inc`

### 検証

1. `{{meta_installer_file_name}}\*.exe` を実行する。
1. インストールされた環境が想定通りか確認する。
    - 確認項目
{{#Install-7-2}}
        1. `{{install_path}}\distribution` 内にファイルが設置されていた場合、それらがすべてFirefoxのインストーラにより削除されている。(Install-7-2)
{{/Install-7-2}}
{{#Admin-1-1 || Admin-1-2}}
        1. `{{install_path}}\*.cfg` の位置にあったファイルが、`{{install_path}}\*.cfg.backup.*`にリネームされている。(Admin-1-1/2)
        1. `{{install_path}}\defaults\pref\*.js` の位置にあったファイルが、`{{install_path}}\defaults\pref\*.js.backup.*`にリネームされている。(Admin-1-1/2)
{{/Admin-1-1 || Admin-1-2}}
{{/is_upgrade}}


## 新規インストール

### 確認する項目

{{#Install-1}} - Install-1-\* {{/Install-1}}
{{#Install-3}} - Install-3-\* {{/Install-3}}
{{#Install-4}} - Install-4-\* {{/Install-4}}
{{#Install-5}} - Install-5-\* {{/Install-5}}
{{#Install-6}} - Install-6-\* {{/Install-6}}
{{#Install-7}} - Install-7-\* {{/Install-7}}
{{#Install-8}} - Install-8-\* {{/Install-8}}
{{#Install-9}} - Install-9-\* {{/Install-9}}
{{#Install-10-2 || Install-10-3}} - Install-10-2/3 {{/Install-10-2 || Install-10-3}}
{{#Install-11}} - Install-11-\* {{/Install-11}}
{{#Application-1}} - Application-1-\* {{/Application-1}}
{{#Application-2}} - Application-2-\* {{/Application-2}}
{{#Application-3}} - Application-3-\* {{/Application-3}}
{{#Admin-1}} - Admin-1-\* {{/Admin-1}}
{{#Update-4}} - Update-4-\* {{/Update-4}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. `{{meta_installer_file_name}}\*.exe` が作成済みの状態にする。
1. コントロールパネル→プログラムと機能で以下がインストールされているならばアンインストールする。
    1. {{meta_installer_name}}
    1 Mozilla Firefox
    1. Mozilla Maintenance Service
1. 以下のファイル、フォルダを削除する。
    1. `{{install_path}}`
    1. `C:\Program Files (x86)\ClearCode Inc`
    1. Firefoxのユーザープロファイル（`%AppData%\Mozilla`）
    1. Firefoxのテンポラリファイルおよびキャッシュファイル（`%LocalAppData%\Mozilla`）

### 検証

1. `{{meta_installer_file_name}}\*.exe` を実行する。
    - 確認項目
        1. メタインストーラの圧縮ファイルを展開する様子を示すダイアログが表示される。
{{#Install-3-2}}
        1. メタインストーラのウィザードが表示される。(Install-3-2)
{{/Install-3-2}}
{{#Install-3-3}}
        1. メタインストーラのウィザードが表示されない。(Install-3-3)
{{/Install-3-3}}
{{#Install-4-1}}
        1. インストール完了後に完了を示すメッセージが表示されない。(Install-4-1)
{{/Install-4-1}}
{{#Install-4-2}}
        1. インストール完了後に「{{finish_title}}」のタイトルで「{{finish_message}}」のメッセージが表示される。(Install-4-2)
{{/Install-4-2}}
{{#Install-5-1}}
        1. インストール完了後に再起動を求めるメッセージが表示されない。(Install-5-1)
{{/Install-5-1}}
{{#Install-5-2}}
        1. インストール完了後に「{{restart_title}}」のタイトルで「{{restart_message}}」のメッセージが表示される。(Install-5-2)
{{/Install-5-2}}
<!--GROUP-->
6. インストールされた環境が想定通りか確認する。
    - 確認項目
{{#Install-8}}
        1. `{{install_path}}\firefox.exe` が存在する。(Install-8-\*)
{{/Install-8}}
{{#Admin-1}}
        1. `{{install_path}}\{{mcd_local_file}}` が存在する。(Admin-1-\*)
{{/Admin-1}}
{{#Application-1}}
        1. {{desktop_shortcut_path}} が{{#Application-1-1 || Application-1-3}}存在する。(Application-1-1/3){{/Application-1-1 || Application-1-3}}{{#Application-1-2}}存在しない。 (Application-1-2){{/Application-1-2}}
{{/Application-1}}
{{#Application-2}}
        1. {{start_menu_shortcut_path}} が{{#Application-2-1 || Application-2-3}}存在する。(Application-2-1/3){{/Application-2-1 || Application-2-3}}{{#Application-2-2}}存在しない (Application-2-2){{/Application-2-2}}
{{/Application-2}}
{{#Application-3}}
        1. Windows Vista以前のクイック起動バーにMozilla Firefoxのショートカットが{{#Application-3-1}}存在する。(Application-3-1){{/Application-3-1}}{{#Application-3-2}}存在しない。(Application-3-2){{/Application-3-2}}
{{/Application-3}}
{{#Install-10-2}}
        1. スタートメニュー上部のMozilla Firefoxのショートカットが更新されている。(Install-10-2)
{{/Install-10-2}}
{{#Install-10-3}}
        1. スタートメニュー上部のMozilla Firefoxのショートカットが存在しない。(Install-10-3)
{{/Install-10-3}}
{{#Install-11}}
        1. Windows Vista以降のタスクバーにMozilla Firefoxのショートカットが{{#Install-11-1}}存在する。(Install-11-1){{/Install-11-1}}{{#Install-11-2}}存在しない。(Install-11-2){{/Install-11-2}}
{{/Install-11}}
{{#Install-7}}
        1. コントロールパネル→プログラムと機能で、「Mozilla Firefox {{firefox_version}}」がインストールされている。（ベータ版を用いた検証の場合、バージョン表記は「beta」を除いた数字が期待される。）(Install-7-\*)
{{/Install-7}}
{{#Install-1}}
        1. コントロールパネル→プログラムと機能で、「{{meta_installer_name}}」がインストールされている。(Install-1-\*)
{{/Install-1}}
{{#Install-9-2}}
        1. コントロールパネル→プログラムと機能で、「{{meta_installer_name}}」のバージョンが「{{meta_installer_version}}」と表示されている。(Install-9-2)
{{/Install-9-2}}
{{#Update-4}}
        1. コントロールパネル→プログラムと機能で、「Mozilla Maintenance Service」がインストールされて{{#Update-4-1}}いる。(Update-4-1){{/Update-4-1}}{{#Update-4-2}}いない。(Update-4-2){{/Update-4-2}}
{{/Update-4}}
<!--/GROUP-->

## 専用ユーザープロファイルの作成と使用

- 専用ユーザープロファイルの作成先は `{{special_profile_path}}` とする。
- 専用ユーザープロファイルの名前は `{{special_profile_name}}` とする。

### 確認する項目

{{#Application-1-3}} - Application-1-3 {{/Application-1-3}}
{{#Application-2-3}} - Application-2-3 {{/Application-2-3}}
{{#Application-6-2}} - Application-6-2 {{/Application-6-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

{{#Application-6-2}}
1. Windowsエクスプローラ（フォルダウィンドウ）を開き、アドレスバーに `{{special_profile_path}}` と入力してEnterを押す。
    - 確認項目
        1. `{{special_profile_name}}` フォルダが存在する。(Application-6-2)
        2. フォルダの内容は空である。(Application-6-2)
{{/Application-6-2}}
{{#Application-1-3}}
1. `{{desktop_shortcut_path}}` のプロパティを開く。
    - 確認項目
        1. 作業フォルダが `"（Firefoxの実行ファイルがあるフォルダパス）"` である。(Application-1-3)
        2. 「リンク先」末尾に `-profile {{special_profile_path}}\{{special_profile_name}}` というオプションが指定されている。（環境変数の参照記法がそのまま含まれている）(Application-1-3)
{{/Application-1-3}}
{{#Application-2-3}}
1. `{{start_menu_shortcut_path}}` のプロパティを開く。
    - 確認項目
        1. 作業フォルダが `"（Firefoxの実行ファイルがあるフォルダパス）"` である。(Application-2-3)
        2. 「リンク先」末尾に `-profile {{special_profile_path}}\{{special_profile_name}}` というオプションが指定されている。（環境変数の参照記法がそのまま含まれている）(Application-2-3)
{{/Application-2-3}}
{{#Application-6-2}}
1. Windowsエクスプローラ（フォルダウィンドウ）を開き、アドレスバーに `{{special_profile_path}}\{{special_profile_name}}` と入力してEnterを押す。
1. `{{desktop_shortcut_path}}` をダブルクリックし、Firefoxを起動する。
    - 確認項目
        1. Firefoxの起動後、4で開いたフォルダに `prefs.js` などのファイルが作成される。(Application-6-2)
{{/Application-6-2}}

{{#Application-1-3 || Application-2-3 || Application-6}}
## 旧バージョンとの共存

### 確認する項目

{{#Install-7-2}} - Install-7-2 {{/Install-7-2}}
{{#Install-10-2}} - Install-10-2 {{/Install-10-2}}
{{#Application-1-3}} - Application-1-3 {{/Application-1-3}}
{{#Application-2-3}} - Application-2-3 {{/Application-2-3}}
{{#Application-6}} - Application-6-\* {{/Application-6}}

### 準備

1. コントロールパネル→プログラムと機能 で以下がインストールされているならばアンインストールする。
    1. {{meta_installer_name}}
    2. 旧バージョンのメタインストーラ
    3. Mozilla Firefox
    4. Mozilla Maintenance Service
1. 以下のファイル、フォルダを削除する。
    1. `{{install_path}}`
    1. 旧バージョンのメタインストーラによってインストールされたFirefox
    1. `C:\Program Files (x86)\ClearCode Inc`
    1. Firefoxのユーザープロファイル（`%AppData%\Mozilla`）
    1. Firefoxのテンポラリファイルおよびキャッシュファイル（`%LocalAppData%\Mozilla`）
    1. `{{desktop_shortcut_path}}`
    1. `{{start_menu_shortcut_path}}`
    1. クイック起動、タスクバー、およびスタートメニュー内に作成されたショートカット
3. 旧バージョン、新バージョンの各メタインストーラ作成キット内のバッチファイルを実行し、インストーラの実行ファイルを作成しておく。

### 検証

1. 旧バージョンのメタインストーラを実行する。
1. `{{desktop_shortcut_path}}` をダブルクリックし、Firefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「？」をクリックして、サブメニューから「Firefoxについて」を選択する。
    - 確認項目
        1. Firefoxのバージョンが旧バージョンのメタインストーラに同梱されたバージョンであると表示される。
1. ユーザが変更可能な何らかの設定を変更する。
    - 例：
        1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
        1. オプション画面の「検索」を開く。
        1. 「既定の検索エンジン」を「Google」から「Yahoo！JAPAN」に変更する。
1. Firefoxを終了する。
{{#Install-10-2}}
1. 旧バージョン起動用のショートカットをスタートメニューのよく使うアプリケーション一覧の上にドラッグし、「スタート メニューに表示する」の表示が出たらドロップする。
    - 確認項目
        1. スタートメニュー最上部に、ボーダーラインで区切られた状態で旧バージョン起動用のショートカットが表示される。
        1. 追加されたショートカットを右クリックして「プロパティ」を選択して開かれたショートカットのプロパティにおいて、ショートカットのリンク先が旧バージョンの実行ファイルの位置である。
{{/Install-10-2}}
1. 新バージョンのメタインストーラを実行する。
    - 確認項目
        1. `（旧バージョンのFirefoxのインストール先）\firefox.exe` が存在する。
        1. `（旧バージョンのFirefoxのインストール先）\ {{mcd_local_file}}` が存在する。
        1. `{{install_path}}\firefox.exe` が存在する。
{{#Admin-1-1 || Admin-1-2}}
        1. `{{install_path}}\{{mcd_local_file}}` が存在する。
{{/Admin-1-1 || Admin-1-2}}
1. `{{desktop_shortcut_path}}` をダブルクリックし、Firefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}
{{#Install-7-2}}
1. パネルメニューを開き、パネルメニュー内の「？」をクリックして、サブメニューから「Firefoxについて」を選択する。
    - 確認項目
        1. Firefoxのバージョンが{{firefox_version}}であると表示される。(Install-7-2){{/Install-7-2}}
1. 旧バージョンで変更した設定が{{#use_separate_profile}}初期状態になっている。{{/use_separate_profile}}{{^use_separate_profile}}維持されている。{{/use_separate_profile}}{{#Application-1}}(Application-1-3){{/Application-1}}{{#Application-2}}(Application-2-3){{/Application-2}}{{#Application-6}}(Application-6-\*){{/Application-6}}
    - 例：
        1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
        1. オプション画面の「検索」を開く。
        1. 「既定の検索エンジン」として{{#use_separate_profile}}「Google」が選択されている。{{/use_separate_profile}}{{^use_separate_profile}}「Yahoo！JAPAN」が選択されている。{{/use_separate_profile}}(Application-6-\*)
1. Firefoxを終了する。
{{#Install-10-2}}
1. スタートメニュー最上部に、ボーダーラインで区切られた状態で存在しているショートカットを右クリックして「プロパティ」を選択し、ショートカットのプロパティを開く。
    - 確認項目
        1. ショートカットのリンク先が新バージョンの実行ファイルの位置である。(Install-10-2){{/Install-10-2}}
1. 旧バージョンのメタインストーラを実行する。
    - 確認項目
        1. `（旧バージョンのFirefoxのインストール先）\firefox.exe` が存在する。
        1. `（旧バージョンのFirefoxのインストール先）\{{mcd_local_file}}` が存在する。
        1. `{{install_path}}\firefox.exe` が存在する。
{{#Admin-1-1 || Admin-1-2}}
        1. `{{install_path}}\{{mcd_local_file}}` が存在する。
{{/Admin-1-1 || Admin-1-2}}
1. `{{desktop_shortcut_path}}` をダブルクリックし、Firefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「？」をクリックして、サブメニューから「Firefoxについて」を選択する。
    - 確認項目
        1. Firefoxのバージョンが旧バージョンのメタインストーラに同梱されたバージョンであると表示される。
1. 旧バージョンで設定した設定が維持されている。(Application-1-3)(Application-2-3)(Application-6-\*)
    - 例：
        1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
        1. オプション画面の「検索」を開く。
        1. 「既定の検索エンジン」として「Yahoo！JAPAN」が選択されている。(Application-6-\*)

### 後始末

1. 新バージョンのメタインストーラを実行し、新バージョンのFirefoxが有効な状態に戻す。
{{/Application-1-3 || Application-2-3 || Application-6}}


<!--======================================================================-->

# 起動時の状態に関するカスタマイズ

## 起動時の状態の制御

### 確認する項目

{{#Admin-2}} - Admin-2-\* {{/Admin-2}}
{{#Admin-3}} - Admin-3-\* {{/Admin-3}}
{{#Admin-4-1}} - Admin-4-1 {{/Admin-4-1}}
{{#Startup-1}} - Startup-1-\* {{/Startup-1}}
{{#Startup-2}} - Startup-2-\* {{/Startup-2}}
{{#Startup-3}} - Startup-3-\* {{/Startup-3}}
{{#Startup-4-2}} - Startup-4-2 {{/Startup-4-2}}
{{#Startup-5-2}} - Startup-5-2 {{/Startup-5-2}}
{{#Startup-6}} - Startup-6-\* {{/Startup-6}}
{{#Startup-7}} - Startup-7-\* {{/Startup-7}}
{{#Startup-8}} - Startup-8-\* {{/Startup-8}}
{{#Startup-10-2}} - Startup-10-2 {{/Startup-10-2}}
{{#Update-4-2}} - Update-4-2 {{/Update-4-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. Firefoxのユーザープロファイル（`{{special_profile_path}}`）を削除する。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_disableupdate}}    1. Disable Auto-update{{/use_disableupdate}}
1. 導入対象のアドオンがない場合、「Disable Sync」もしくは何らかのアドオンを管理者権限でインストールするよう配置しておく。
   （「Disable Sync」の場合、ファイル `disablesync@clear-code.com.xpi` を `{{install_path}}\browser\extensions\` の位置に置く。）
1. システムの既定のブラウザを別のブラウザに設定する。
   例えばIEであれば、インターネットオプションから既定のブラウザに設定する。
   もしくは、Windowsのコントロールパネル内の既定のアプリの設定から、既定のブラウザをIEに設定する。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。{{^Startup-1}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1}}
    - 確認項目
{{#Startup-1}}
        1. Firefoxが起動した時に「設定移行ウィザード」が{{#Startup-1-1}}表示される。(Startup-1-1){{/Startup-1-1}}{{#Startup-1-2}}表示されない。(Startup-1-2){{/Startup-1-2}}
{{/Startup-1}}
{{#Startup-3}}
        1. Firefoxを既定のブラウザにするか{{#Startup-3-1}}尋ねられる。(Startup-3-1){{/Startup-3-1}}{{#Startup-3-2}}尋ねられない。(Startup-3-2){{/Startup-3-2}}
{{/Startup-3}}
{{#Startup-2-1}}
        1. 起動直後にFirefox既定のホーム画面が表示される。(Startup-2-1)
{{/Startup-2-1}}
{{#Startup-2-2 || Startup-2-3}}
        1. 起動直後に{{home_page}}が表示される。(Startup-2-2/3)
{{/Startup-2-2 || Startup-2-3}}
{{#Admin-2}}
        1. 導入対象のアドオンの有効化の可否を尋ねるタブが{{#Admin-2-1}}開かれている。(Admin-2-1){{/Admin-2-1}}{{#Admin-2-2}}開かれていない。(Admin-2-2){{/Admin-2-2}}
{{/Admin-2}}
{{#Admin-4}}
        1. `about:support` において、導入対象のアドオンが{{#Admin-4-1}}有効と表示される。(Admin-4-1){{/Admin-4-1}}{{#Admin-4-2}}無効と表示される。(Admin-4-2){{/Admin-4-2}}
{{/Admin-4}}
{{#Startup-6}}
1. ホームページのタブとして既定のホームページ（`about:home`）が開かれていない場合、ロケーションバーに `about:home` と入力し、ホームページを開く。
    - 確認項目
        1. 既定のホームページ内に「あなたの権利について……」のリンクおよび情報が{{#Startup-6-1}}表示される。(Startup-6-1){{/Startup-6-1}}{{#Startup-6-2}}表示されない。(Startup-6-2){{/Startup-6-2}}
{{/Startup-6}}
<!--GROUP-->
1. 任意のWebページを開く。
1. Webページ内のリンクをドラッグし、ツールバー上の「ホーム」ボタンにドロップする。
    - 確認項目
{{#Startup-2-2}}
        1. 「このWebページまたはファイルを新しいホームページに設定します。よろしいですか？」と問われ、「はい」を選択した後でツールバー上の「ホーム」ボタンをクリックすると、ドラッグ&ドロップしたリンク先のページが開かれる。(Startup-2-2)
{{/Startup-2-2}}
{{#Startup-2-3}}
        1. 「ホーム」ボタンへのドロップが不可能である。(Startup-2-3)
{{/Startup-2-3}}
<!--/GROUP-->
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Admin-3}}
        1. `extensions.shownSelectionUI` の値が{{#Admin-3-1}}存在しないか、`false`である。(Admin-3-1){{/Admin-3-1}}{{#Admin-3-2}}`true`である。(Admin-3-2){{/Admin-3-2}}
{{/Admin-3}}
{{#Startup-4-2}}
        1. `browser.startup.homepage_override.mstone` の値が `ignore` である。(Startup-4-2)
{{/Startup-4-2}}
{{#Startup-10-2}}
        1. `media.hardware-video-decoding.failed` の値が `true` に設定されている。(Startup-10-2)
{{/Startup-10-2}}
{{#Admin-3}}
1. 詳細設定において、`extensions.lastAppVersion` を `1.0` に変更する。
1. Firefoxを再起動する。
    - 確認項目
        1. アドオンの更新の確認が{{#Admin-3-1}}行われる。(Admin-3-1){{/Admin-3-1}}{{#Admin-3-2}}行われない。(Admin-3-2){{/Admin-3-2}}
{{/Admin-3}}
{{#Startup-5-2}}
1. メニューバーの「ブックマーク」を開く。
    - 確認項目
        1. 既定の項目が作成されていない。(Startup-5-2)
1. Firefoxのウィンドウのツールバー上で右クリックし、「ブックマークツールバー」を選択する。
    - 確認項目
        1. ブックマークツールバー上に既定の項目が作成されていない。(Startup-5-2)
{{/Startup-5-2}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
{{#Startup-3-2}}
1. オプション画面の「一般」を開く。
    - 確認項目
        1. 既定のブラウザの項目内の「起動時にFirefoxが既定のブラウザであるか確認する」のチェックが外れていて、無効化されている。(Startup-3-2)
{{/Startup-3-2}}
{{#Update-4-2}}
1. オプション画面の「詳細」を開き、「更新」を選択する。
    - 確認項目
        1. 「更新のインストールにバックグラウンドサービスを使用する」のチェックが存在しないか、チェックが外れており無効化されている。(Update-4-2)
{{/Update-4-2}}
1. Firefoxを終了する。
1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    - globalChrome.css{{/use_globalchromecss}}
{{#use_disableupdate}}    - Disable Auto-update{{/use_disableupdate}}
{{#use_globalchromecss}}
1. Firefoxを起動し、パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「一般」を開く。
    - 確認項目
{{#Startup-2-3}}
        1. 「現在のページを使用」「ブックマークを使う」「初期設定に戻す」ボタンが表示されていない。(Startup-2-3)
{{/Startup-2-3}}
{{#Startup-3-2}}
        1. 既定のブラウザの項目内の「起動時にFirefoxが既定のブラウザであるか確認する」のチェックおよび規定のブラウザに設定するボタンが表示されていない。(Startup-3-2)
{{/Startup-3-2}}
1. Firefoxを終了する。
{{/use_globalchromecss}}
{{#Startup-7}}
1. システムの時計を1年先の日付に進めてからFirefoxを起動する。
    - 確認項目
        1. 「お久しぶりです！ Firefoxはしばらく使われていないようです。プロファイルを掃除して新品のようにきれいにしますか？」というメッセージが{{#Startup-7-1}}表示される。（Startup-7-1）{{/Startup-7-1}}{{#Startup-7-2}}表示されない。（Startup-7-2）{{/Startup-7-2}}
1. Firefoxを終了する。
{{/Startup-7}}
{{#Startup-8}}
1. プロファイルを削除してからFirefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}ホームページを既定の状態から変更している場合は、`https://www.mozilla.org/ja/firefox/{{meta_installer_version}}/tour/` と入力し、ページを開く。
    - 確認方法
        1. UIツアーが{{#Startup-8-1}}開始される。(Startup-8-1){{/Startup-8-1}}{{#Startup-8-2}}開始されない。(Startup-8-2){{/Startup-8-2}}
{{/Startup-8}}

### 後始末

1. 導入対象のアドオンがなかった場合に検証用に導入したアドオンがあれば、削除する。
1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_disableupdate}}    1. Disable Auto-update{{/use_disableupdate}}

{{#Admin-4}}
## アドオンの署名確認の無効化

### 確認する項目

- Admin-4-*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
2. アドオンの未署名のインストールパッケージとして、テストケースの以下のファイルを用意する。  
   `unsigned-sample-addon@clear-code.com.xpi` 

### 検証

1. 用意したインストールパッケージを以下の位置に置く。  
   `{{install_path}}\browser\extensions\unsigned-sample-addon@clear-code.com.xpi` 
1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Admin-2-1}}
1. アドオンを有効化した上で、Firefoxを再起動する。
{{/Admin-2-1}}
    - 確認項目
        1. Firefoxのウィンドウ下部に白背景・青色文字で「hello, world!」というメッセージが{{#Admin-4-1}}表示されている。(Admin-4-1){{/Admin-4-1}}{{#Admin-4-2}}表示されない。(Admin-4-2){{/Admin-4-2}}

### 後始末

1. 以下の位置に設置したファイルを削除する。  
   `{{install_path}}\browser\extensions\unsigned-sample-addon@clear-code.com.xpi` 
{{/Admin-4}}

## 起動方法の制御

### 確認する項目

{{#Application-1-1 || Application-1-3}} - Application-1-1/3 {{/Application-1-1 || Application-1-3}}
{{#Application-2-1 || Application-2-3}} - Application-2-1/3 {{/Application-2-1 || Application-2-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Application-1}}
1. その状態のまま、`{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxの追加起動を試みる。
    - 確認項目
        1. {{^start_with_no_remote}}Firefoxの新しいウィンドウが開かれる。{{/start_with_no_remote}}{{#start_with_no_remote}}「Firefoxは起動していますが応答しません。」というメッセージが出て、Firefoxの新しいウィンドウが開かれない。{{/start_with_no_remote}}(Application-1-1/3)
1. Firefoxを終了する。
{{/Application-1}}
{{#Application-2}}
1. `{{start_menu_shortcut_path}}` をダブルクリックしてFirefoxを起動する。
1. その状態のまま、`{{start_menu_shortcut_path}}` をダブルクリックしてFirefoxの多重起動を試みる。
    - 確認項目
        1. {{^start_with_no_remote}}Firefoxの新しいウィンドウが開かれる。{{/start_with_no_remote}}{{#start_with_no_remote}}「Firefoxは起動していますが応答しません。」というメッセージが出て、Firefoxの新しいウィンドウが開かれない。{{/start_with_no_remote}}(Application-2-1/3)
{{/Application-2}}

## ウィンドウ名の制御

- メインウィンドウのタイトルは{{window_title}}とする。

### 確認する項目

{{#Application-4}} - Application-4-\* {{/Application-4}}
{{#Application-5}} - Application-5-\* {{/Application-5}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. タスクバー上に表示された項目にポインタを載せ、ジャンプリストを表示させる。
    - 確認項目
{{#Application-4}}
        1. 項目のタイトルが「{{window_title}}」で終わっている。（※確認できないときはスキップ）(Application-4-\*)
{{/Application-4}}
{{#Application-5}}
        1. タスクバー上の項目、もしくはジャンプリストの項目に指定のアイコンが表示されている。(Application-5-\*)
{{/Application-5}}
1. 前項で項目のタイトルを確認できない場合、Ctrl-Shift-ESCを押下し、タスクマネージャを起動して、「アプリケーション」タブを選択する。
    - 確認項目
{{#Application-4}}
        1. 項目のタイトルが「{{window_title}}」で終わっている。 (Application-4-\*)
{{/Application-4}}
{{#Application-5}}
        1. 項目に指定のアイコンが表示されている。(Application-5-\*)
{{/Application-5}}

<!--======================================================================-->

# セキュリティに関わるカスタマイズ

## 証明書の自動インポート

### 確認する項目

{{#Security-1-1}} - Security-1-1 {{/Security-1-1}}
{{#Security-1-3}} - Security-1-3 {{/Security-1-3}}
{{#Security-2 && Security-1-1}} - Security-2-\* {{/Security-2 && Security-1-1}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-1-3}}
1. Windowsの証明書データベースに、証明書（{{imported_certs}}）がインポートされた状態にしておく。
   この時、証明書はレジストリ上の以下の位置のいずれかに存在しているものとする。
    - `HKEY_LOCAL_MACHINE\Software\Microsoft\SystemCertificates\Root\Certificates`
    - `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\Root\Certificates`
    - `HKEY_LOCAL_MACHINE\Software\Microsoft\EnterpriseCertificates\Root\Certificates`
1. MCD設定ファイルに以下の設定を追加しておく。
    - `lockPref("logging.pipnss", 5);`
    - `lockPref("logging.config.sync", true);`
    - `lockPref("logging.config.add_timestamp", true);`
    - `lockPref("logging.config.clear_on_startup", true);`
    - `lockPref("logging.config.LOG_FILE","C:\\Users\\Public\\nss.log");`
1. `C:\Users\Public\nss.log-*` を全て削除しておく。
{{/Security-1-3}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Security-1-1}}
1. 「ツール」→「オプション」→「詳細」→「証明書」→「証明書を表示」ボタンから証明書マネージャを開く。
    - 確認項目
        1. インポートするよう設定した証明書（{{imported_certs}}）がすべて指定通りにインポートされている。 (Security-1-1)
{{/Security-1-1}}
{{#Security-2 && Security-1-1}}
1. インポートされた証明書（{{imported_certs}}）をすべて削除する。
1. Firefoxを再起動する。
1. 「ツール」→「オプション」→「詳細」→「証明書」→「証明書を表示」ボタンから証明書マネージャを開く。
    - 確認項目
        1. インポートするよう設定した証明書が{{#Security-2-1}}すべて指定通りにインポートされている。(Security-2-1){{/Security-2-1}}
{{#Security-2-2}}再インポートされていない。(Security-2-2){{/Security-2-2}}
{{/Security-2 && Security-1-1}}
{{#Security-1-3}}
1. `C:\Users\Public\nss.log-*` の位置に出力されたログファイルを開く。
    - 確認項目
        1. インポート対象の証明書（{{imported_certs}}）のすべてについて、`D/pipnss Imported '（証明書の一般名）'`というログが出力されている。(Security-1-3)
{{/Security-1-3}}

### 後始末

{{#Security-1-3}}
1. Windowsの証明書データベースに検証用に追加した証明書があれば、全て削除する。
1. MCD設定ファイルに追加した設定を全て削除する
1. `C:\Users\Public\nss.log-*` を全て削除する。
{{/Security-1-3}}

{{^Security-3-1}}
## アドオンの利用制限

### 確認する項目

- Security-3-2/3/4/5

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#Security-3-1 || Security-3-3 || Security-3-4}}
1. {{#Admin-4-1}}テストケースの `unsigned-sample-addon@clear-code.com.xpi` {{/Admin-4-1}}{{^Admin-4-1}}署名済みアドオンのインストールパッケージ{{/Admin-4-1}}を用意する。
{{/Security-3-1 || Security-3-3 || Security-3-4}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. アドオンのインストールを許可する対象のサイトを開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
{{#Security-3-2 || Security-3-5}}
        1. 「サイト別設定」タブで「アドオンのインストール」において「許可」にチェックが入っている。(Security-3-2/5)
        1. 「アドオンのインストール」を「ブロック」に変更してFirefoxを再起動し、再び同じページの「ページの情報」の「サイト別設定」タブを開いた時、「アドオンのインストール」において{{#Security-3-2}}「許可」にチェックが入っている。(Security-3-2){{/Security-3-2}}{{#Security-3-5}}「ブロック」にチェックが入っている。(Security-3-5){{/Security-3-5}}
{{/Security-3-2 || Security-3-5}}
<!--/GROUP-->
<!--GROUP-->
1. Firefoxのウィンドウにアドオンのインストールパッケージをドラッグ&ドロップする。
    - 確認項目
{{#Security-3-3 || Security-3-4}}
        1. 「ソフトウェアのインストールはシステム管理者により無効化されています。」と表示され、アドオンがインストールされない。(Security-3-3/4)
{{/Security-3-3 || Security-3-4}}
<!--/GROUP-->
{{#Security-3-4}}
1. アドオンマネージャを開く。
    - 確認項目
        1. 「アドオン入手」が表示されない。(Security-3-4)
        1. 歯車アイコンが表示されている場合、そのポップアップメニュー内に「ファイルからアドオンをインストール」が含まれない。(Security-3-4)
        1. 「拡張機能」タブが選択された状態で、アドオンマネージャ上にアドオンのインストールパッケージをドラッグ&ドロップして、アドオンがインストールされない。(Security-3-4)
        1. 「アドオンを検索」欄に「Tab」と入力してEnterすると、「利用可能なアドオン」の検索結果が何も表示されない。(Security-3-4)
{{/Security-3-4}}
{{#Security-3-3}}
{{#use_disableaddons}}
1. 以下の各方法でアドオンマネージャへのアクセスを試みる。
    - 確認項目
        1. パネルメニューに「アドオン」の項目が存在しない。
            (Security-3-3)
        1. パネルメニュー内の「カスタマイズ」をクリックした後の「追加のツールと機能」の項目一覧に「アドオン」の項目が存在しない。
            (Security-3-3)
        1. Alt-Tを押下して開いた「ツール」メニュー内に「アドオン」の項目が存在しない。
            (Security-3-3)
        1. ロケーションバーに `about:addons` と入力し、Alt-Enterして、タブが開かれない（開かれてもすぐ閉じられる）。
            (Security-3-3)
        1. ロケーションバーに `about:addons` と入力し、Enterして、何も起こらない（ページが読み込まれない）。
             (Security-3-3)
        1. ロケーションバーに `about:about` と入力しEnterして`about:`一覧を表示する。
        1. 「about:addons」
            のリンクを中クリックまたはCtrl-clickし、空白のページがタブで開かれるか、タブが開かれないか、タブが開かれてすぐに閉じられる。(Security-3-3)
        1. 「about:addons」
            のリンクを左クリックし、何も起こらないか、空白のページが読み込まれるか、タブが閉じられる。(Security-3-3)
{{/use_disableaddons}}
1. `https://addons.mozilla.org` を開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
        1. 「サイト別設定」タブで「アドオンのインストール」において「標準設定を使用する」にチェックが入っている。(Security-3-3)
1. `https://marketplace.firefox.com` を開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
        1. 「サイト別設定」タブで「アドオンのインストール」において「標準設定を使用する」にチェックが入っている。(Security-3-3)
{{/Security-3-3}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}

{{/Security-3-1}}

{{#Security-4}}
## 広告などのポップアップのブロック

### 確認する項目

- Security-4-\*

### 準備：

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    - カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証：

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. テストケースの `popupblock.html` を開く。
    - 確認項目
        1. ポップアップブロックの通知が{{^Security-4-3}}表示される。(Security-4-1/2/4/5){{/Security-4-3}}{{#Security-4-3}}表示されずに、タブまたはウィンドウが開かれる。(Security-4-3){{/Security-4-3}}
<!--/GROUP-->
{{#Security-4-2 || Security-4-5}}
1. ポップアップの許可対象のサイトを開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
        1. 「サイト別設定」タブで「ポップアップウィンドウを開く」において「許可」にチェックが入っている。(Security-4-2/5)
        1. 「ポップアップウィンドウを開く」を「ブロック」に変更してFirefoxを再起動し、再び同じページの「ページの情報」の「サイト別設定」タブを開いた時、「ポップアップウィンドウを開く」において{{#Security-4-2}}「許可」にチェックが入っている。(Security-4-2){{/Security-4-2}}{{#Security-4-5}}「ブロック」にチェックが入っている。(Security-4-5){{/Security-4-5}}
{{/Security-4-2 || Security-4-5}}
{{/Security-4}}

## 攻撃サイトに対する警告

### 確認する項目

{{#Security-5}} - Security-5-\* {{/Security-5}}
{{#Security-6}} - Security-6-\* {{/Security-6}}
{{#Hide-1}} - Hide-1 {{/Hide-1}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

{{#Security-5}}
1. Firefoxのロケーションバーに `https://itisatrap.org/firefox/its-an-attack.html` と入力し、Enterを押下する。
    - 確認項目
        1. 攻撃サイトとしてブロック{{#Security-5-1}}される。(Security-5-1){{/Security-5-1}}{{#Security-5-2}}されない。(Security-5-2){{/Security-5-2}}
1. Firefoxのロケーションバーに `http://itisatrap.org/firefox/unwanted.html` と入力し、Enterを押下する。
    - 確認項目
        1. 望ましくないソフトウェアの提供サイトとしてブロック{{#Security-5-1}}される。(Security-5-1){{/Security-5-1}}{{#Security-5-2}}されない。(Security-5-2){{/Security-5-2}}
{{#Security-5-2}}
1. 「{{special_profile_path}}\\{{special_profile_name}}\\safebrowsing」、もしくは「%LocalAppData%\\Mozilla\\Firefox\\Profiles\\（ランダムな文字列）.default\\safebrowsing」を開く。
    - 確認項目
        1. フォルダが空である。(Security-5-2)
{{/Security-5-2}}
{{/Security-5}}
{{#Security-6}}
1. Firefoxのロケーションバーに `http://itisatrap.org/firefox/its-a-trap.html` と入力し、Enterを押下する。
    - 確認項目
        1. 詐欺サイトとしてブロック{{#Security-6-1}}される。(Security-6-1){{/Security-6-1}}{{#Security-6-2}}されない。(Security-6-2){{/Security-6-2}}
{{/Security-6}}
<!--GROUP-->
{{#use_globalchromecss}}
1. 「ツール」→「オプション」{{^Hide-1}}→「セキュリティ」タブ{{/Hide-1}}を開く。
    - 確認項目
{{#Hide-1}}
        1. 「セキュリティ」タブが表示されていない。(Hide-1)
{{/Hide-1}}
{{^Hide-1}}
        1. 「セキュリティ」タブ内で詐欺コンテンツのブロックに関する設定項目が表示されていない。{{#Security-5-2}}(Security-5-2){{/Security-5-2}}{{#Security-6-2}}(Security-6-2){{/Security-6-2}}
{{/Hide-1}}
{{/use_globalchromecss}}
<!--/GROUP-->

## about:ページの利用制限

### 確認する項目

{{#Security-8-2}} - Security-8-2 {{/Security-8-2}}
{{#Security-9-2}} - Security-9-2 {{/Security-9-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    - カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-8-2}}
1. Security-8-2で何らかのabout:ページを無効化していない場合、検証のため、Disable About Somethingを用いて{{disabled_about_pages}}の使用を禁止しておく。
{{/Security-8-2}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Security-9-2}}
1. 以下の各方法でabout:configへのアクセスを試みる。(Security-9-2)
    - 確認項目
        1. ロケーションバーに`about:config`と入力し、Alt-Enterして、タブが開かれない（開かれてもすぐ閉じられる）。(Security-9-2)
        1. ロケーションバーに`about:config`と入力し、Enterして、何も起こらない（ページが読み込まれない）。(Security-9-2)
        1. ロケーションバーに`about:about`と入力しEnterして`about:`一覧を表示する。
        1. `about:config`のリンクを中クリックまたはCtrl-clickし、空白のページがタブで開かれるか、タブが開かれないか、タブが開かれてすぐに閉じられる。(Security-9-2)
        1. `about:config`のリンクを左クリックし、空白のページが読み込まれる。  (Security-9-2)
{{/Security-9-2}}
{{#Security-8-2}}
1. 以下の各方法で{{disabled_about_pages}}へのアクセスを試みる。(Security-8-2)
    - 確認項目
        1. ロケーションバーに`{{disabled_about_pages}}`と入力し、Alt-Enterして、タブが開かれない（開かれてもすぐ閉じられる）。(Security-8-2)
        1. ロケーションバーに`{{disabled_about_pages}}`と入力し、Enterして、何も起こらない（ページが読み込まれない）。(Security-8-2)
        1. ロケーションバーに`about:about`と入力しEnterして `about:` 一覧を表示する。
        1. {{disabled_about_pages}}のリンクを中クリックまたはCtrl-clickし、空白のページがタブで開かれるか、タブが開かれないか、タブが開かれてすぐに閉じられる。(Security-8-2)
        1. {{disabled_about_pages}}のリンクを左クリックし、何も起こらないか、空白のページが読み込まれるか、タブが閉じられる。(Security-8-2)
{{/Security-8-2}}

{{#Security-11}}
## SNS連携機能とソーシャルAPIの利用制限

### 確認する項目

- Security-11-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#use_globalchromecss}}
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
        1. 「このページを共有」ボタンが{{#Security-11-1}}存在する。(Security-11-1){{/Security-11-1}}{{#Security-11-2}}存在しない。(Security-11-2){{/Security-11-2}}
{{/use_globalchromecss}}
{{#Security-11-2}}
1. ロケーションバーに`https://activations.cdn.mozilla.net/ja/` と入力し、Enterを押してページを開く。
1. いずれかのサービスの「今すぐ追加」ボタンをクリックする。
    - 確認項目
        1. 何も起こらない。(Security-11-2)
{{/Security-11-2}}
{{/Security-11}}

{{#Security-12}}
## JavaScriptの実行制限

### 確認する項目

- Security-12-*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. テストケースの `popupblock.html` を開く。
    - 確認項目
{{#Security-12-1}}
        1. ポップアップが開かれるか、またはポップアップブロックの通知が表示される。(Security-12-1)
{{/Security-12-1}}
{{#Security-12-3}}
        1. 何も起こらない。ポップアップブロックの通知も表示されない。(Security-12-3)
{{/Security-12-3}}
{{/Security-12}}

## ローカルファイルの読み込みの制限

### 確認する項目

{{#Security-13}} - Security-13-\* {{/Security-13}}
{{#Security-14}} - Security-14-\* {{/Security-14}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Security-13}}
1. テストケースの `local-file-link.html` を、{{#Security-13-1}}ローカルファイルの読み込みを許可するサイト{{/Security-13-1}}{{#Security-13-2}}Web上{{/Security-13-2}}に設置してから開き、ページ内のリンクをクリックする。{{#Security-13-2}}  
   （例： `http://www.clear-code.com/temp/local-file-link.html` ）{{/Security-13-2}}
    - 確認項目
{{#Security-13-1}}
        1. `C:\file.txt` の位置に置いたファイルの内容が読み込まれる。(Security-13-1)
{{/Security-13-1}}
{{#Security-13-2}}
        1. 何も起こらない（読み込みがブロックされる）。(Security-13-2)
{{/Security-13-2}}
{{/Security-13}}
{{#Security-14}}
1. テストケースの `cross-directory.html` について、`../configuration-sheets/constumize-item-list.csv` の位置にファイルがある事を確認した上で、ファイルを開く。
    - 確認項目
{{#Security-14-1}}
        1. `./cross-directory.html` および `../configuration-sheets/constumize-item-list.csv` の結果が `200` と表示される。(Security-14-1)
{{/Security-14-1}}
{{#Security-14-2}}
        1. `./cross-directory.html` の結果は `200` 、`../configuration-sheets/constumize-item-list.csv` の結果はエラーが表示される。(Security-14-2)
{{/Security-14-2}}
{{/Security-14}}

{{#Security-15-2}}
## バックグラウンドで行われる通信の制限

### 確認する項目

- Security-15-2
{{#Security-3-3 || Security-3-4}}   - Security-3-3/4 {{/Security-3-3 || Security-3-4}}
{{#Security-5-2}}   - Security-5-2 {{/Security-5-2}}
{{#Security-10-2 && firefox45_or_older}}  - Security-10-2 {{/Security-10-2 && firefox45_or_older}}
{{#Security-11-2}}   - Security-11-2 {{/Security-11-2}}
{{#Security-18-2}}   - Security-18-2 {{/Security-18-2}}
{{#Security-19-2}}   - Security-19-2 {{/Security-19-2}}
{{#Security-21-2}}   - Security-21-2 {{/Security-21-2}}
{{#Security-25-2}}   - Security-25-2 {{/Security-25-2}}
{{#Security-26-2}}   - Security-26-2 {{/Security-26-2}}
{{#Security-27-2}}   - Security-27-2 {{/Security-27-2}}
{{#Security-28-2}}   - Security-28-2 {{/Security-28-2}}
{{#Security-31-2}}   - Security-31-2 {{/Security-31-2}}
{{#Privacy-15-2}}   - Privacy-15-2 {{/Privacy-15-2}}
{{#Privacy-18-2}}   - Privacy-18-2 {{/Privacy-18-2}}
{{#Privacy-19-2}}   - Privacy-19-2 {{/Privacy-19-2}}
{{#Privacy-22-2}}   - Privacy-22-2 {{/Privacy-22-2}}
{{#Privacy-24-2}}   - Privacy-24-2 {{/Privacy-24-2}}
{{#Privacy-25-2 && firefox45_or_older}}  - Privacy-25-2 {{/Privacy-25-2 && firefox45_or_older}}
{{#Privacy-31-2}}   - Privacy-31-2 {{/Privacy-31-2}}
{{#Privacy-33-3}}   - Privacy-33-3 {{/Privacy-33-3}}
{{#Startup-8-2}}   - Startup-8-2 {{/Startup-8-2}}
{{#Update-1-3}}   - Update-1-3 {{/Update-1-3}}
{{#Update-2-2}}   - Update-2-2 {{/Update-2-2}}
{{#Plugin-8-2}}   - Plugin-8-2 {{/Plugin-8-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. Firefoxのユーザープロファイル（`{{special_profile_path}}`）を削除する。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}
2. ロケーションバーに`about:blank`と入力し、空のページを開く。
3. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）→「開発ツールを表示」で開発ツールを表示する。
4. 開発ツール右上の歯車アイコンをクリックする。
5. 「ブラウザとアドオンのデバッガを有効」と「リモートデバッガを有効」にチェックを入れる。
6. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）→「ブラウザツールボックス」でブラウザツールボックスを開く。途中、リモートデバッグの接続許可を求められるので「OK」をクリックする。
7. ブラウザツールボックスで「ネットワーク」を選択する。
8. ブラウザツールボックス内の「再読み込み」ボタンをクリックする。
9. そのまま10分放置する。
    - 確認項目
        1. 一切のネットワーク通信が記録されない。(Security-15-2)

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{/Security-15-2}}

## 外部リソースへのアクセスの制限

### 確認する項目

{{#Security-15-2}} - Security-15-2 {{/Security-15-2}}
{{#Security-18-2}} - Security-18-2 {{/Security-18-2}}
{{#Security-19-2}} - Security-19-2 {{/Security-19-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. パネルメニューからツールバーのカスタマイズ画面を開く。
    - 確認項目
{{#Security-18-2}}
        1. 「テーマ」内の「その他のテーマを入手」をクリックしても何も起こらない。{{#Security-15-2}}(Security-15-2){{/Security-15-2}}(Security-18-2)
{{/Security-18-2}}
{{#Security-19-2}}
        1. 「テーマ」内の「おすすめ」に何も項目が表示されない。{{#Security-15-2}}(Security-15-2){{/Security-15-2}}(Security-19-2)
{{/Security-19-2}}
<!--/GROUP-->
{{#Security-15-2}}
1. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）→「WebIDE」でWebIDEを開く。
1. メニューの「プロジェクト」→「追加のコンポーネントを管理」を開く。
    - 確認項目
        1. 無反応である、もしくはツールアダプタアドオンが準備中になっている。(Security-15-2)
{{/Security-15-2}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

{{#Security-20-2}}
## パーミッション設定の制限

### 確認する項目

- Security-20-2

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `https://addons.mozilla.org` と入力し、ページを開く。
1. ページの読み込みが完了したら、ロケーションバー上の鍵アイコンの箇所をクリックする。
    - 確認項目
        1. パネル上に「サイト別設定」が表示されない。(Security-20-2)
{{#firefox45_or_older}}
        1. パネル右の「\>」をクリックした先の画面で「詳細を表示」ボタンが表示されない。(Security-20-2)
{{/firefox45_or_older}}
1. ページ上のコンテキストメニューから「ページの情報を表示」を選択する。
    - 確認項目
        1. 「サイト別設定」タブが表示されない。(Security-20-2)
{{/Security-20-2}}

{{#Security-16}}
## フルスクリーン表示の制限

### 確認する項目

- Security-16-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1.  `http://www.w3schools.com/html/html5\_video.asp` を開く。
    - 確認項目
        1. 動画のコントロール内にフルスクリーン表示切り替え用ボタンが表示されている。（Security-16-1)
           または、表示されていない。（Security-16-3）
{{/Security-16}}

{{#Security-21}}
## アドオンとプラグインのブロックリストの使用の可否

### 確認する項目

- Security-21-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
1. Silverlightのバージョン一覧から、セキュリティ上の脆弱性があるバージョンとして「Silverlight 5 Build 5.1.41105.0 Released December 8, 2015」またはそれより古いいずれかのバージョンを以下のページからダウンロードし、インストールしておく。  
   https://www.microsoft.com/getsilverlight/locale/en-us/html/Microsoft%20Silverlight%20Release%20History.htm
   <!--↑`〜`で括ると改行されなくなってしまうので、地のテキストとしています。注意。-->

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. アドオンマネージャを開き、「プラグイン」ペインを選択する。
    - 確認項目
        1. Silverlightの項目に対し、安全でないバージョンである旨の警告が<!--表示されている。（Security-21-1)
           または、-->表示されていない。（Security-21-2）

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
1. 検証のためにインストールしたSliverlightプラグインをアンインストールする。
{{/Security-21}}

{{#Security-23}}
## プラグインのサンドボックス内実行

### 確認する項目

- Security-23-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに`about:config`と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
        1. `dom.ipc.plugins.sandbox-level.default` の値が{{#Security-23-1 || Security-23-2}}`0`である。(Security-23-1/2){{/Security-23-1 || Security-23-2}}{{#Security-23-3}}`1`である。(Security-23-3){{/Security-23-3}}
        1. `dom.ipc.plugins.sandbox-level.flash` の値が{{#Security-23-1}}`0`である。(Security-23-1){{/Security-23-1}}{{#Security-23-2 || Security-23-3}}`1`である。(Security-23-2/3){{/Security-23-2 || Security-23-3}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{/Security-23}}

{{#Security-25}}
## プロトコルごとの外部Webアプリケーションへの連携

### 確認する項目

- Security-25-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
3. オプション画面の「プログラム」を開く。
    - 確認項目
        1. ファイルの種類「irc」「ircs」「mailto」「webcal」のそれぞれについて、選択肢として{{#Security-25-1}}Webアプリケーション名が表示される。（Security-25-1）{{/Security-25-1}}{{#Security-25-2}}「毎回確認する」と「他のプログラムを選択する...」の2つだけが表示される。（Security-25-2）{{/Security-25-2}}
{{/Security-25}}

## ダウンロードしたファイルの保護

### 確認する項目

{{#Security-26}} - Security-26-\* {{/Security-26}}
{{#Security-27}} - Security-27-\* {{/Security-27}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. フィルタリングソフトなどにより危険なソフトウェアのダウンロードがブロックされる場合は実際の動作での検証が不可能なため、安全でない実行ファイルのダウンロードが可能な状態にしておく。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `http://testsafebrowsing.appspot.com/` と入力し、ページを開く。
1. 「Desktop Download Warnings」セクションの「1. Should show a "malicious" warning, based on URL」のリンクをクリックする。
1. ファイルの取り扱いを尋ねられるので、ファイルとして保存するよう指示し、ダウンロード完了を待つ。
1. ダウンロードボタンをクリックし、ダウンロードの一覧を開く。
    - 確認項目
        1. ダウンロード一覧の一番上の項目に{{#Security-26-1}}「このファイルはウイルスやマルウェアが含まれています。」という警告のメッセージが表示される。（Security-26-1）{{/Security-26-1}}{{#Security-26-2}}特に警告のメッセージは表示されない。（Security-26-2）{{/Security-26-2}}
1. 「Desktop Download Warnings」セクションの「5. Should show an "uncommon" warning, for .exe」のリンクをクリックする。
1. ファイルの取り扱いを尋ねられるので、ファイルとして保存するよう指示し、ダウンロード完了を待つ。
1. ダウンロードボタンをクリックし、ダウンロードの一覧を開く。
    - 確認項目
        1. ダウンロード一覧の一番上の項目に{{#Security-27-1}}「このファイルを開くのは危険です。」という警告のメッセージが表示される。（Security-27-1）{{/Security-27-1}}{{#Security-27-2}}特に警告のメッセージは表示されない。（Security-27-2）{{/Security-27-2}}
1. フィルタリングソフトなどにより危険なソフトウェアのダウンロードがブロックされる場合、実際の挙動での検証が不可能のため、`about:config` もしくは `about:support` で以下の設定の反映状況のみ確認する。
    - 確認項目
{{#Privacy-26}}
        1. `browser.safebrowsing.download.enabled` が{{#Privacy-26-1}} `true` である。(Privacy-26-1){{/Privacy-26-1}}{{#Privacy-26-2}} `false` である。(Privacy-26-2){{/Privacy-26-2}}
{{/Privacy-26}}
{{#Privacy-27}}
        1. `browser.safebrowsing.downloads.remote.block_potentially_unwanted` と  `browser.safebrowsing.downloads.remote.block_uncommon` がどちらも{{#Privacy-27-1}} `true` である。(Privacy-27-1){{/Privacy-27-1}}{{#Privacy-27-2}} `false` である。(Privacy-27-2){{/Privacy-27-2}}
{{/Privacy-27}}


## その他のセキュリティに関わる設定

### 確認する項目

{{#Security-28}} - Security-28-\* {{/Security-28}}
{{#Security-29}}- Security-29-\* {{/Security-29}}
{{#Security-30}}- Security-30-\* {{/Security-30}}
{{#Security-31}} - Security-31-\* {{/Security-31}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに`about:config`と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
        1. `network.captive-portal-service.enabled` の値が{{#Security-28-1}}`true`である。(Security-28-1){{/Security-28-1}}{{#Security-28-2}}`false`である。(Security-28-2){{/Security-28-2}}
        1. `network.cookie.leave-secure-alone` の値が{{#Security-29-1}}`false`である。(Security-29-1){{/Security-29-1}}{{#Security-29-2}}`true`である。(Security-29-2){{/Security-29-2}}
        1. `security.block_script_with_wrong_mime` の値が{{#Security-30-1}}`false`である。(Security-30-1){{/Security-30-1}}{{#Security-30-2}}`true`である。(Security-30-2){{/Security-30-2}}
        1. `browser.safebrowsing.blockedURIs.enabled` の値が{{#Security-31-1}}`false`である。(Security-31-1){{/Security-31-1}}{{#Security-31-2}}`true`である。(Security-31-2){{/Security-31-2}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

<!--======================================================================-->

# プライバシー情報に関わるカスタマイズ

## プライバシー情報の利用制限

### 確認する項目

{{#Privacy-1}} - Privacy-1-* {{/Privacy-1}}
{{#Privacy-2-2}} - Privacy-2-2 {{/Privacy-2-2}}
{{#Privacy-3-2}} - Privacy-3-2 {{/Privacy-3-2}}
{{#Privacy-4-2}} - Privacy-4-2 {{/Privacy-4-2}}
{{#Privacy-5-2}} - Privacy-5-2 {{/Privacy-5-2}}
{{#Privacy-6-2 || Privacy-6-3 || Privacy-6-4}} - Privacy-6-2/3/4 {{/Privacy-6-2 || Privacy-6-3 || Privacy-6-4}}
{{#Privacy-7}} - Privacy-7-\* {{/Privacy-7}}
{{#Privacy-8-2}} - Privacy-8-2 {{/Privacy-8-2}}
{{#Privacy-10-2}} - Privacy-10-2 {{/Privacy-10-2}}
{{#Privacy-12}} - Privacy-12-\* {{/Privacy-12}}
{{#Privacy-13}} - Privacy-13-\* {{/Privacy-13}}
{{#Privacy-15-2}} - Privacy-15-2 {{/Privacy-15-2}}
{{#Privacy-16}} - Privacy-16-\* {{/Privacy-16}}
{{#Privacy-17}} - Privacy-17-\* {{/Privacy-17}}
{{#Privacy-18-2}} - Privacy-18-2 {{/Privacy-18-2}}
{{#Privacy-19-2}} - Privacy-19-2 {{/Privacy-19-2}}
{{#Privacy-20}} - Privacy-20-\* {{/Privacy-20}}
{{#Privacy-21-2}} - Privacy-21-2 {{/Privacy-21-2}}
{{#Privacy-31-2}} - Privacy-31-2 {{/Privacy-31-2}}
{{#Privacy-32}} - Privacy-32-\* {{/Privacy-32}}
{{#Privacy-33-2 || Privacy-33-3}} - Privacy-33-2/3 {{/Privacy-33-2 || Privacy-33-3}}
{{#Privacy-35}} - Privacy-35-\* {{/Privacy-35}}
{{#Privacy-36}} - Privacy-36-\* {{/Privacy-36}}
{{#Privacy-37}} - Privacy-37-\* {{/Privacy-37}}
{{#Privacy-38}} - Privacy-38-\* {{/Privacy-38}}
{{#Privacy-39}} - Privacy-39-\* {{/Privacy-39}}
{{#Privacy-40}}{{^Privacy-5-2}} - Privacy-40-\* {{/Privacy-5-2}}{{/Privacy-40}}
{{#Privacy-33-2 && Privacy-41}} - Privacy-41-\* {{/Privacy-33-2 && Privacy-41}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. Firefoxのユーザープロファイル（`{{special_profile_path}}`）を削除する。
1. Firefoxのテンポラリファイルおよびキャッシュファイル（`%LocalAppData%\Mozilla`）を削除する。
1. 以下のアドオンを無効化する。
{{#use_disableabotuconfig}}    1. Disable about:config{{/use_disableabotuconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{#Privacy-32 || Privacy-37}}
1. MCD設定ファイルに以下の設定を追加しておく。
    - `lockPref("logging.nsHttp", 5);`
    - `lockPref("logging.NetworkPredictor", 5);`
    - `lockPref("logging.config.sync", true);`
    - `lockPref("logging.config.add_timestamp", true);`
    - `lockPref("logging.config.LOG_FILE","C:\\Users\\Public\\http.log");`
1. `C:\Users\Public\http.log-*` を全て削除しておく。
1. 先読み対象となるページのホスト名がプライベートIPアドレスに解決される環境においては、先読み機能が作用せず実際の動作での検証が不可能なため、グローバルIPアドレスでWebサイトに接続可能な状態にしておく。
{{/Privacy-32 || Privacy-37}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}
{{#Privacy-36}}
1. テンポラリファイルおよびキャッシュファイルフォルダ内の `thumbnails` フォルダを開いて、`https://addons.mozilla.org/` サイト内のリンクを何度か遷移する。
    - 確認項目
        1. サムネイル画像が{{#Privacy-36-1}}保存される。（Privacy-36-1）{{/Privacy-36-1}}{{#Privacy-36-2}}保存されない。（Privacy-36-2）{{/Privacy-36-2}}
{{/Privacy-36}}
{{#Privacy-33-2 && Privacy-41}}
1. ブラウザウィンドウで `http://www.kantei.go.jp/` を開く。
    - 確認項目
        1. トラッキング保護機能が働いた旨の通知ポップアップが{{#Privacy-41-1}}表示される。(Privacy-41-1){{/Privacy-41-1}}{{#Privacy-41-2}}表示されない。(Privacy-41-2){{/Privacy-41-2}}
{{/Privacy-33-2 && Privacy-41}}
{{#Privacy-35-3 || Privacy-35-4}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「プライバシー」を開く。
    - 確認項目
        1. 「ブロックリストを変更」ボタンが無効化されている。（Privacy-35-3/4）
1. Firefoxを終了し、MCD用設定ファイル内の以下の行をコメントアウトする。（Privacy-35-3/4）
    * `lockPref("pref.privacy.disable_button.change_blocklist", true);`
1. Firefoxを起動する。
{{/Privacy-35-3 || Privacy-35-4}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「プライバシー」を開く。
    - 確認項目
{{#Privacy-20}}
        1. 「Do Not Trackの設定を管理」リンクをクリックして開かれたダイアログ内で、「Do Not Trackを常に有効にする」の{{#Privacy-20-1 || Privacy-20-2}}チェックが入っている。 (Privacy-20-1/2){{/Privacy-20-1 || Privacy-20-2}}{{#Privacy-20-3 || Privacy-20-4}}チェックが外れている。 (Privacy-20-3/4){{/Privacy-20-3 || Privacy-20-4}}
{{/Privacy-20}}
{{#Privacy-1}}
{{#Privacy-1-2 || Privacy-1-5}}
        1. 「履歴」で「Firefoxに履歴を記憶させる」が選択されているか、「記憶させる履歴を詳細設定」で「常にプライベートブラウジングモード」のチェックが外れていて選択不可になっている。(Privacy-1-2/5)
{{/Privacy-1-2 || Privacy-1-5}}
{{#Privacy-1-3}}
        1. 「履歴」で「Firefoxに履歴を一切記憶させない」が選択されているか「記憶させる履歴を詳細設定」で「常にプライベートブラウジングモード」のチェックが入っていて選択不可になっている。(Privacy-1-3) 
{{/Privacy-1-3}}
        1. 「履歴」で「Firefoxの終了時に履歴を消去する」の{{#Privacy-1-2 || Privacy-1-3}}チェックが外れていて選択不可になっている。(Privacy-1-2/3){{/Privacy-1-2 || Privacy-1-3}}{{#Privacy-1-4}}チェックが入っていて選択不可になっている。(Privacy-1-4){{/Privacy-1-4}}{{#Privacy-1-5}}チェックが外れていて選択可能になっている。(Privacy-1-5){{/Privacy-1-5}}
{{#Privacy-1-4}}
        1. 「Firefoxの終了時に履歴を消去する」の「設定」で、指定した項目にチェックが入って選択不可になっている。(Privacy-1-4)
{{/Privacy-1-4}}
{{/Privacy-1}}
{{#Privacy-35}}
        1. 「ブロックリストを変更」ボタンを押して表示されるブロックリストの選択で、{{#Privacy-35-1 || Privacy-35-3}}「簡易ブロック」が選択されている。（Privacy-35-1/3）{{/Privacy-35-1 || Privacy-35-3}}{{#Privacy-35-2 || Privacy-35-4}}「広範ブロック」が選択されている。（Privacy-35-2/4）{{/Privacy-35-2 || Privacy-35-4}}
{{/Privacy-35}}
<!--GROUP-->
1. オプション画面の「詳細」→「ネットワーク」を開く。
    - 確認項目
{{#Privacy-6-3}}
        1. 「Webサイトがオフライン作業用のデータの保存を求めてきたときに知らせる」のチェックが外れていて選択不可になっている。(Privacy-6-3)
{{/Privacy-6-3}}
{{#Privacy-6-2 || Privacy-6-4}}
        1. 「オフライン作業用のデータの保存を許可しているウェブサイト」のリストに、オフラインデータの保存を確認無しで許可するよう指定したサイトが表示されている。(Privacy-6-2/4)
{{/Privacy-6-2 || Privacy-6-4}}
<!--/GROUP-->
<!--GROUP-->
1. オプション画面の「詳細」の「データの選択」を開く。
    - 確認項目
{{#Privacy-18-2}}
        1. 「Firefoxヘルスレポートを有効にする」のチェックが外れている。(Privacy-18-2)
        1. 「追加データを共有する（パフォーマンス情報など）」のチェックが外れている。(Privacy-18-2)
{{/Privacy-18-2}}
{{#Privacy-21-2}}
        1. 「Firefoxに、あなたに代わって未送信のクラッシュレポートを送信するのを許可する」のチェックが外れている。(Privacy-21-2)
{{/Privacy-21-2}}
<!--/GROUP-->
{{#Privacy-35-3 || Privacy-35-4}}
1. Firefoxを終了し、MCD用設定ファイル内の以下の行をコメントアウト状態から復帰させる。
    * `// lockPref("pref.privacy.disable_button.change_blocklist", true);`
1. Firefoxを起動する。
{{/Privacy-35-3 || Privacy-35-4}}
1. テストケースの `password.html` を開く。
<!--GROUP-->
1. ユーザID、パスワードを入力して送信する。
    - 確認項目
{{#Privacy-5-2}}
        1. パスワードの保存を尋ねられない。(Privacy-5-2)
        1. ファイルを再読み込みしてもパスワードが自動入力されない。(Privacy-5-2)
        1. ユーザID入力欄をダブルクリックしても入力履歴が表示されない。(Privacy-2-2)
{{/Privacy-5-2}}
{{^Privacy-5-2}}
{{#Privacy-40-1}}
        1. パスワードの保存を提案するポップアップが表示され、その中に「パスワードを開示」チェックボックスが表示される。（Privacy-40-1）
{{/Privacy-40-1}}
{{#Privacy-40-2}}
        1. 「パスワードを開示」チェックボックスが表示されない。（Privacy-40-2）
{{/Privacy-40-2}}
{{/Privacy-5-2}}
<!--/GROUP-->
{{#Privacy-3-2}}
1. ファイルに名前を付けて保存し、Firefoxを再起動する。
    - 確認項目
        1. 「履歴」→「すべての履歴を表示」で「ダウンロード」の一覧に項目が存在しない。(Privacy-3-2)
{{/Privacy-3-2}}
{{#Privacy-4-2}}
1. ロケーションバーに `password` と入力する。
    - 確認項目
        1. ロケーションバーのオートコンプリートの項目が表示されない。(Privacy-4-2)
{{/Privacy-4-2}}
{{#Privacy-39}}
1. テストケースの `insecure-password.html` を開く。
1. パスワードの入力欄にフォーカスを移す。
    - 確認項目
        1. 安全でないフォームである旨の警告のメッセージが{{#Privacy-39-1}}表示される。(Privacy-39-1){{/Privacy-39-1}}{{#Privacy-39-2}}表示されない。（Privacy-39-2）{{/Privacy-39-2}}
{{/Privacy-39}}
{{#Privacy-12}}
1. テストケースの `storage.html` を開く。
    - 確認項目
        1. {{#Privacy-12-1}}`window.localStorage = [object Storage]` と出力される。(Privacy-12-1){{/Privacy-12-1}}{{#Privacy-12-2}}`window.localStorage = null` と表示される。(Privacy-12-2){{/Privacy-12-2}}
{{/Privacy-12}}
{{#Privacy-13}}
1. テストケースの `indexed-db.html` を開く。
    - 確認項目
        1. {{#Privacy-13-1}}`enabled` と出力される。(Privacy-13-1){{/Privacy-13-1}}{{#Privacy-13-2}}`disabled` と表示される。(Privacy-13-2){{/Privacy-13-2}}
{{/Privacy-13}}
{{#Privacy-38}}
1. テストケースの `beacon.html` を開く。
    - 確認項目
        1. {{#Privacy-38-1}}`enabled` と出力される。(Privacy-38-1){{/Privacy-38-1}}{{#Privacy-38-2}}`disabled` と表示される。(Privacy-38-2){{/Privacy-38-2}}
{{/Privacy-38}}
1. ロケーションバーに`about:config`と入力し、詳細設定一覧を開く。
<!--GROUP-->
1. 各設定値を確認する。
    - 確認項目
{{#Privacy-8-2}}
        1. `places.history.expiration.max_pages` の値が `{{history_expiration_max_pages}}` である。(Privacy-8-2)
{{/Privacy-8-2}}
{{#Privacy-15-2}}
        1. `browser.search.geoip.url` の値が空文字である。(Privacy-15-2)
{{/Privacy-15-2}}
{{#Privacy-19-2}}
        1. `security.ssl.errorReporting.automatic` の値が`false`である。(Privacy-19-2)
        1. `security.ssl.errorReporting.enabled` の値が`false`である。(Privacy-19-2)
        1. `security.ssl.errorReporting.url` の値が空文字である。(Privacy-19-2)
{{/Privacy-19-2}}
{{#Privacy-31-2}}
        1. `browser.selfsupport.url` の値が空文字である。(Privacy-31-2)
{{/Privacy-31-2}}
{{#Privacy-33-2 || Privacy-33-3}}
        1. `privacy.trackingprotection.enabled` の値が{{#Privacy-33-2}}`true`である。(Privacy-33-2){{/Privacy-33-2}}{{#Privacy-33-3}}`false`である。(Privacy-33-3){{/Privacy-33-3}}
        1. `privacy.trackingprotection.pbmode.enabled` の値が{{#Privacy-33-2}}`true`である。(Privacy-33-2){{/Privacy-33-2}}{{#Privacy-33-3}}`false`である。(Privacy-33-3){{/Privacy-33-3}}
{{/Privacy-33-2 || Privacy-33-3}}
<!--/GROUP-->
1. 以下の設定を行う。既存の値がない場合は新規に作成する。
{{#Privacy-16}}
    - `network.dns.notifyResolution`（真偽型）を`true`に設定する。
{{/Privacy-16}}
    - `devtools.chrome.enabled`（真偽型）を`true`に設定する。
1. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）をクリックして、サブメニューの「ブラウザコンソール」をクリックする。
{{#Privacy-16}}
1. 以下のコードをコンソール内で実行する。
    - `Services.obs.addObserver(function(aSubject, aTopic, aData) { console.log(aTopic+': '+aData); }, 'dns-resolution-request', false);`
{{/Privacy-16}}
1. コンソール上の「ネットワーク」が選択された状態にする。すでに選択されていた場合は、一旦未選択状態に戻し、再度選択する。
{{#Privacy-7}}
1. ブラウザウィンドウで `http://www.clear-code.com/blog/2016/5/10.html` を開く。
    - 確認項目
        1. `GET http://www.clear-code.com/blog/2016/5/18.html` というログがコンソールに{{#Privacy-7-1}}出力される。(Privacy-7-1){{/Privacy-7-1}}{{#Privacy-7-2}}出力されない。(Privacy-7-2){{/Privacy-7-2}}
{{/Privacy-7}}
{{#Privacy-16}}
1. ブラウザウィンドウでテストケースの `prefetching.html` を開く。
    - 確認項目
        1. `dns-resolution-request: dns-prefetch.example.com` というログがブラウザコンソールに{{#Privacy-16-1}}出力される。(Privacy-16-1){{/Privacy-16-1}}{{#Privacy-16-2}}出力されない。(Privacy-16-2){{/Privacy-16-2}}
{{/Privacy-16}}
1. ブラウザコンソールを閉じる。
{{#Privacy-10-2}}
1. ロケーションバーに `about:` と入力し、Alt-Enterでタブとして開いてから、タブを閉じる。
1. 新しいブラウザウィンドウを開いてロケーションバーに `about:` と入力し、ページの読み込みが完了したらウィンドウを閉じる。 これを2回繰り返す。
1. 「履歴」メニューを開く。
    - 確認項目
        1. 「最近閉じたタブ」それ自体もしくはその配下の項目が表示されない。(Privacy-10-2)
        1. 「最近閉じたウィンドウ」配下にウィンドウの項目が1つだけ表示される。(Privacy-10-2)
1. Firefoxを再起動する。
1. 「履歴」メニューを開く。
    - 確認項目
        1. 「最近閉じたウィンドウ」が表示されない。(Privacy-10-2)
{{/Privacy-10-2}}
{{#Privacy-17}}
1. ツールバー上の検索窓にフォーカスし `a` と入力する。
    - 確認項目
        1. `a` の補完候補が{{#Privacy-17-1}}表示される。(Privacy-17-1){{/Privacy-17-1}}{{#Privacy-17-2}}表示されない。(Privacy-17-2){{/Privacy-17-2}}
1. ツールバー上のロケーションバーにフォーカスし「新しい検索語句」等、履歴やブックマーク等からの候補が表示され得ないテキストを入力する。
    - 確認項目
        1. 補完候補が{{#Privacy-17-1}}表示される。(Privacy-17-1){{/Privacy-17-1}}{{#Privacy-17-2}}表示されない。(Privacy-17-2){{/Privacy-17-2}}
1. ツールバー上の検索窓の虫眼鏡のアイコンをクリックし、ポップアップ表示されたパネルの最下部の「検索設定を変更」をクリックする。
1. 開かれた設定画面の「既定の検索エンジン」欄を見る。
    - 確認項目
        1. 「検索候補を使用する」{{#Privacy-17-1}}にチェックが入っていて選択不可になっている。(Privacy-17-1){{/Privacy-17-1}}{{#Privacy-17-2}}のチェックが外れていて選択不可になっている。(Privacy-17-2){{/Privacy-17-2}}
        1. 「ロケーションバーに検索候補を表示する」{{#Privacy-17-1}}にチェックが入っていて選択不可になっている。(Privacy-17-1){{/Privacy-17-1}}{{#Privacy-17-2}}のチェックが外れていて選択不可になっている。(Privacy-17-2){{/Privacy-17-2}}
{{/Privacy-17}}
{{#use_globalchromecss}}
1. Firefoxを終了し、以下のアドオンを有効化する。
    - globalChrome.css
1. Firefoxを起動する。
{{/use_globalchromecss}}
{{#Privacy-17-2}}
1. ツールバー上の検索窓の虫眼鏡のアイコンをクリックし、ポップアップ表示されたパネルの最下部の「検索設定を変更」をクリックする。
1. 開かれた設定画面の「既定の検索エンジン」欄を見る。
    - 確認項目
        1. 「検索候補を使用する」が表示されていない。(Privacy-17-2)
        1. 「ロケーションバーに検索候補を表示する」が表示されていない。(Privacy-17-2)
{{/Privacy-17-2}}
<!--GROUP-->
1. 設定画面で「プライバシー」ペインを選択する。
    - 確認項目
{{#Privacy-1-2 || Privacy-1-5}}
        1. 「常にプライベートブラウジングモード」が表示されていない。(Privacy-1-2/5)
{{/Privacy-1-2 || Privacy-1-5}}
{{#Privacy-33-3 && use_globalchromecss}}
        1. 「プライベートウィンドウでサイトによるトラッキングをブロックする」が表示されていない。(Privacy-33-3)
{{/Privacy-33-3 && use_globalchromecss}}
{{#Privacy-17-2}}
        1. 「検索エンジンの検索候補の設定を変更」が表示されていない。(Privacy-17-2)
{{/Privacy-17-2}}
<!--/GROUP-->
1. Firefoxを終了する。
{{#Privacy-10-2}}
1. Firefoxのユーザープロファイルフォルダを開く。
    - 確認項目
        1. sessionstore.jsが存在しない。（Privacy-10-2）
{{/Privacy-10-2}}
{{#Privacy-32 || Privacy-37}}
1. `C:\Users\Public\http.log` の位置に出力されているログファイル（複数ある場合はサイズが最も大きい物）を開く。
    - 確認項目
{{#Privacy-32}}
        1. ログ中に現れる `nsHttpConnectionMgr::OnMsgSpeculativeConnect` と `Transport not created due to existing connection count` の{{#Privacy-32-1}}登場回数のうち、前者の方が多い。（Privacy-32-1）{{/Privacy-32-1}}{{#Privacy-32-2}}両者の登場回数が等しい。（Privacy-32-2）{{/Privacy-32-2}}  
           （Linux環境で確認する場合の例：  
           `cat http.log* | grep 'nsHttpConnectionMgr::OnMsgSpeculativeConnect' | wc -l; cat http.log* | grep 'Transport not created due to existing connection count' | wc -l` の実行結果の2行の数値について、{{#Privacy-32-1}}上が大きければ{{/Privacy-32-1}}{{#Privacy-32-2}}両者が同じであれば{{/Privacy-32-2}}設定は期待通り反映されている。）  
           （Firefox上で確認する場合の例：  
           ログをFirefoxで開き、Webコンソールを表示して `var body = document.body.textContent; var requested = body.match(/nsHttpConnectionMgr::OnMsgSpeculativeConnect/g) || []; var skipped = body.match(/Transport not created due to existing connection count/g) || []; console.log('all skipped?: ' + (requested.length == skipped.length));` を実行し、結果が{{#Privacy-32-1}} `all skipped?: false` {{/Privacy-32-1}}{{#Privacy-32-2}} `all skipped?: true` {{/Privacy-32-2}}であれば設定は期待通り反映されている。）
{{/Privacy-32}}
{{#Privacy-37}}
        1. ログ中の `Predictor::Predict` という行の直後に続く `called on parent process` という行の直後に、`not enabled` という行が{{#Privacy-37-1}}表れていない。（Privacy-37-1）{{/Privacy-37-1}}{{#Privacy-37-2}}表れている。（Privacy-37-2）{{/Privacy-37-2}}  
           （Linux環境で確認する場合の例：  
           `cat http.log* | grep -A 2 'Predictor::Predict' | grep -A 1 'called on parent process' | grep 'not enabled' | wc -l; cat http.log* | grep -A 1 'Predictor::Predict' | grep 'called on parent process' | wc -l` の実行結果の2行の数値が{{#Privacy-37-1}}異なっていれば{{/Privacy-37-1}}{{#Privacy-37-2}}同じであれば{{/Privacy-37-2}}、設定は期待通り反映されている。）  
           （Firefox上で確認する場合の例：  
           ログをFirefoxで開き、Webコンソールを表示して `var body = document.body.textContent; var success = body.match(/Predictor::Predict.*\n.*called on parent process.*\n.*not enabled/g) || []; var fail = body.match(/Predictor::Predict.*\n.*called on parent process/g) || []; console.log('all cancened?: ' + (success.length == fail.length));` を実行し、結果が{{#Privacy-37-1}} `all cancened?: false` {{/Privacy-37-1}}{{#Privacy-37-2}} `all cancened?: true` {{/Privacy-37-2}}であれば設定は期待通り反映されている。）
{{/Privacy-37}}
1. 先読み対象となるページのホスト名がプライベートIPアドレスに解決される環境においては、先読み機能が作用しないことからログに必要な情報が記録されず、上記手順での検証は不可能なため、`about:config` もしくは `about:support` で以下の設定の反映状況のみ確認する。
    - 確認項目
{{#Privacy-32}}
        1. `network.http.speculative-parallel-limit` が{{#Privacy-32-1}} `1` またはそれ以上である。(Privacy-32-1){{/Privacy-32-1}}{{#Privacy-32-2}} `0` である。(Privacy-32-2){{/Privacy-32-2}}
{{/Privacy-32}}
{{#Privacy-37}}
        1. `network.predictor.enabled` が{{#Privacy-37-1}} `true` である。(Privacy-37-1){{/Privacy-37-1}}{{#Privacy-37-2}} `false` である。(Privacy-37-2){{/Privacy-37-2}}
{{/Privacy-37}}
{{/Privacy-32 || Privacy-37}}

### 後始末

1. about:configで以下の設定をリセットする。
{{#Privacy-16}}
    1. `network.dns.notifyResolution` （真偽型）
{{/Privacy-16}}
    1. `devtools.chrome.enabled` （真偽型）
1. 以下のアドオンを有効化する。
{{#use_disableabotuconfig}}    1. Disable about:config{{/use_disableabotuconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{#Privacy-32 || Privacy-37}}
1. MCD設定ファイルに追加した設定を全て削除する
1. `C:\Users\Public\http.log-*` を全て削除する。
{{/Privacy-32 || Privacy-37}}
{{#Privacy-9-1}}
## 履歴の保存日数の制御

- 当日を含めず5日前までの履歴を保存するものとする。

### 確認する項目

- Privacy-9-1

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
1. 十分な日数分の履歴項目を以下の手順で用意する。
    1. システムの日付と時刻について、インターネット経由での調整を無効にする。例えばWindowsであれば、タスクバーの時計を右クリックして「日付と時刻の調整」を選択し、「日付と時刻」ダイアログの「インターネット時刻」タブで「設定の変更」ボタンをクリックし、「インターネット時刻サーバーと同期する」のチェックを外す。（※要：管理者権限）
    1. システムの日付を5＋2日以上前の日付に変更する。
    1. Firefox上で何らかのWebページを開き、リンクを辿ってページを遷移する。
    1. この操作を、日付を1日ずつ進めながら繰り返す。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. パネルメニューを開き、「アドオン」をクリックする。
3. アドオンマネージャ内の「拡張機能」をクリックする。
    - 確認項目
        1. 拡張機能の一覧に「Flexible Expire History by Days」が表示されており、有効になっている。(Privacy-9-1)
4. {{expire_history_by_days_version}}の設定画面を開く。
    - 確認項目
        1. 「Expire visits older than these days」の値が`5`である。(Privacy-9-1)
        2. 「Frequency of expiration」で「On the first idle time per a day」が選択されている。(Privacy-9-1)
5. Firefoxのロケーションバーに`about:config`と入力し、ページを開く。
6.  「検索」欄に `idle.lastDailyNotification` と入力し、Enterを押下する。
7. 項目が見つかった場合、項目を右クリックしてメニューから「リセット」を選択する。
8. Firefoxを終了する。
9. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
10. メニューバーの「履歴」から「すべての履歴」を選択し、「履歴とブックマークの管理」ウィンドウを開く（すべての履歴項目を表示した状態にする）。
11. 「履歴」配下の「7日以内」、「（前月）月」、または指定の履歴保存期間のしきい値となる日付が含まれる期間を選択する。
12. 履歴一覧のカラム列を右クリックし、「最近表示した日時」にチェックを入れる。
    - 確認項目
        1. 当日までの日付の履歴項目が並んでいる。
13. マウスとキーボードから手を離し、4分以上、何も操作せずに放置する。
    - 確認項目
        1. 前日を含めて過去5日間の履歴が残っており、それよりも古い履歴項目が残っていない。(Privacy-9-1)

### 後始末

1. システムの日付と時刻について、インターネット経由での調整を有効に戻す。
1. 以下のアドオンを有効化する。
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{/Privacy-9-1}}

{{#Privacy-14}}
## 位置情報の利用制限

### 確認する項目

- Privacy-14-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `https://developer.mozilla.org/ja/docs/WebAPI/Using_geolocation` と入力し、ページを開く。
1. 「Geolocationのライブサンプル」欄の「Show my location」ボタンをクリックする。
    - 確認項目
        1. {{^Privacy-14-3}}「このサイトに位置情報の共有を許可しますか？」と尋ねられる。(Privacy-14-1/2/4){{/Privacy-14-3}}{{#Privacy-14-3}}何も表示されないか、「Geolocation is not supported by your browser」というエラーメッセージが表示される。(Privacy-14-3){{/Privacy-14-3}}
{{#Privacy-14-2 || Privacy-14-4}}
1. 確認無しでの位置情報の取得を許可するサイトのページを開き、「ページの情報」を開いて「サイト別設定」タブを選択する。
    - 確認項目
        1. 「位置情報の送信」で、「標準設定を使用する」のチェックが外れており、「許可」が選択されている。(Privacy-14-2/4)
1. 「位置情報の送信」で、「ブロック」を選択してFirefoxを再起動する。
1. 確認無しでの位置情報の取得を許可するよう設定していたサイトのページを開き、「ページの情報」を開いて「サイト別設定」タブを選択する。
    - 確認項目
        1. 「位置情報の送信」で、「標準設定を使用する」のチェックが外れており、{{#Privacy-14-2}}「許可」が選択されている。(Privacy-14-2){{/Privacy-14-2}}{{#Privacy-14-4}}「ブロック」が選択されている。(Privacy-14-4){{/Privacy-14-4}}
{{/Privacy-14-2 || Privacy-14-4}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{/Privacy-14}}

{{#Privacy-22-2 || Privacy-22-3}}
## Firefox Syncの利用制限

### 確認する項目

- Privacy-22-2/3

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Privacy-22-2}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
    - 確認項目
        1. 「Sync」の項目が存在しない。(Privacy-22-2)
1. 「ツール」メニューを開く。
    - 確認項目
        1. 「Syncにログイン」が存在しない。(Privacy-22-2)
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
        1. 「Sync」が存在しない。(Privacy-22-2)
        2. 「Syncにサインイン」が存在しない。(Privacy-22-2)
1. 以下の各方法でabout:accountsへのアクセスを試みる。
    - 確認項目
        1. ロケーションバーに`about:accounts`と入力し、Alt-Enterして、タブが開かれない（開かれてもすぐ閉じられる）。
            (Privacy-22-2)
        1. ロケーションバーに`about:accounts`と入力し、Enterして、何も起こらない（ページが読み込まれない）か、タブが閉じられる。
            (Privacy-22-2)
        1. ロケーションバーに`about:about`と入力しEnterして`about:`一覧を表示する。
        1. `about:accounts`のリンクを中クリックまたはCtrl-clickし、空白のページがタブで開かれるか、タブが開かれないか、タブが開かれてすぐに閉じられる。(Privacy-22-2)
        1. `about:accounts`のリンクを左クリックし、空白のページが読み込まれるか、タブが閉じられる。(Privacy-22-2)
{{/Privacy-22-2}}
{{#Privacy-22-3}}
1. パネルメニューを開き、パネルメニュー下部の「Syncにサインイン」をクリックする。
2. 設定の「Sync」パネルが開かれるので、「サインイン」ボタンをクリックする。
    - 確認項目
        1. 「Bad configuration」または「設定が正しくありません」というエラーメッセージが表示され、サインインの処理が始まらない。(Privacy-22-3)
{{/Privacy-22-3}}
{{/Privacy-22-2 || Privacy-22-3}}

{{#Privacy-24-2}}
## Firefox Accountsの利用制限

### 確認する項目

- Privacy-24-2

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disablesync}}    1. Disable Sync{{/use_disablesync}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. ロケーションバーに`about:accounts`と入力し、ページを開く。
    - 確認項目
        1. 「Bad configuration」または「設定が正しくありません」というエラーメッセージが表示され、アカウント登録の画面に遷移しない。(Privacy-24-2)

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disablesync}}    1. Disable Sync{{/use_disablesync}}
{{/Privacy-24-2}}

## プライバシーに関わる機能の利用制限

### 確認する項目

{{#Privacy-26-2}} - Privacy-26-2 {{/Privacy-26-2}}
{{#Privacy-27-2}} - Privacy-27-2 {{/Privacy-27-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
{{#Privacy-26-2}}
        1. 「忘れる」が存在しない。(Privacy-26-2)
{{/Privacy-26-2}}
{{#Privacy-27-2}}
        1. 「Pocket」が存在しない。(Privacy-27-2)
{{/Privacy-27-2}}
<!--/GROUP-->
{{#Privacy-27-2}}
1. Webページ中の任意のリンクを右クリックしてコンテキストメニューを開く。
    - 確認項目
        1. 「リンクをPocketに保存」が存在しない。(Privacy-27-2)
{{/Privacy-27-2}}

{{#Privacy-29-2}}
## アイドル状態での履歴・ブックマーク用データベースの自動最適化

### 確認する項目

- Privacy-29-2

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. Firefoxのロケーションバーに`about:config`と入力し、ページを開く。
3. リスト領域を右クリックしてメニューから「新規作成」→整数値を選択し、設定名 `idle.lastDailyNotification`、値`0`で設定項目を登録する。
4. リスト領域を右クリックしてメニューから「新規作成」→整数値を選択し、設定名 `places.database.lastMaintenance`、値`0`で設定項目を登録する。
5. Firefoxを終了する。
6. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
7. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）をクリックして、サブメニューの「ブラウザコンソール」をクリックする。
8. キーボード、マウスから手を離し、4分以上待つ。
9. ブラウザコンソールの内容を確認する。
    - 確認項目
        1. 以下のメッセージがすべて出力される。(Privacy-29-2)
            1. `PlacesDBUtils.maintenanceOnIdle() is called and redirected to checkAndFixDatabase().`
            2. `PlacesDBUtils.checkAndFixDatabase() successfully finished.`
            3. `Array [ ... ]`
        2. `Array [ ... ]` と表示されたメッセージの中に、`> Vacuum` という内容が含まれている。(Privacy-29-2)

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{/Privacy-29-2}}

{{#Privacy-30}}
## ディスクキャッシュのサイズ制限

{{#Privacy-30-2}}
- 制限する最大サイズは{{max_cache_size_in_megabytes}}MBとする。
{{/Privacy-30-2}}

### 確認する項目

- Privacy-30-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Privacy-30-2}}
2. 設定値が1MB未満の場合、値が1MB以上になるよう調整する。
{{/Privacy-30-2}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Privacy-30-1 || Privacy-30-2}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「詳細」→「ネットワーク」を開く。
    - 確認項目
        1. 「キャッシュサイズを変更する」に{{#Privacy-30-1}}チェックが入っておらず、選択不可になっている。(Privacy-30-1){{/Privacy-30-1}}{{#Privacy-30-2}}チェックが入っていて、選択不可になっている。(Privacy-30-2){{/Privacy-30-2}}
{{#Privacy-30-2}}
        1. 「ページキャッシュとして{{max_cache_size_in_megabytes}}MBまで使用する」と表示されている。(Privacy-30-2)
{{/Privacy-30-2}}
{{/Privacy-30-1 || Privacy-30-2}}
{{#Privacy-30-3}}
1. `http://www.clear-code.com/` などいくつかのWebページを閲覧する。
1. ロケーションバーに `about:cache` と入力し、ページを開く。
    - 確認項目
        1. 「disk」欄の「Storage disk location」に「none, only stored in memory」と表示されている。(Privacy-30-3)
1. `{{special_profile_path}}\{{special_profile_name}}\cache2` 、もしくは `%LocalAppData%\Mozilla\Firefox\Profiles\（ランダムな文字列）.default\cache2` を開き、その中の `entries` フォルダを開く。
    - 確認項目
        1. フォルダが空である。(Privacy-30-3)
{{/Privacy-30-3}}
{{/Privacy-30}}

{{#Privacy-11}}
## Cookie、IndexedDB、Web Storage、およびService Worker用Cacheの保存ポリシー

### 確認する項目

- Privacy-11-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「プライバシー」を開き、「記憶させる履歴を詳細設定する」を選択する。
    - 確認項目
        1. 「サイトから送られてきたCookieを保存する」に{{^Privacy-11-4}}チェックが入っている。（Privacy-11-1/2/3/5）{{/Privacy-11-4}}{{#Privacy-11-4}}チェックが入っていない。（Privacy-11-4）{{/Privacy-11-4}}
        1. 「サードパーティCookieの保存」で{{^Privacy-11-4}}「常に許可」が選択されている。（Privacy-11-1/2/3/5）{{/Privacy-11-4}}{{#Privacy-11-4}}「常に拒否」が選択されている。（Privacy-11-4）{{/Privacy-11-4}}
{{^Privacy-11-4}}
        1. 「Cookieを保存する期間」で{{^Privacy-11-3}}「サイトが指定した期限まで」が選択されている。（Privacy-11-1/2/5）{{/Privacy-11-3}}{{#Privacy-11-3}}「Firefoxを終了するまで」が選択されている。（Privacy-11-3）{{/Privacy-11-3}}
{{/Privacy-11-4}}
{{#Privacy-11-2 || Privacy-11-5}}
1. Cookie保存の許可対象のサイトを開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
        1. 「サイト別設定」タブで「Cookieデータの保存」において「許可」にチェックが入っている。（Privacy-11-2/5）
        1. 「ポップアップウィンドウを開く」を「ブロック」に変更してFirefoxを再起動し、再び同じページの「ページの情報」の「サイト別設定」タブを開いた時、{{#Privacy-11-2}}「Cookieデータの保存」において「許可」にチェックが入っている。（Privacy-11-2）{{/Privacy-11-2}}{{#Privacy-11-5}}「ブロック」にチェックが入っている。（Privacy-11-5）{{/Privacy-11-5}}
{{/Privacy-11-2 || Privacy-11-5}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{/Privacy-11}}

{{#Privacy-34}}
## フォームへのユーザー入力値のセッション情報への保存の可否

### 確認する項目

- Privacy-34-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
2. Firefoxのユーザープロファイル（`{{special_profile_path}}`）を削除する。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}
1. テストケースの `password.html` を開く。
1. ユーザID欄に「ユーザ入力値」と入力し、20秒待つ。
1. ユーザープロファイル内の `sessionstore-backups` フォルダ内の `recovery.js` を開く。
   - 確認項目
       1. ファイル内に「ユーザ入力値」という文字列が{{#Privacy-34-1}}含まれている。（Privacy-34-1）{{/Privacy-34-1}}{{#Privacy-34-2}}含まれていない。（Privacy-34-2）{{/Privacy-34-2}}
{{/Privacy-34}}

<!--======================================================================-->

# Webブラウズ機能に関するカスタマイズ

## 検索エンジンの制限

### 確認する項目

{{#Websearch-1}} - Websearch-1-\* {{/Websearch-1}}
{{#Websearch-2-2}} - Websearch-2-2 {{/Websearch-2-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `https://addons.mozilla.org/` と入力し、ページを開く。
1. Web検索バーのアイコンをクリックする。
    - 確認項目
{{#Websearch-1}}
        1. Web検索バーのアイコンに「+」のバッジが{{#Websearch-1-1}}表示される。(Websearch-1-1){{/Websearch-1-1}}{{#Websearch-1-2}}表示されない。(Websearch-1-2){{/Websearch-1-2}}
        1. パネル上に「”Firefoxアドオン”を追加」という項目が{{#Websearch-1-1}}表示される。(Websearch-1-1){{/Websearch-1-1}}{{#Websearch-1-2}}表示されない。(Websearch-1-2){{/Websearch-1-2}}
{{/Websearch-1}}
{{#Websearch-2-2}}
        1. パネル上に、無効にした検索エンジンが表れていない。(Websearch-2-2)
{{/Websearch-2-2}}
{{#Websearch-2-2}}
1. パネル下部の「検索設定を変更」をクリックする。(Websearch-2-2)
    - 確認項目
    -   1. 「既定の検索エンジン」のドロップダウンリストに、無効にした検索エンジンが表れていない。(Websearch-2-2)
        1. 「ワンクリック検索エンジン」のリストに、無効にした検索エンジンが表れていない。(Websearch-2-2)
{{/Websearch-2-2}}

{{#Location-1}}
## ロケーションバーの表示の制御

### 確認する項目

- Location-1-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `http://www.clear-code.com/` のように `http://` で始まるURLを入力し、ページを開く。
    - 確認項目
        1. ロケーションバーのURL表記に `http://` が{{#Location-1-2}}含まれている。(Location-1-2){{/Location-1-2}}{{#Location-1-1}}含まれていない。(Location-1-1){{/Location-1-1}}
{{/Location-1}}


## ダウンロードに関する機能の制御

### 確認する項目

{{#Download-1}} - Download-1-\* {{/Download-1}}
{{#Download-2}} - Download-2-\* {{/Download-2}}
{{#Download-3}} - Download-3-\* {{/Download-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
2. Firefoxのユーザープロファイル（`{{special_profile_path}}`）を削除する。
3. 既定のダウンロード先（`{{download_dir}}`）を用意しておく。用意できない場合は、Download-2-1の参照先を `C:\` などの実在するパスに変更し、以下の説明も読み替える。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Download-1}}
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
        1. 「ダウンロード」が{{#Download-1-1}}存在する。(Download-1-1){{/Download-1-1}}{{#Download-1-2}}存在しない。(Download-1-2){{/Download-1-2}}
{{/Download-1}}
{{#Download-2 || Download-3-1 || Download-3-2}}
1. ロケーションバーに `http://www.clear-code.com/` と入力し、ページを開く。
   もしくは、Content-Typeが `application/octet-stream`のリンク先ファイルが自動ダウンロードされるページを開く。
1. Webページ中の任意のリンクを右クリックするか、しばらく待つかし、表示されたダイアログで「名前を付けてリンク先を保存」を選択する。
{{#Download-2}}
    - 確認項目
        1. {{#Download-2-1 || Download-2-2}}ダウンロード先として{{download_dir}}が選択された状態でファイル選択ダイアログが開かれる。(Download-2-1/2){{/Download-2-1 || Download-2-2}}{{#Download-2-3}}ホームディレクトリ内の「ダウンロード」が選択された状態でファイル選択ダイアログが開かれる。(Download-2-3) {{/Download-2-3}}
{{/Download-2}}
{{/Download-2 || Download-3-1 || Download-3-2}}
{{#Download-3-1 || Download-3-2}}
1. `subfolder` という名前でフォルダを作成し、そのフォルダを選択してダウンロードを開始する。
{{#Download-1}}
    - 確認項目
        1. ダウンロードの進行状況を示すポップアップが{{#Download-1-1}}表示される。(Download-1-1){{/Download-1-1}}{{#Download-1-2}}表示されない。(Download-1-2){{/Download-1-2}}
{{/Download-1}}
{{/Download-3-1 || Download-3-2}}
{{#Download-3}}
1. ロケーションバーに `https://getfirefox.com/` と入力し、ページを開く。
1. Firefoxのダウンロード用ボタンをクリックし、「ファイルを保存」を選択する。
    - 確認項目
{{#Download-3-1 || Download-3-2}}
        1. 特にダウンロード先を訊ねられずダウンロードが始まる。（Download-3-1/3-2）
{{/Download-3-1 || Download-3-2}}
{{#Download-3-3}}
        1. ダウンロード先ディレクトリを選択するダイアログが開かれる。（Download-3-3）
{{/Download-3-3}}
{{#Download-3-1 || Download-3-2}}
1. ロケーションバーに `http://www.mozilla.org/` と入力し、ページを開く。
1. Webページ中の任意のリンクを右クリックし、「名前を付けてリンク先を保存」を選択する。
    - 確認項目
        1. ダウンロード先として{{#Download-3-1}}{{download_dir}}内の「subfolder」が選択された状態でファイル選択ダイアログが開かれる。(Download-3-1){{/Download-3-1}}{{#Download-3-2}}{{download_dir}}が選択された状態でファイル選択ダイアログが開かれる。(Download-3-2){{/Download-3-2}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「一般」を開く。
    - 確認項目
        1. 「ダウンロード」は「次のフォルダに保存する」が選択されている。(Download-3-\*)
        1. ダウンロード先として{{#Download-3-1}}{{download_dir}}内の `subfolder` が表示されている。(Download-3-1){{/Download-3-1}}{{#Download-3-2}}{{download_dir}}が表示されている。(Download-3-2){{/Download-3-2}}
{{/Download-3-1 || Download-3-2}}
{{/Download-3}}

## タブの操作に関する機能の制御

### 確認する項目

{{#Tab-1}} - Tab-1-\* {{/Tab-1}}
{{#Tab-2}} - Tab-2-\* {{/Tab-2}}
{{#Tab-3}} - Tab-3-\* {{/Tab-3}}
{{#Tab-5}} - Tab-5-\* {{/Tab-5}}
{{#Tab-7}} - Tab-7-\* {{/Tab-7}}
{{#Tab-9}} - Tab-9-\* {{/Tab-9}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Tab-3}}
1. テストケース `links.html` を用意する。
{{/Tab-3}}
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Tab-1}}
1. 新しいウィンドウを開く。
1. 新しいウィンドウ内で新しいタブを2つ以上開く。
1. ウィンドウを閉じる操作を行う。
    - 確認項目
        1. 複数のタブを閉じてよいかどうか{{#Tab-1-1}}確認される。(Tab-1-1){{/Tab-1-1}}{{#Tab-1-2 || Tab-1-3}}確認されない。(Tab-1-2/3){{/Tab-1-2 || Tab-1-3}}
{{/Tab-1}}
{{#Tab-2}}
1. タブを1つ選択し、右クリックして「他のタブをすべて閉じる」を選択する。
    - 確認項目
        1. 複数のタブを閉じてよいかどうか{{#Tab-2-1}}確認される。(Tab-2-1){{/Tab-2-1}}{{#Tab-2-2 || Tab-2-3}}確認されない。(Tab-2-2/3){{/Tab-2-2 || Tab-2-3}}
{{/Tab-2}}
{{#Tab-3}}
1. テストケースの `links.html` を開く。リンクからタブを開き、15以上のタブが開かれた状態にする。
1. タブの上で右クリックし、メニューから「すべてのタブをブックマーク」を選択する。
1. フォルダ名を任意に指定し、ブックマークフォルダとして保存する。
1. メニューバーの「ブックマーク」から前の操作で作成されたブックマークフォルダを選択し、最下部の「タブですべて開く」を選択する。
    - 確認項目
        1. 一度に複数のタブを開いてよいかどうか{{#Tab-3-1}}確認される。(Tab-3-1){{/Tab-3-1}}{{#Tab-3-2 || Tab-3-3}}確認されない。(Tab-3-2/3){{/Tab-3-2 || Tab-3-3}}
{{/Tab-3}}
{{#Tab-5 || Tab-7}}
1. タブバー上の「+」ボタンをクリックして新しいタブを開く。またはパネルメニューを開き、パネルメニュー内の「新しいウィンドウ」をクリックする。
    - 確認項目
{{#Tab-5-1}}
        1. 右上に歯車アイコンのある空白ページが表示される。(Tab-5-1)
{{/Tab-5-1}}
{{#Tab-5-2 || Tab-5-3 || Tab-7-2}}
        1. 右上に歯車アイコンの{{#Tab-5-2}}ない{{/Tab-5-2}}{{#Tab-5-3}}ある{{/Tab-5-3}}空白ページが表示される。{{#Tab-5-2}}(Tab-5-2){{/Tab-5-2}}{{#Tab-5-3}}(Tab-5-3){{/Tab-5-3}}{{#Tab-7-2}}(Tab-7-2){{/Tab-7-2}}
{{/Tab-5-2 || Tab-5-3 || Tab-7-2}}
{{#Tab-7}}{{^Tab-7-2}}
        1. タイルが表示される。(Tab-7-1/3/4/5)
{{/Tab-7-2}}{{/Tab-7}}
{{#Tab-7-3 || Tab-7-4 || Tab-7-5}}
        1. タイルの中に{{#Tab-7-4}}未訪問のページが含まれる。(Tab-7-4){{/Tab-7-4}}{{#Tab-7-3 || Tab-7-5}}訪問済みのページのみが表示される。(Tab-7-3/5){{/Tab-7-3 || Tab-7-5}}
{{/Tab-7-3 || Tab-7-4 || Tab-7-5}}
{{/Tab-5 || Tab-7}}
{{#Tab-7-1 || Tab-7-5}}
1. 新しいタブ内の歯車ボタンをクリックする。
    - 確認項目
        1. 「おすすめサイトも表示」が{{#Tab-7-1}}表示される。(Tab-7-1){{/Tab-7-1}}{{#Tab-7-5}}表示されない。(Tab-7-5){{/Tab-7-5}}
{{/Tab-7-1 || Tab-7-5}}
<!--GROUP-->
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「一般」を開く。
    - 確認項目
{{#Tab-1-3}}
        1. 「タブグループ」配下に「同時に複数のタブを閉じるときは確認する」のチェックボックスがOFFの状態で表示されている。(Tab-1-3)
{{/Tab-1-3}}
{{#Tab-3-3}}
        1. 「タブグループ」配下に「同時に複数のタブを開いて Firefoxの動作が遅くなるときは確認する」のチェックボックスがOFFの状態で表示されている。(Tab-3-3)
{{/Tab-3-3}}
<!--/GROUP-->
<!--GROUP-->
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Tab-2-3}}
        1. `browser.tabs.warnOnCloseOtherTabs` の値がユーザー設定値の`false`である。(Tab-2-3)
{{/Tab-2-3}}
{{#Tab-9-2}}
        1. `browser.newtab.preload` の値がユーザー設定値の`false`である。(Tab-9-2)
{{/Tab-9-2}}
<!--/GROUP-->

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

{{#Ui-1}}
## 内蔵PDFビューアの使用

### 確認する項目

- Ui-1-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「プログラム」を開く。
    - 確認項目
        1. ファイルの種類「PDF文書（PDF）」（「Adobe Acrobat Document」、「PDFファイル」となっている場合もあるため注意）の取り扱い方法{{#Ui-1-1}}が「Firefoxでプレビュー表示」となっている。(Ui-1-1){{/Ui-1-1}}{{#Ui-1-2}}の選択肢に「Firefoxでプレビュー表示」が存在しない。(Ui-1-2){{/Ui-1-2}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{/Ui-1}}

{{#Ui-3}}
## タブの音声出力インジケータの使用

### 確認する項目

- Ui-3-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `https://www.youtube.com` と入力し、ページを開く。
1. いずれか1つの動画を開く。
    - 確認項目
        1. タブ内にスピーカーのアイコンが{{#Ui-3-1}}表示される。(Ui-3-1){{/Ui-3-1}}{{#Ui-3-2}}表示されない。(Ui-3-2){{/Ui-3-2}}
        1. タブを「ピン留め」した状態で、タブのアイコンにスピーカーのバッジが{{#Ui-3-1}}表示される。(Ui-3-1){{/Ui-3-1}}{{#Ui-3-2}}表示されない。(Ui-3-2){{/Ui-3-2}}
{{/Ui-3}}

{{#Ui-4-1}}
## 認証プロンプトの重複表示の抑止

### 確認する項目

- Ui-4-1

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
2. 外部の埋め込みリソースを2つ以上埋め込んだWebページ（例： `http://www.clear-code.com/blog/` ）をホームページに設定する。ホームページを変更できない場合はスキップする。
3. ユーザー名とパスワードによる認証が必要なHTTP Proxyを用意する。既存のProxyが無い場合は、以下に示す設定例に従い用意する。
    1. 検証器が到達可能なネットワーク上に、Ubuntu 14.04LTSがセットアップされたホストを用意する。仮に、IPアドレスは{{proxy_host}}であるとする。
    2. 以下のコマンド列を順に実行し、Apacheをインストールする。
        1. sudo apt-get install apache2 apache2-utils
        2. sudo a2enmod proxy\_http
        3. sudo a2enmod proxy\_connect
    3. 以下のコマンド列を実行し、認証用のユーザー名（ここでは仮に`{{proxy_auth_user}}`とする）とパスワードを設定する。
        1. sudo htpasswd -c /etc/apache2/.htpasswd {{proxy_auth_user}}
    4. /etc/apache2/conf-enabled/forward\_proxy.confの位置に以下の内容でファイルを作成する。
       
            ProxyRequests On
            ProxyVia On

            <Proxy *>
              AuthType Basic
              AuthName "Password Required"
              AuthUserFile /etc/apache2/.htpasswd
              Require user {{proxy_auth_user}}         </Proxy>
       
    5. 以下のコマンド列を実行し、Apacheを再起動する。
        1. sudo service apache2 restart
4. Network-2-2の設定を使用し、認証が必要なHTTP Proxyを使用するよう設定する。上記の例に従い用意したProxyの場合、設定は以下のようになる。
        
        lockPref("network.proxy.type", 1);
        lockPref("network.proxy.http", "{{proxy_host}}");
        lockPref("network.proxy.http\_port", 80);
        lockPref("network.proxy.share\_proxy\_settings", true);
        

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. Firefox起動時に前回終了時のタブを復元するよう設定し、faviconを持つWebページのタブを2つ以上開く。
3. Firefoxを再起動する。
    - 検証項目
        1. HTTP Proxyの認証プロンプトが表示される。(Ui-4-1)
        2. 1つの認証プロンプトで認証した後2つ目以降の認証プロンプトの入力を求められない。(Ui-4-1)

### 後始末

1. Network-2-2の設定を元に戻す。
2. 用意したHTTP Proxyを停止する。
{{/Ui-4-1}}

## その他のWebアプリ向けAPIの使用制限

### 確認する項目

{{#Script-2}} - Script-2-\* {{/Script-2}}
{{#Script-3}} - Script-3-\* {{/Script-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Script-2-3}}
1. ロケーションバーに `https://labs.othersight.jp/webpushtest/` と入力し、ページを開く。
    - 確認項目
        1. ページ内に「Service Worker not available」と表示されている。(Script-2-3)
{{/Script-2-3}}
<!--GROUP-->
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Script-2}}
        1. `dom.push.enabled` の値が{{#Script-2-1 || Script-2-2}}`true`である。(Script-2-1/2){{/Script-2-1 || Script-2-2}}{{#Script-2-3}}`false`である。(Script-2-3){{/Script-2-3}}
        1. `dom.serviceWorkers.enabled` の値が{{#Script-2-1 || Script-2-2}}`true`である。(Script-2-1/2){{/Script-2-1 || Script-2-2}}{{#Script-2-3}}`false`である。(Script-2-3){{/Script-2-3}}
{{/Script-2}}
{{#Script-3}}
        1. `dom.gamepad.enabled` の値が{{#Script-3-1}}`true`である。(Script-3-1){{/Script-3-1}}{{#Script-3-2}}`false`である。(Script-3-2){{/Script-3-2}}
{{/Script-3}}
<!--/GROUP-->
{{#Script-2-2 || Script-2-4}}
1. 確認なしでpush通知を許可する対象のサイトを開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
        1. 「サイト別設定」タブで「通知を受信する」において「許可」にチェックが入っている。(Script-2-2/4)
1. 「通知を受信する」で、「ブロック」を選択してFirefoxを再起動する。
1. 確認なしでpush通知を許可するよう設定していたサイトのページを開き、「ページの情報」を開いて「サイト別設定」タブを選択する。
    - 確認項目
        1. 「通知を受信する」で、「標準設定を使用する」のチェックが外れており、{{#Script-2-2}}「許可」が選択されている。(Script-2-2){{/Script-2-2}}{{#Script-2-4}}「ブロック」が選択されている。{{/Script-2-4}}
{{/Script-2-2 || Script-2-4}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

{{#Stability-1}}
## ハードウェアアクセラレーションの使用

### 確認する項目

- Stability-1-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「詳細」→「一般」を開く。
    - 確認項目
        1. 「ハードウェアアクセラレーション機能を使用する」に{{#Stability-1-1}}チェックが入っている。(Stability-1-1){{/Stability-1-1}}{{#Stability-1-2}}または、チェックが入っていない。(Stability-1-2){{/Stability-1-2}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{/Stability-1}}

{{#Stability-2-2 || Stability-2-3}}
## プロセス分離の制御

### 確認する項目

- Stability-2-2/3

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 1回Firefoxを起動し、終了する。
   （初回起動時は必ずプロセス分離が無効化されるため、必ず2回目以降の起動時の状態で検証する。）

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. about:supportを開く
    - 確認項目
       1. 「アプリケーション基本情報」の「マルチプロセスウィンドウ」に{{#Stability-2-2}}「有効」と表示されている。(Stability-2-2){{/Stability-2-2}}{{#Stability-2-3}}「無効」と表示されている。(Stability-2-3){{/Stability-2-3}}
{{/Stability-2-2 || Stability-2-3}}

{{#Appearance-1-2}}
## 表示フォントの設定

### 確認する項目

- Appearance-1-2

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. about:configを開き、以下の設定を行う。
    - `font.name.serif.ja`（文字列型）を`missing`に設定する。
    - `font.name.sans-serif.ja`（文字列型）を`missing`に設定する。
    - `font.name.monospace.ja`（文字列型）を`missing`に設定する。
3. テストケースの `font.html` を開く。
4. 「Serif / セリフ体（明朝）」の箇所を右クリックし、「要素を調査」を選択して、インスペクタ右端の「フォント」をクリックする。
    - 確認項目
        1. font.name-list.serif.jaに設定したフォントの名前が表示される。（Appearance-1-2）
5. 「Sans-Serif / サンセリフ体（ゴシック）」の箇所を右クリックし、「要素を調査」を選択して、インスペクタ右端の「フォント」をクリックする。
    - 確認項目
        1. font.name-list.sans-serif.jaに設定したフォントの名前が表示される。（Appearance-1-2）
6. 「Monospace / 等幅」の箇所を右クリックし、「要素を調査」を選択して、インスペクタ右端の「フォント」をクリックする。
    - 確認項目
        1. font.name-list.monospace.jaに設定したフォントの名前が表示される。（Appearance-1-2）

### 後始末

1. about:configで以下の設定をリセットする。
    1. `font.name.serif.ja`（文字列型）
    2. `font.name.sans-serif.ja`（文字列型）
    3. `font.name.monospace.ja`（文字列型）
1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{/Appearance-1-2}}

{{#Appearance-2-2}}
## ツールバーの項目

### 確認する項目

- Appearance-2-2

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
    - 確認項目
        1. ツールバーに表示されている項目が、指定の通りとなっている。（Appearance-2-2）
        2. パネルメニューに表示されている項目が、指定の通りとなっている。（Appearance-2-2）
2. ツールバーカスタマイズで、ツールバーおよびパネルメニューの内容を変更する。
3. Firefoxを再起動する。
    - 確認項目
        1. ツールバーに表示されている項目が、指定の通りとなっている。（Appearance-2-2）
        2. パネルメニューに表示されている項目が、指定の通りとなっている。（Appearance-2-2）

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}
{{/Appearance-2-2}}

## Webブラウズ操作のその他のカスタマイズ

### 確認する項目

{{#Ui-2}} - Ui-2-\* {{/Ui-2}}
{{#Ui-5}} - Ui-5-\* {{/Ui-5}}
{{#Ui-6}} - Ui-6-\* {{/Ui-6}}
{{#Script-1}} - Script-1-\* {{/Script-1}}
{{#Script-4}} - Script-4-\* {{/Script-4}}
{{#Script-5}} - Script-5-\* {{/Script-5}}
{{#Script-6}} - Script-6-\* {{/Script-6}}
{{#Performance-1-2}} - Performance-1-2 {{/Performance-1-2}}
{{#Performance-2-2}} - Performance-2-2 {{/Performance-2-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Ui-2}}
1. コンテンツ領域にフォーカスした状態でF7キーを押す。
   - 確認項目
       1. キャレットブラウズの開始の可否を{{#Ui-2-1}}尋ねられる。（Ui-2-1）{{/Ui-2-1}}{{#Ui-2-2}}尋ねられない。（Ui-2-2）{{/Ui-2-2}}
{{/Ui-2}}
1. ロケーションバーに `http://www.clear-code.com/blog/` と入力し、ページを開く。
{{#Ui-5}}
    - 確認項目
        1. ロケーションバー内に本の形のアイコンが{{#Ui-5-1}}表示される。（Ui-5-1）{{/Ui-5-1}}{{#Ui-5-2}}表示されない。（Ui-5-2）{{/Ui-5-2}}
{{/Ui-5}}
1. テストケースの `textfield.html` を開く。
{{#Ui-6}}
1. テキスト入力欄に一旦フォーカスし、ページ内の他の箇所をクリックしてフォーカスを外す。
    - 確認項目
        1. テキスト入力欄中の `abc` の下に赤い波線が{{#Ui-6-1}}表示される。（Ui-6-1）{{/Ui-6-1}}{{#Ui-6-2}}表示されない。（Ui-6-2）{{/Ui-6-2}}
{{/Ui-6}}
1. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）配下の「ウェブコンソール」をクリックする。
{{#Script-1}}
1. コンソール下部の入力欄に `alert('OK');alert('OK');alert('OK');` と入力し、実行する。
    - 確認項目
        1. 2つ目以降のダイアログに、以後のダイアログを表示しないようにするかどうかを尋ねるチェックボックスが{{#Script-1-1}}表示される。（Script-1-1）{{/Script-1-1}}{{#Script-1-2}}表示されない。（Script-1-2）{{/Script-1-2}}
{{/Script-1}}
1. コンソール下部の入力欄に `window.addEventListener('copy', (event) => console.log(event.type)); window.addEventListener('click', (event) => console.log('button = ' + event.button)); window.addEventListener('contextmenu', (event) => event.preventDefault());` と入力し、実行する。
{{#Script-4}}
1. コンテンツ内の文字を選択して、キーボードショートカット「Ctrl-C」でコピーする。
    - 確認項目
        1. コンソール上に `copy` という文字が{{#Script-4-1}}出力される。（Script-4-1）{{/Script-4-1}}{{#Script-4-2}}出力されない。（Script-4-2）{{/Script-4-2}}
{{/Script-4}}
{{#Script-5 || Script-6}}
1. コンテンツ領域の上で右クリックする。
    - 確認項目
{{#Script-6}}
        1. コンソール上に `button = 2` という文字が{{#Script-6-1}}出力される。（Script-6-1）{{/Script-6-1}}{{#Script-6-2}}出力されない。（Script-6-2）{{/Script-6-2}}
{{/Script-6}}
{{#Script-5}}
        1. コンテキストメニューが{{#Script-5-1}}開かれない。（Script-5-1）{{/Script-5-1}}{{#Script-5-2}}開かれる。（Script-5-2）{{/Script-5-2}}
{{/Script-5}}
{{/Script-5 || Script-6}}
<!--GROUP-->
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Performance-1-2}}
        1. `browser.cache.memory.capacity` の値が指定値の通りである。(Performance-1-2)
{{/Performance-1-2}}
{{#Performance-2-2}}
        1. `content.notify.interval` の値が指定値の通りである。(Performance-2-2)
{{/Performance-2-2}}
<!--/GROUP-->

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

<!--======================================================================-->

# ネットワーク処理に関するカスタマイズ

{{#Network-2}}
## プロキシの設定

### 確認する項目

- Network-2-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
1. 自動プロキシ設定スクリプトのURLが未設定の場合、設定する。  
   {{pac_url_setup}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「詳細」→「ネットワーク」→「接続」→「接続設定」を開く。
    - 確認項目
{{#Network-2-1}}
        1. 「プロキシを使用しない」が選択されている。(Network-2-1)
{{/Network-2-1}}
{{#Network-2-2}}
        1. 「手動でプロキシを設定する」が選択されている。(Network-2-2)
        1. 各プロキシが指定通りに設定されている。(Network-2-2)
{{/Network-2-2}}
{{#Network-2-3}}
        1. 「自動プロキシ設定スクリプトURL」が選択されている。(Network-2-3)
        1. 「自動プロキシ設定スクリプトURL」の欄に、予め指定しておいたURLが入力されている。(Network-2-3)  
           （`{{pac_url}}` または `data:application/javascript,`）
{{/Network-2-3}}
{{#Network-2-4}}
        1. 「このネットワークのプロキシ設定を自動検出する」が選択されている。(Network-2-4)
{{/Network-2-4}}
{{#Network-2-5}}
        1. 「システムのプロキシ設定を利用する」が選択されている。(Network-2-5)
{{/Network-2-5}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{/Network-2}}

## その他のネットワーク関連設定

### 確認する項目

{{#Network-1-1}} - Network-1-1 {{/Network-1-1}}
{{#Network-4-1}} - Network-4-1 {{/Network-4-1}}
{{#Network-5-2}} - Network-5-2 {{/Network-5-2}}
{{#Network-6}} - Network-6-\* {{/Network-6}}
{{#Network-7}} - Network-7-\* {{/Network-7}}
{{#Network-8}} - Network-8-\* {{/Network-8}}
{{#Network-9}} - Network-9-\* {{/Network-9}}
{{#Network-10}} - Network-10-\* {{/Network-10}}
{{#Network-11-2}} - Network-11-2 {{/Network-11-2}}
{{#Network-12}} - Network-12-\* {{/Network-12}}
{{#Network-13}} - Network-13-\* {{/Network-13}}
{{#Network-14}} - Network-14-\* {{/Network-14}}
{{#Network-15-2}} - Network-15-2 {{/Network-15-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}
1. テストケースの `sample.jar` を任意のサーバーに設置し、Content-Type `application/java-archive` を伴って返却されるように設定しておく。
   ファイルの設置先は `{{jar_file_sample_url_base}}/sample.jar` とする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Network-1-1}}
        1. `general.useragent.extra.microsoftdotnet` が項目として存在しない、もしくは、値が未定義である。(Network-1-1)
{{/Network-1-1}}
{{#Network-4-1}}
        1. `network.automatic-ntlm-auth.trusted-uris` の値が`{{ntlm_single_signon_hosts}}`である。(Network-4-1)
{{/Network-4-1}}
{{#Network-5-2}}
        1. `network.http.max-connections` の値が{{max_connections}}である。(Network-5-2)
        1. `network.http.max-persistent-connections-per-server` の値が{{max_persistent_connections_per_server}}である。(Network-5-2)
        1. `network.http.max-persistent-connections-per-proxy` の値が{{max_persistent_connections_per_proxy}}である。(Network-5-2)
{{/Network-5-2}}
{{#Network-6}}
        1. `network.http.spdy.enabled` の値が{{#Network-6-1}}`true`である。(Network-6-1){{/Network-6-1}}{{#Network-6-2}}`false`である。(Network-6-2){{/Network-6-2}}
{{/Network-6}}
{{#Network-7}}
        1. `security.tls.insecure_fallback_hosts`の値が{{#Network-7-1}}未設定または空文字である。(Network-7-1){{/Network-7-1}}{{#Network-7-2}}`{{ntlm_single_signon_hosts}}`である。(Network-7-2){{/Network-7-2}}
{{/Network-7}}
{{#Network-8}}
        1. `network.dns.disableIPv6` の値が{{#Network-8-1}}`false`である。(Network-8-1){{/Network-8-1}}{{#Network-8-2}}`true`である。(Network-8-2){{/Network-8-2}}
{{/Network-8}}
{{#Network-9}}
        1. `network.http.pipelining` の値が{{#Network-9-1}}`true`である。(Network-9-1){{/Network-9-1}}{{#Network-9-2}}`false`である。(Network-9-2){{/Network-9-2}}
        1. `network.http.proxy.pipelining` の値が{{#Network-9-1}}`true`である。(Network-9-1){{/Network-9-1}}{{#Network-9-2}}`false`である。(Network-9-2){{/Network-9-2}}
{{/Network-9}}
{{#Network-10}}
        1. `network.dns.blockDotOnion` の値が{{#Network-10-1}}`false`である。(Network-10-1){{/Network-10-1}}{{#Network-10-2}}`true`である。(Network-10-2){{/Network-10-2}}
{{/Network-10}}
{{#Network-13}}
        1. `security.tls.version.max` の値が{{#Network-13-1}}`4`である。(Network-13-1){{/Network-13-1}}{{#Network-13-2}}`3`以下である。(Network-13-2){{/Network-13-2}}
{{/Network-13}}
{{#Network-14}}
        1. `security.pki.sha1_enforcement_level` の値が{{#Network-14-1}}`0`である。(Network-14-1){{/Network-14-1}}{{#Network-14-2}}`1`である。(Network-14-2){{/Network-14-2}}{{#Network-14-3}}`2`である。(Network-14-3){{/Network-14-3}}{{#Network-14-4}}`3`である。(Network-14-4){{/Network-14-4}}{{#Network-14-5}}`4`である。(Network-14-5){{/Network-14-5}}
{{/Network-14}}
{{#Network-15-2}}
        1. `network.http.pipelining.maxrequests` の値が{{max_pipelining_requests}}である。(Network-15-2)
{{/Network-15-2}}
<!--/GROUP-->
{{#Network-11-2}}
1. ロケーションバーに `about:support` と入力し、トラブルシューティング情報の一覧を表示する。
    - 確認項目
        1. 「User Agent」の値が「{{user_agent_name}}」である。(Network-11-2)
{{/Network-11-2}}
{{#Network-12}}
1. ロケーションバーに `jar:{{jar_file_sample_url_base}}/sample.jar!/sample.txt` と入力し、開く。
    - 確認項目
{{#Network-12-1}}
        1. 「success」と表示される。（Network-12-1）
{{/Network-12-1}}
{{#Network-12-2}}
        1. 読み込みがブロックされた旨のエラーページが表示される。（Network-12-2）
{{/Network-12-2}}
{{/Network-12}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

<!--======================================================================-->

# 自動更新のカスタマイズ

## Firefoxおよびアドオンの自動更新の制限

### 確認する項目

{{#Update-1-3}} - Update-1-3 {{/Update-1-3}}
{{#Update-2-2}} - Update-2-2 {{/Update-2-2}}
{{#Update-3-2}} - Update-3-2 {{/Update-3-2}}
{{#Update-5-2}} - Update-5-2 {{/Update-5-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Update-1-3}}
1.  「ヘルプ」→「Firefoxについて」を開く。
    - 確認項目
        1. 「ソフトウェアの更新」が表示されない。(Update-1-3)
{{/Update-1-3}}
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Update-1-3}}
        1. `app.update.enabled` の値が`false`である。(Update-1-3)
        1. `app.update.mode` の値が`0`である。(Update-1-3)
{{/Update-1-3}}
{{#Update-2-2}}
        1. `extensions.update.enabled` の値が`false`である。(Update-2-2)
{{/Update-2-2}}
{{#Update-3-2}}
        1. `browser.search.update` の値が`false`である。(Update-3-2)
{{/Update-3-2}}
{{#Update-5-2}}
        1. `lightweightThemes.update.enabled` の値が`false`である。(Update-5-2)
{{/Update-5-2}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

<!--======================================================================-->

# プラグイン、外部アプリケーション、アドオンのカスタマイズ

{{#Plugin-10}}
## プラグインの制御

### 確認する項目

- Plugin-10-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. NPAPIプラグインを何種類かインストールしておく。
1. 以下のアドオンを無効化する。
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
1. 各プラグインの制御が可能であるかどうか自体を検証する場合、{{mcd_local_file}}に以下の内容を追記する。
   - lockPref("plugin.load_flash_only", false);

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. アドオンマネージャを開き、「プラグイン」を選択する。
    - 確認項目
        1. 個別の制御を行っていないNPAPIプラグインが既定の状態で{{#Plugin-10-1}}無効化されている。（Plugin-10-1）{{/Plugin-10-1}}{{#Plugin-10-2}}有効化されている。（Plugin-10-2）{{/Plugin-10-2}}{{#Plugin-10-3}}「実行時に確認する」が選択されている。(Plugin-10-3){{/Plugin-10-3}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
1. 各プラグインの制御が可能であるかどうか自体を検証した場合、{{mcd_local_file}}に加えた変更を元に戻す。
{{/Plugin-10}}

## プラグインの個別制御

### 確認する項目

{{#Security-24}} - Security-24-\* {{/Security-24}}
{{#Plugin-1}} - Plugin-1-\* {{/Plugin-1}}
{{#Plugin-2}} - Plugin-2-\* {{/Plugin-2}}
{{#Plugin-3}} - Plugin-3-\* {{/Plugin-3}}
{{#Plugin-4}} - Plugin-4-\* {{/Plugin-4}}
{{#Plugin-5}} - Plugin-5-\* {{/Plugin-5}}
{{#Plugin-6}} - Plugin-6-\* {{/Plugin-6}}
{{#Plugin-7}} - Plugin-7-\* {{/Plugin-7}}
{{#Plugin-8}} - Plugin-8-\* {{/Plugin-8}}
{{#Plugin-9}} - Plugin-9-\* {{/Plugin-9}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Plugin-1}}1. Javaプラグインが未導入の場合、` {{java_download_url}}` からJavaプラグインのインストーラをダウンロードし、インストールしておく。(Plugin-1-\*){{/Plugin-1}}
{{#Plugin-2 || Security-24}}
1. Adobe Flashプラグインが未導入の場合、`{{flash_download_url}} ` からAdobe Flash プラグインのインストーラをダウンロードし、インストールしておく。{{#Plugin-2}}(Plugin-2-\*){{/Plugin-2}}{{#Security-24}}(Security-24-\*){{/Security-24}}
{{/Plugin-2 || Security-24}}
{{#Plugin-3}}1. Adobe Acrobatプラグインが未導入の場合、`{{acrobat__download_url}}` からAdobe Acrobat Reader プラグインのインストーラをダウンロードし、インストールしておく。(Plugin-3-\*){{/Plugin-3}}
{{#Plugin-4}}1. Adobe Shockwaveプラグインが未導入の場合、`{{shockwave__download_url}}` からAdobe Shockwave プラグインのインストーラをダウンロードし、インストールしておく。(Plugin-4-\*){{/Plugin-4}}
{{#Plugin-5}}1. Silverlightプラグインが未導入の場合、`{{silverlight_download_url}}` からSilverlight プラグインのインストーラをダウンロードし、インストールしておく。(Plugin-5-\*){{/Plugin-5}}
{{#Plugin-6}}1. Windows Media Playerプラグインが未導入の場合、`{{wmp__download_url}}` からWindows Media Playerプラグインをダウンロードし、インストールしておく。(Plugin-6-\*){{/Plugin-6}}
{{#Plugin-7}}1. Cisco WebExtプラグインが未導入の場合、Cisco WebExプラグインを入手し、インストールしておく。（※メタインストーラにnpatgpc.dllを含めているときはスキップ）(Plugin-7-\*){{/Plugin-7}}
{{#Plugin-9}}1. Icead Teaプラグインが未導入の場合、Icead Teaプラグインをシステムにインストールしておく。{{/Plugin-9}}
1. 以下のアドオンを無効化する。
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#Plugin-1 && Plugin-2 && Plugin-3 && Plugin-4 && Plugin-5 && Plugin-6 && Plugin-7 && Plugin-9}}
1. 個別の設定が無く、各プラグインの制御が可能であるかどうか自体を検証する場合、各設定ファイルに以下の内容を追記する。
    - {{mcd_local_file}}:

        ~~~
        lockPref("plugin.load_flash_only", false);

        lockPref("plugin.state.java", 2);
        lockPref("plugin.state.npdeployjava", 2);
        lockPref("plugin.state.flash", 2);
        lockPref("plugin.state.nppdf", 2);
        lockPref("plugin.state.np32dsw", 2);
        lockPref("plugin.state.npctrl", 2);
        lockPref("plugin.state.np-mswmp", 2);
        lockPref("plugin.state.npatgpc", 2);
        lockPref("plugin.state.libnpjp", 2);

        lockPref("extensions.autopermission.sites.example.com", [
          "plugin:java=3",
          "plugin-vulnerable:java=3",
          "plugin:npdeployjava=3",
          "plugin-vulnerable:npdeployjava=3",
          "plugin:flash=3",
          "plugin-vulnerable:flash=3",
          "plugin:nppdf=3",
          "plugin-vulnerable:nppdf=3",
          "plugin:np32dsw=3",
          "plugin-vulnerable:np32dsw=3",
          "plugin:npctrl=3",
          "plugin-vulnerable:npctrl=3",
          "plugin:np-mswmp=3",
          "plugin-vulnerable:np-mswmp=3",
          "plugin:npatgpc=3",
          "plugin-vulnerable:npatgpc=3",
          "plugin:libnpjp=3",
          "plugin-vulnerable:libnpjp=3"
        ].join(','));
        clearPref("extensions.autopermission.sites.example.com.lastValue");
        ~~~

    - default.permissions:

        ~~~
        host	plugin:java	3	http://example.net
        host	plugin-vulnerable:java	3	http://example.net
        host	plugin:npdeployjava	3	http://example.net
        host	plugin-vulnerable:npdeployjava	3	http://example.net
        host	plugin:flash	3	http://example.net
        host	plugin-vulnerable:flash	3	http://example.net
        host	plugin:nppdf	3	http://example.net
        host	plugin-vulnerable:nppdf	3	http://example.net
        host	plugin:np32dsw	3	http://example.net
        host	plugin-vulnerable:np32dsw	3	http://example.net
        host	plugin:npctrl	3	http://example.net
        host	plugin-vulnerable:npctrl	3	http://example.net
        host	plugin:np-mswmp	3	http://example.net
        host	plugin-vulnerable:np-mswmp	3	http://example.net
        host	plugin:npatgpc	3	http://example.net
        host	plugin-vulnerable:npatgpc	3	http://example.net
        host	plugin:libnpjp	3	http://example.net
        host	plugin-vulnerable:libnpjp	3	http://example.net
        ~~~
{{/Plugin-1 && Plugin-2 && Plugin-3 && Plugin-4 && Plugin-5 && Plugin-6 && Plugin-7 && Plugin-9}}


### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. アドオンマネージャを開き、「プラグイン」を選択する。
    - 確認項目
{{#Plugin-1}}
        1. Javaプラグインの項目が表示されており、{{#Plugin-1-1}}「無効化する」が選択されている。(Plugin-1-1){{/Plugin-1-1}}{{#Plugin-1-2}}「常に有効化する」が選択されている。(Plugin-1-2){{/Plugin-1-2}}{{#Plugin-1-3}}「実行時に確認する」が選択されている。(Plugin-1-3){{/Plugin-1-3}}
{{/Plugin-1}}
{{#Plugin-2}}
        1. Adobe Flashプラグインの項目が表示されており、{{#Plugin-2-1}}「無効化する」が選択されている。(Plugin-2-1){{/Plugin-2-1}}{{#Plugin-2-2}}「常に有効化する」が選択されている。(Plugin-2-2){{/Plugin-2-2}}{{#Plugin-2-3}}「実行時に確認する」が選択されている。(Plugin-2-3){{/Plugin-2-3}}
{{/Plugin-2}}
{{#Plugin-3}}
        1. Adobe Readerプラグインの項目が表示されており、{{#Plugin-3-1}}「無効化する」が選択されている。(Plugin-3-1){{/Plugin-3-1}}{{#Plugin-3-2}}「常に有効化する」が選択されている。(Plugin-3-2){{/Plugin-3-2}}{{#Plugin-3-3}}「実行時に確認する」が選択されている。(Plugin-3-3){{/Plugin-3-3}}
{{/Plugin-3}}
{{#Plugin-4}}
        1. Adobe Shockwaveプラグインの項目が表示されており、{{#Plugin-4-1}}「無効化する」が選択されている。(Plugin-4-1){{/Plugin-4-1}}{{#Plugin-4-2}}「常に有効化する」が選択されている。(Plugin-4-2){{/Plugin-4-2}}{{#Plugin-4-3}}「実行時に確認する」が選択されている。(Plugin-4-3){{/Plugin-4-3}}
{{/Plugin-4}}
{{#Plugin-5}}
        1. Silverlightプラグインの項目が表示されており、{{#Plugin-5-1}}「無効化する」が選択されている。(Plugin-5-1){{/Plugin-5-1}}{{#Plugin-5-2}}「常に有効化する」が選択されている。(Plugin-5-2){{/Plugin-5-2}}{{#Plugin-5-3}}「実行時に確認する」が選択されている。(Plugin-5-3){{/Plugin-5-3}}
{{/Plugin-5}}
{{#Plugin-6}}
        1. Windows Media Playerプラグインの項目が表示されており、{{#Plugin-6-1}}「無効化する」が選択されている。(Plugin-6-1){{/Plugin-6-1}}{{#Plugin-6-2}}「常に有効化する」が選択されている。(Plugin-6-2){{/Plugin-6-2}}{{#Plugin-6-3}}「実行時に確認する」が選択されている。(Plugin-6-3){{/Plugin-6-3}}
{{/Plugin-6}}
{{#Plugin-7}}
        1. Cisco WebExプラグインの項目（ActiveTouch General Plugin Container）が表示されており、{{#Plugin-7-1}}「無効化する」が選択されている。(Plugin-7-1){{/Plugin-7-1}}{{#Plugin-7-2}}「常に有効化する」が選択されている。(Plugin-7-2){{/Plugin-7-2}}{{#Plugin-7-3}}「実行時に確認する」が選択されている。(Plugin-7-3){{/Plugin-7-3}}
{{/Plugin-7}}
{{#Plugin-9}}
        1. Icead Teaプラグインの項目が表示されており、{{#Plugin-9-1}}「無効化する」が選択されている。(Plugin-9-1){{/Plugin-9-1}}{{#Plugin-9-2}}「常に有効化する」が選択されている。(Plugin-9-2){{/Plugin-9-2}}{{#Plugin-9-3}}「実行時に確認する」が選択されている。(Plugin-9-3){{/Plugin-9-3}}
{{/Plugin-9}}
{{#Plugin-8}}
        1. OpenH264のプラグインが{{#Plugin-8-1}}表示される。(Plugin-8-1){{/Plugin-8-1}}{{#Plugin-8-2}}表示されない。(Plugin-8-2){{/Plugin-8-2}}
        1. 「Primetime Content Decryption Module」が{{#Plugin-8-1}}表示される。(Plugin-8-1){{/Plugin-8-1}}{{#Plugin-8-2}}表示されない。(Plugin-8-2){{/Plugin-8-2}}
{{/Plugin-8}}
{{#Security-24}}
1. Flashプラグインの「設定」ボタンをクリックする。
    - 確認項目
        1. 「Adobe Flashの保護モードを有効化」に{{#Security-24-1}}チェックが入っている。（Security-24-1）{{/Security-24-1}}{{#Security-24-2}}チェックが入っていない。（Security-24-2）{{/Security-24-2}}
{{/Security-24}}
{{#Plugin-8 && use_globalchromecss}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
    - 確認項目
        1. 「コンテンツ」配下に「DRMコンテンツ」グループが{{#Plugin-8-1}}ある。(Plugin-8-1){{/Plugin-8-1}}{{#Plugin-8-2}}無い。(Plugin-8-2){{/Plugin-8-2}}
{{/Plugin-8 && use_globalchromecss}}
{{#Plugin-1 && Plugin-2 && Plugin-3 && Plugin-4 && Plugin-5 && Plugin-6 && Plugin-7 && Plugin-9}}
1. Permissions Auto Registererによる各プラグインのサイト別制御が可能であるかどうか自体を検証する場合、`http://example.com` を開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開き、「サイト別設定」タブを選択する。
    - 確認項目
        1. 各プラグインの設定が「毎回確認する」になっている。
1. default.permissionsによる各プラグインのサイト別制御が可能であるかどうか自体を検証する場合、`http://example.net` を開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開き、「サイト別設定」タブを選択する。
    - 確認項目
        1. 各プラグインの設定が「毎回確認する」になっている。
{{/Plugin-1 && Plugin-2 && Plugin-3 && Plugin-4 && Plugin-5 && Plugin-6 && Plugin-7 && Plugin-9}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#Plugin-1 && Plugin-2 && Plugin-3 && Plugin-4 && Plugin-5 && Plugin-6 && Plugin-7 && Plugin-9}}
1. 各プラグインの制御が可能であるかどうか自体の検証のために追加した設定を削除する。
{{/Plugin-1 && Plugin-2 && Plugin-3 && Plugin-4 && Plugin-5 && Plugin-6 && Plugin-7 && Plugin-9}}

{{#External-1}}
## ファイルをダウンロードして外部アプリケーションで開く際の挙動の制御

### 確認する項目

- External-1-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
2. エクスプローラを起動して、アドレスバーに `%temp%` と入力し、システムのテンポラリフォルダを開く。
3. ファイルを更新日時順で並べ替えて、新しいファイルが出現したら分かるようにしておく。
4. この検証手順書自体のファイルをWebサーバにアップロードするか、`odt sample` のようなキーワードでWebを検索するなどして、外部アプリケーションで開く必要があるファイルのダウンロード用リンクを用意しておく。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. 外部アプリケーションで開く必要があるファイルへのリンクをクリックする。
1. 「次のファイルを開こうとしています」のダイアログが表示されたら、起動する外部アプリケーションを選択して「OK」をクリックする。
1. テンポラリフォルダの内容を確認する。
    - 確認項目
        1. ダウンロードしたファイルがテンポラリフォルダに保存されている。(External-1-1/2)
        1. テンポラリファイルのプロパティにおいて、「読み取り専用」に{{#External-1-1}}チェックが入っている。(External-1-1){{/External-1-1}}{{#External-1-2}}チェックが入っていない。(External-1-2){{/External-1-2}}
1. 外部アプリケーションを終了しFirefoxも終了して、テンポラリフォルダの内容を確認する。
    - 確認項目
        1. ダウンロードしたファイルが{{#External-1-1}}テンポラリフォルダから消えている。(External-1-1){{/External-1-1}}{{#External-1-2}}テンポラリフォルダに残っている。(External-1-2){{/External-1-2}}
{{/External-1}}

## IE Viewの制御

### 確認する項目

{{#Addon-IEView-1-2}} - Addon-IEView-1-2 {{/Addon-IEView-1-2}}
{{#Addon-IEView-2-1}} - Addon-IEView-2-1 {{/Addon-IEView-2-1}}
{{#Addon-IEView-3-2}} - Addon-IEView-3-2 {{/Addon-IEView-3-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. 自動的にIEを起動するよう設定されたページへのリンクがあるページを開き、そのリンクをクリックする。
    - 確認項目
{{#Addon-IEView-1-2}}
        1. IEが起動する。（Addon-IEView-1-2）
{{/Addon-IEView-1-2}}
{{#Addon-IEView-2-1}}
        1. 指定したパスのIEが起動しており、指定したオプションも反映されている。（Addon-IEView-2-1）
{{/Addon-IEView-2-1}}
<!--/GROUP-->
{{#Addon-IEView-3-2}}
1. 自動的にIEを起動するよう設定されたページ以外のページを開く。
1. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）をクリックし、サブメニューの「インスペクター」をクリックする。
1. 「HTMLを検索」欄に「#src_xsale」と入力し、Enterキーを押す。
    - 確認項目
        1. 「見つかりませんでした。」と表示される。（Addon-IEView-3-2）
{{/Addon-IEView-3-2}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_globalchromecss}}    1. globalChrome.css{{/use_globalchromecss}}
{{#use_uitextoverrider}}    1. UI Text Overrider{{/use_uitextoverrider}}

<!--======================================================================-->

# キーボードショートカット、メニュー項目のカスタマイズ

## タブとウィンドウの操作

### 確認する項目

{{#MenuShortcut-1}} - MenuShortcut-1 {{/MenuShortcut-1}}
{{#MenuShortcut-2}} - MenuShortcut-2 {{/MenuShortcut-2}}
{{#MenuShortcut-3}} - MenuShortcut-3 {{/MenuShortcut-3}}
{{#MenuShortcut-4}} - MenuShortcut-4 {{/MenuShortcut-4}}
{{#MenuShortcut-5}} - MenuShortcut-5 {{/MenuShortcut-5}}
{{#MenuShortcut-10}} - MenuShortcut-10 {{/MenuShortcut-10}}
{{#MenuShortcut-62}} - MenuShortcut-62 {{/MenuShortcut-62}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
    - 確認項目
{{#MenuShortcut-3}}
        1. 「Ctrl-Shift-P」を押して、新しいプライベートウィンドウが開かれない。(MenuShortcut-3)
{{/MenuShortcut-3}}
{{#MenuShortcut-62}}
        1. 「Ctrl-T」を押して、新しいタブが開かれない。(MenuShortcut-62)
{{/MenuShortcut-62}}
<!--/GROUP-->
<!--GROUP-->
1. ロケーションバーに `about:` と入力し、Alt-Enterでタブとして開く。
1. 開かれたタブを閉じる。
1. ロケーションバーに `about:` と入力し、Alt-Enterでタブとして開く。
1. 開かれたタブをドラッグしてウィンドウ外にドロップし、ウィンドウとして開く。
1. 開かれたウィンドウを閉じる。
    - 確認項目
{{#MenuShortcut-1}}
        1. 「Ctrl-Shift-T」を押して、閉じたタブが復元されない。(MenuShortcut-1)
{{/MenuShortcut-1}}
{{#MenuShortcut-2}}
        1. 「Ctrl-Shift-N」を押して、閉じたウィンドウが復元されない。(MenuShortcut-2)
{{/MenuShortcut-2}}
<!--/GROUP-->
<!--GROUP-->
1. 「ファイル」メニューを開く。
    - 確認項目
{{#MenuShortcut-3}}
        1. 「新しいプライベートウィンドウを開く」が存在しない。(MenuShortcut-3)
{{/MenuShortcut-3}}
{{#MenuShortcut-4}}
        1. 「ページのURLをメールで送信」が存在しない。(MenuShortcut-4)
{{/MenuShortcut-4}}
{{#MenuShortcut-5}}
        1. 「オフライン作業」が存在しない。(MenuShortcut-5)
{{/MenuShortcut-5}}
{{#MenuShortcut-62}}
        1. 「新しいタブ」が存在しない。(MenuShortcut-62)
{{/MenuShortcut-62}}
<!--/GROUP-->
<!--GROUP-->
1. 「履歴」メニューを開く。
    - 確認項目
{{#MenuShortcut-1}}
        1. 「最近閉じたタブ」が存在しない。(MenuShortcut-1)
{{/MenuShortcut-1}}
{{#MenuShortcut-2}}
        1. 「最近閉じたウィンドウ」が存在しない。(MenuShortcut-2)
{{/MenuShortcut-2}}
<!--/GROUP-->
{{#MenuShortcut-10}}
1. 「ツール」メニューを開く。
    - 確認項目
        1. 「ウェブ開発」が存在しない。(MenuShortcut-10)
        1. 「ページ情報」の前にセパレータが存在しない。(MenuShortcut-10)
{{/MenuShortcut-10}}
{{#MenuShortcut-1}}
1. タブの上で右クリックする。
    - 確認項目
        1. 「閉じたタブを開き直す」が存在しない。(MenuShortcut-1)
1. タブバーの「+」ボタン上で右クリックする。
    - 確認項目
        1. 「閉じたタブを開き直す」が存在しない。(MenuShortcut-1)
{{/MenuShortcut-1}}
1. パネルメニューを開く。
{{#MenuShortcut-3}}
    - 確認項目
        1. 「新しいプライベートウィンドウ」が存在しない。(MenuShortcut-3)
{{/MenuShortcut-3}}
<!--GROUP-->
1. パネルメニュー内の「履歴」をクリックする。
    - 確認項目
{{#MenuShortcut-1}}
        1. 「最近閉じたタブ」セクションが存在しない。(MenuShortcut-1)
{{/MenuShortcut-1}}
{{#MenuShortcut-2}}
        1. 「最近閉じたウィンドウ」セクションが存在しない。(MenuShortcut-2)
{{/MenuShortcut-2}}
<!--/GROUP-->
{{#MenuShortcut-5}}
1. パネルメニュー内の「開発ツール」をクリックする。
    - 確認項目
        1. 「オフライン作業」セクションが存在しない。(MenuShortcut-5)
{{/MenuShortcut-5}}
<!--GROUP-->
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
{{#MenuShortcut-4}}
        1. 「ページのURLをメールで送信」が存在しない。(MenuShortcut-4)
{{/MenuShortcut-4}}
{{#MenuShortcut-10}}
        1. 「開発ツール」が存在しない。(MenuShortcut-10)
{{/MenuShortcut-10}}
<!--/GROUP-->

## ツール

### 確認する項目

{{#MenuShortcut-7}} - MenuShortcut-7 {{/MenuShortcut-7}}
{{#MenuShortcut-11}} - MenuShortcut-11 {{/MenuShortcut-11}}
{{#MenuShortcut-12}} - MenuShortcut-12 {{/MenuShortcut-12}}
{{#MenuShortcut-13}} - MenuShortcut-13 {{/MenuShortcut-13}}
{{#MenuShortcut-14}} - MenuShortcut-14 {{/MenuShortcut-14}}
{{#MenuShortcut-15}} - MenuShortcut-15 {{/MenuShortcut-15}}
{{#MenuShortcut-16}} - MenuShortcut-16 {{/MenuShortcut-16}}
{{#MenuShortcut-17}} - MenuShortcut-17 {{/MenuShortcut-17}}
{{#MenuShortcut-18}} - MenuShortcut-18 {{/MenuShortcut-18}}
{{#MenuShortcut-20}} - MenuShortcut-20 {{/MenuShortcut-20}}
{{#MenuShortcut-21}} - MenuShortcut-21 {{/MenuShortcut-21}}
{{#MenuShortcut-22}} - MenuShortcut-22 {{/MenuShortcut-22}}
{{#MenuShortcut-23}} - MenuShortcut-23 {{/MenuShortcut-23}}
{{#MenuShortcut-24}} - MenuShortcut-24 {{/MenuShortcut-24}}
{{#MenuShortcut-25}} - MenuShortcut-25 {{/MenuShortcut-25}}
{{#MenuShortcut-26}} - MenuShortcut-26 {{/MenuShortcut-26}}
{{#MenuShortcut-28}} - MenuShortcut-28 {{/MenuShortcut-28}}
{{#MenuShortcut-29}} - MenuShortcut-29 {{/MenuShortcut-29}}
{{#MenuShortcut-64}} - MenuShortcut-64 {{/MenuShortcut-64}}
{{#MenuShortcut-65}} - MenuShortcut-65 {{/MenuShortcut-65}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
    - 確認項目
{{#MenuShortcut-7}}        1. 「Ctrl-J」を押して、ダウンロード済みファイル一覧が開かれない。(MenuShortcut-7){{/MenuShortcut-7}}
{{#MenuShortcut-11}}
        1. 「Ctrl-Shift-I」を押して、開発ツールが開かれない。(MenuShortcut-11)
        1. 「F12」を押して、開発ツールが開かれない。(MenuShortcut-11)
{{/MenuShortcut-11}}
{{#MenuShortcut-12}}        1. 「Ctrl-Shift-C」を押して、インスペクタが開かれない。(MenuShortcut-12){{/MenuShortcut-12}}
{{#MenuShortcut-13}}        1. 「Ctrl-Shift-K」を押して、Webコンソールが開かれない。(MenuShortcut-13){{/MenuShortcut-13}}
{{#MenuShortcut-14}}        1. 「Ctrl-Shift-S」を押して、デバッガが開かれない。(MenuShortcut-14){{/MenuShortcut-14}}
{{#MenuShortcut-15}}        1. 「Shift-F7」を押して、スタイルエディタが開かれない。(MenuShortcut-15){{/MenuShortcut-15}}
{{#MenuShortcut-16}}        1. 「Shift-F5」を押して、プロファイラが開かれない。(MenuShortcut-16){{/MenuShortcut-16}}
{{#MenuShortcut-17}}        1. 「Ctrl-Shift-Q」を押して、ネットワークモニターが開かれない。(MenuShortcut-17){{/MenuShortcut-17}}
{{#MenuShortcut-18}}        1. 「Shitf-F2」を押して、開発ツールバーが開かれない。(MenuShortcut-18){{/MenuShortcut-18}}
{{#MenuShortcut-20}}        1. 「Shift-F8」を押して、WebIDEが開かれない。(MenuShortcut-20){{/MenuShortcut-20}}
{{#MenuShortcut-21}}        1. 「Ctrl-Shift-Alt-I」を押して、ブラウザツールボックスが開かれない。(MenuShortcut-21){{/MenuShortcut-21}}
{{#MenuShortcut-22}}        1. 「Ctrl-Shift-J」を押して、ブラウザコンソールが開かれない。(MenuShortcut-22){{/MenuShortcut-22}}
{{#MenuShortcut-23}}        1. 「Ctrl-Shift-M」を押して、レスポンシブデザインビューが開かれない。(MenuShortcut-23){{/MenuShortcut-23}}
{{#MenuShortcut-25}}        1. 「Shift-F4」を押してスクラッチパッド、が開かれない。(MenuShortcut-25){{/MenuShortcut-25}}
{{#MenuShortcut-26}}        1. 「Ctrl-U」を押して、ページのソースが開かれない。(MenuShortcut-26){{/MenuShortcut-26}}
{{#MenuShortcut-7}}
1. 「ツール」メニューを開く。
     - 確認項目
        1. 「ダウンロード」が存在しない。(MenuShortcut-7)
{{/MenuShortcut-7}}
<!--GROUP-->
1. 「ツール」メニュー内の「ウェブ開発」を開く。
    - 確認項目
{{#MenuShortcut-11}}        1. 「開発ツールを表示」が存在しない。(MenuShortcut-11){{/MenuShortcut-11}}
{{#MenuShortcut-12}}        1. 「インスペクタ」が存在しない。(MenuShortcut-12){{/MenuShortcut-12}}
{{#MenuShortcut-13}}        1. 「Webコンソール」が存在しない。(MenuShortcut-13){{/MenuShortcut-13}}
{{#MenuShortcut-14}}        1. 「デバッガ」が存在しない。(MenuShortcut-14){{/MenuShortcut-14}}
{{#MenuShortcut-15}}        1. 「スタイルエディタ」が存在しない。(MenuShortcut-15){{/MenuShortcut-15}}
{{#MenuShortcut-16}}        1. 「パフォーマンス」が存在しない。(MenuShortcut-16){{/MenuShortcut-16}}
{{#MenuShortcut-17}}        1. 「ネットワーク」が存在しない。(MenuShortcut-17){{/MenuShortcut-17}}
{{#MenuShortcut-18}}        1. 「開発ツールバー」が存在しない。(MenuShortcut-18){{/MenuShortcut-18}}
{{#MenuShortcut-20}}        1. 「WebIDE」が存在しない。(MenuShortcut-20){{/MenuShortcut-20}}
{{#MenuShortcut-21}}        1. 「ブラウザツールボックス」が存在しない。(MenuShortcut-21){{/MenuShortcut-21}}
{{#MenuShortcut-22}}        1. 「ブラウザコンソール」が存在しない。(MenuShortcut-22){{/MenuShortcut-22}}
{{#MenuShortcut-23}}        1. 「レスポンシブデザインビュー」が存在しない。(MenuShortcut-23){{/MenuShortcut-23}}
{{#MenuShortcut-24}}        1. 「スポイト」が存在しない。(MenuShortcut-24){{/MenuShortcut-24}}
{{#MenuShortcut-25}}        1. 「スクラッチパッド」が存在しない。(MenuShortcut-25){{/MenuShortcut-25}}
{{#MenuShortcut-26}}        1. 「ページのソース」が存在しない。(MenuShortcut-26){{/MenuShortcut-26}}
{{#MenuShortcut-28}}        1. 「接続...」が存在しない。(MenuShortcut-28){{/MenuShortcut-28}}
{{#MenuShortcut-29}}        1. 「その他のツールを入手」が存在しない。(MenuShortcut-29){{/MenuShortcut-29}}
{{#MenuShortcut-64}}        1. 「Service Worker」が存在しない（MenuShortcut-64）{{/MenuShortcut-64}}
{{#MenuShortcut-65}}        1. 「ブラウザーコンテンツツールボックス」が存在しない（MenuShortcut-65）{{/MenuShortcut-65}}
<!--/GROUP-->
<!--GROUP-->
1. パネルメニューを開き、パネルメニュー内の「開発ツール」をクリックする。
    - 確認項目
{{#MenuShortcut-11}}        1. 「開発ツールを表示」が存在しない。(MenuShortcut-11){{/MenuShortcut-11}}
{{#MenuShortcut-12}}        1. 「インスペクタ」が存在しない。(MenuShortcut-12){{/MenuShortcut-12}}
{{#MenuShortcut-13}}        1. 「Webコンソール」が存在しない。(MenuShortcut-13){{/MenuShortcut-13}}
{{#MenuShortcut-14}}        1. 「デバッガ」が存在しない。(MenuShortcut-14){{/MenuShortcut-14}}
{{#MenuShortcut-15}}        1. 「スタイルエディタ」が存在しない。(MenuShortcut-15){{/MenuShortcut-15}}
{{#MenuShortcut-16}}        1. 「パフォーマンス」が存在しない。(MenuShortcut-16){{/MenuShortcut-16}}
{{#MenuShortcut-17}}        1. 「ネットワーク」が存在しない。(MenuShortcut-17){{/MenuShortcut-17}}
{{#MenuShortcut-18}}        1. 「開発ツールバー」が存在しない。(MenuShortcut-18){{/MenuShortcut-18}}
{{#MenuShortcut-20}}        1. 「WebIDE」が存在しない。(MenuShortcut-20){{/MenuShortcut-20}}
{{#MenuShortcut-21}}        1. 「ブラウザツールボックス」が存在しない。(MenuShortcut-21){{/MenuShortcut-21}}
{{#MenuShortcut-22}}        1. 「ブラウザコンソール」が存在しない。(MenuShortcut-22){{/MenuShortcut-22}}
{{#MenuShortcut-23}}        1. 「レスポンシブデザインビュー」が存在しない。(MenuShortcut-23){{/MenuShortcut-23}}
{{#MenuShortcut-24}}        1. 「スポイト」が存在しない。(MenuShortcut-24){{/MenuShortcut-24}}
{{#MenuShortcut-25}}        1. 「スクラッチパッド」が存在しない。(MenuShortcut-25){{/MenuShortcut-25}}
{{#MenuShortcut-26}}        1. 「ページのソース」が存在しない。(MenuShortcut-26){{/MenuShortcut-26}}
{{#MenuShortcut-28}}        1. 「接続...」が存在しない。(MenuShortcut-28){{/MenuShortcut-28}}
{{#MenuShortcut-29}}        1. 「その他のツールを入手」が存在しない。(MenuShortcut-29){{/MenuShortcut-29}}
{{#MenuShortcut-64}}        1. 「Service Worker」が存在しない（MenuShortcut-64）{{/MenuShortcut-64}}
{{#MenuShortcut-65}}        1. 「ブラウザーコンテンツツールボックス」が存在しない（MenuShortcut-65）{{/MenuShortcut-65}}
<!--/GROUP-->
{{#MenuShortcut-7}}
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
        1. 「ダウンロード」が存在しない。(MenuShortcut-7)
{{/MenuShortcut-7}}

## ヘルプ

### 確認する項目

{{#MenuShortcut-30}} - MenuShortcut-30 {{/MenuShortcut-30}}
{{#MenuShortcut-31}} - MenuShortcut-31 {{/MenuShortcut-31}}
{{#MenuShortcut-32}} - MenuShortcut-32 {{/MenuShortcut-32}}
{{#MenuShortcut-33}} - MenuShortcut-33 {{/MenuShortcut-33}}
{{#MenuShortcut-35}} - MenuShortcut-35 {{/MenuShortcut-35}}
{{#MenuShortcut-36}} - MenuShortcut-36 {{/MenuShortcut-36}}
{{#MenuShortcut-37}} - MenuShortcut-37 {{/MenuShortcut-37}}
{{#MenuShortcut-38}} - MenuShortcut-38 {{/MenuShortcut-38}}
{{#MenuShortcut-39}} - MenuShortcut-39 {{/MenuShortcut-39}}
{{#MenuShortcut-40}} - MenuShortcut-40 {{/MenuShortcut-40}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. 「ヘルプ」メニューを開く。
    - 確認項目
{{#MenuShortcut-30}}        1. 「Firefoxヘルプ」が存在しない。(MenuShortcut-30) {{/MenuShortcut-30}}
{{#MenuShortcut-31}}        1. 「Firefoxツアー」が存在しない。(MenuShortcut-31){{/MenuShortcut-31}}
{{#MenuShortcut-32}}        1. 「キーボードショートカット」が存在しない。(MenuShortcut-32){{/MenuShortcut-32}}
{{#MenuShortcut-33}}        1. 「Firefoxヘルスレポート」が存在しない。(MenuShortcut-33){{/MenuShortcut-33}}
{{#MenuShortcut-35}}        1. 「トラブルシューティング情報」が存在しない。(MenuShortcut-35){{/MenuShortcut-35}}
{{#MenuShortcut-36}}        1. 「フィードバックを送信」が存在しない。(MenuShortcut-36){{/MenuShortcut-36}}
{{#MenuShortcut-37}}        1. 「アドオンを無効にして再起動」が存在しない。(MenuShortcut-37){{/MenuShortcut-37}}
{{#MenuShortcut-38}}        1. 「詐欺サイトを報告」が存在しない。(MenuShortcut-38){{/MenuShortcut-38}}
{{#MenuShortcut-39}}        1. 「誤警告を報告」が存在しない。(MenuShortcut-39){{/MenuShortcut-39}}
{{#MenuShortcut-40}}        1. 「Firefoxについて」の前にセパレータが存在しない。(MenuShortcut-40){{/MenuShortcut-40}}
<!--/GROUP-->
<!--GROUP-->
1. パネルメニューを開き、パネルメニュー内の「？」をクリックする。
    - 確認項目
{{#MenuShortcut-30}}        1. 「Firefoxヘルプ」が存在しない。(MenuShortcut-30) {{/MenuShortcut-30}}
{{#MenuShortcut-31}}        1. 「Firefoxツアー」が存在しない。(MenuShortcut-31){{/MenuShortcut-31}}
{{#MenuShortcut-32}}        1. 「キーボードショートカット」が存在しない。(MenuShortcut-32){{/MenuShortcut-32}}
{{#MenuShortcut-33}}        1. 「Firefoxヘルスレポート」が存在しない。(MenuShortcut-33){{/MenuShortcut-33}}
{{#MenuShortcut-35}}        1. 「トラブルシューティング情報」が存在しない。(MenuShortcut-35){{/MenuShortcut-35}}
{{#MenuShortcut-36}}        1. 「フィードバックを送信」が存在しない。(MenuShortcut-36){{/MenuShortcut-36}}
{{#MenuShortcut-37}}        1. 「アドオンを無効にして再起動」が存在しない。(MenuShortcut-37){{/MenuShortcut-37}}
{{#MenuShortcut-38}}        1. 「詐欺サイトを報告」が存在しない。(MenuShortcut-38){{/MenuShortcut-38}}
{{#MenuShortcut-39}}        1. 「誤警告を報告」が存在しない。(MenuShortcut-39){{/MenuShortcut-39}}
{{#MenuShortcut-40}}        1. 「Firefoxについて」の前にセパレータが存在しない。(MenuShortcut-40){{/MenuShortcut-40}}
<!--/GROUP-->

## 書字方向の切り替えの制御

### 確認する項目

{{#MenuShortcut-41}} - MenuShortcut-41 {{/MenuShortcut-41}}
{{#MenuShortcut-42}} - MenuShortcut-42 {{/MenuShortcut-42}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、`bidi.browser.ui` の値を`true`に設定する。
1. Firefoxを終了する。
1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. `https://addons.mozilla.org/` など、テキスト入力欄があるWebページを開く。
{{#MenuShortcut-41}}
1. テキスト入力欄をクリックしてフォーカスした状態にする。
    - 確認項目
        1. 「Ctrl-Shift-X」を押して、テキスト入力欄の書字方向が切り替わらない(MenuShortcut-41)
1. テキスト入力欄の中で右クリックしてコンテキストメニューを開く。
    - 確認項目
        1. 「テキストの記述方向を切り替える」が存在しない。(MenuShortcut-41)
        2. 「スペルチェックを行う」の下にセパレータが存在しない。(MenuShortcut-41)
{{/MenuShortcut-41}}
{{#MenuShortcut-42}}
1. ページ内の何もない所で右クリックしてコンテキストメニューを開く。
    - 確認項目
        1. 「ページの記述方向を切り替える」が存在しない。(MenuShortcut-42)
        2. 「ページの情報を表示」の下にセパレータが存在しない。(MenuShortcut-42)
{{/MenuShortcut-42}}
{{#MenuShortcut-41}}
1. 「編集」メニューを開く。
    - 確認項目
        1. 「テキストの記述方向を切り替える」が存在しない。(MenuShortcut-41)
{{/MenuShortcut-41}}
{{#MenuShortcut-42}}
1. 「表示」メニューを開く。
    - 確認項目
        1. 「ページの記述方向を切り替える」が存在しない。(MenuShortcut-42)
{{/MenuShortcut-42}}

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaboutconfig}}    1. Disable about:config{{/use_disableaboutconfig}}

## 履歴とブックマーク

### 確認する項目

{{#MenuShortcut-43}} - MenuShortcut-43 {{/MenuShortcut-43}}
{{#MenuShortcut-44}} - MenuShortcut-44 {{/MenuShortcut-44}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#MenuShortcut-43}}
1. 「履歴」メニューを開く。
    - 確認項目
        1. メニュー内に、セパレータが単独で2連続表示されている箇所がない。(MenuShortcut-43)
{{/MenuShortcut-43}}
{{#MenuShortcut-44}}
1. 「ブックマーク」メニューを開く。
    - 確認項目
        1. 「ブックマークツールバー」が存在しない。(MenuShortcut-44)
        1. メニュー内に、セパレータが単独で2連続表示されている箇所がない。(MenuShortcut-44)
1. ツールバー上のブックマークボタンをクリックし、ブックマーク一覧を開く。
    - 確認項目
        1. 「ブックマークツールバー」が存在しない。(MenuShortcut-44)
        1. メニュー内に、セパレータが単独で2連続表示されている箇所がない。(MenuShortcut-44)
1. ツールバー上のブックマークボタンの上で右クリックし、「メニューに移動」を選択する。
1. パネルメニューを開き、パネルメニュー内の「ブックマーク」をクリックする。
    - 確認項目
        1. 「ブックマークツールバー」が存在しない。(MenuShortcut-44)
        1. メニュー内に、セパレータが単独で2連続表示されている箇所がない。(MenuShortcut-44)
{{/MenuShortcut-44}}

## コンテンツ領域のコンテキストメニュー

### 確認する項目

{{#MenuShortcut-46}} - MenuShortcut-46 {{/MenuShortcut-46}}
{{#MenuShortcut-47}} - MenuShortcut-47 {{/MenuShortcut-47}}
{{#MenuShortcut-48}} - MenuShortcut-48 {{/MenuShortcut-48}}
{{#MenuShortcut-49}} - MenuShortcut-49 {{/MenuShortcut-49}}
{{#MenuShortcut-50}} - MenuShortcut-50 {{/MenuShortcut-50}}
{{#MenuShortcut-51}} - MenuShortcut-51 {{/MenuShortcut-51}}
{{#MenuShortcut-52}} - MenuShortcut-52 {{/MenuShortcut-52}}
{{#MenuShortcut-54}} - MenuShortcut-54 {{/MenuShortcut-54}}
{{#MenuShortcut-55}} - MenuShortcut-55 {{/MenuShortcut-55}}
{{#MenuShortcut-57}} - MenuShortcut-57 {{/MenuShortcut-57}}
{{#MenuShortcut-63}} - MenuShortcut-63 {{/MenuShortcut-63}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. `https://addons.mozilla.org` を開き、何もない所で右クリックする。
    - 確認項目
{{#MenuShortcut-52}}        1. 「このページを共有」が存在しない。(MenuShortcut-52){{/MenuShortcut-52}}
{{#MenuShortcut-57}}        1. 「要素を調査」が存在しない。(MenuShortcut-57){{/MenuShortcut-57}}
<!--/GROUP-->
{{#MenuShortcut-54}}
1. ページ内の文字列を選択して右クリックする。
    - 確認項目
        1. 「選択範囲を共有」が存在しない。(MenuShortcut-54)
{{/MenuShortcut-54}}
<!--GROUP-->
1. ページ内のリンクの上で右クリックする。
    - 確認項目
{{#MenuShortcut-46}}        1. 「このリンクを共有」が存在しない。(MenuShortcut-46){{/MenuShortcut-46}}
{{#MenuShortcut-63}}        1. 「新しいタブで開く」が存在しない。(MenuShortcut-63){{/MenuShortcut-63}}
<!--/GROUP-->
<!--GROUP-->
1. ページ内に埋め込まれた画像の上で右クリックする。
    - 確認項目
{{#MenuShortcut-47}}        1. 「画像のURLをメールで送信」が存在しない。(MenuShortcut-47){{/MenuShortcut-47}}
{{#MenuShortcut-48}}        1. 「この画像を共有」が存在しない。(MenuShortcut-48){{/MenuShortcut-48}}
{{#MenuShortcut-55}}        1. 「デスクトップの背景に設定」が存在しない。(MenuShortcut-55){{/MenuShortcut-55}}
<!--/GROUP-->
<!--GROUP-->
1. `http://www.w3schools.com/html/html5\_video.asp` を開き、ページ内に埋め込まれた動画の上で右クリックする。
    - 確認項目
{{#MenuShortcut-49}}        1. 「動画のURLをメールで送信」が存在しない。(MenuShortcut-49){{/MenuShortcut-49}}
{{#MenuShortcut-50}}        1. 「この動画を共有」が存在しない。(MenuShortcut-50){{/MenuShortcut-50}}
<!--/GROUP-->
{{#MenuShortcut-51}}
1. `http://www.w3schools.com/html/tryit.asp?filename=tryhtml5_audio_all` を開き、ページ内に埋め込まれたオーディオコントロールの上で右クリックする。
    - 確認項目
        1. 「オーディオのURLをメールで送信」が存在しない。(MenuShortcut-51)
{{/MenuShortcut-51}}

## ポップアップブロック

### 確認する項目

{{#MenuShortcut-58}} - MenuShortcut-58 {{/MenuShortcut-58}}
{{#MenuShortcut-59}} - MenuShortcut-59 {{/MenuShortcut-59}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のカスタマイズを無効化する。
{{#Security-4-2 || Security-4-3 || Security-4-4}}    1. Security-4-2/3/4{{/Security-4-2 || Security-4-3 || Security-4-4}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. テストケースの `popupblock.html` を開く。
    - 確認項目
        1. 「1個のポップアップがブロックされました」と表示される。{{#MenuShortcut-58}}(MenuShortcut-58){{/MenuShortcut-58}}{{#MenuShortcut-59}}(MenuShortcut-59){{/MenuShortcut-59}}
1. 「設定」ボタンをクリックする。
    - 確認項目
{{#MenuShortcut-58}}        1. 「このサイトによるポップアップを許可する」が存在しない。(MenuShortcut-58){{/MenuShortcut-58}}
{{#MenuShortcut-59}}        1. 「ポップアップブロック設定を変更」が存在しない。(MenuShortcut-59){{/MenuShortcut-59}}

### 後始末

1. 以下のカスタマイズを有効化する。
{{#Security-4-2 || Security-4-3 || Security-4-4}}    1. Security-4-2/3/4{{/Security-4-2 || Security-4-3 || Security-4-4}}

<!--======================================================================-->

# その他のUIの非表示化

## 設定UIの非表示化

### 確認する項目

{{#Hide-1}} - Hide-1 {{/Hide-1}}
{{#Hide-2}} - Hide-2 {{/Hide-2}}
{{#Hide-3}} - Hide-3 {{/Hide-3}}
{{#Hide-6}} - Hide-6 {{/Hide-6}}
{{#Hide-7}} - Hide-7 {{/Hide-7}}
{{#Hide-9}} - Hide-9 {{/Hide-9}}
{{#Hide-10}} - Hide-10 {{/Hide-10}}
{{#Hide-11}} - Hide-11 {{/Hide-11}}
{{#Hide-12}} - Hide-12 {{/Hide-12}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Hide-6}}
    - 確認項目
        1. タブバー上に「+」ボタン（新しいタブを開くボタン）が表示されない。(Hide-6)
{{/Hide-6}}
<!--GROUP-->
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
    - 確認項目
{{#Hide-1}}        1. 「セキュリティ」が表示されない。(Hide-1){{/Hide-1}}
{{#Hide-2}}        1. 「Sync」が表示されない。（Hide-2）{{/Hide-2}}
{{#Hide-3}}        1. 「？」ボタン（ヘルプボタン）が表示されない。(Hide-3){{/Hide-3}}
<!--/GROUP-->
<!--GROUP-->
1. 「オプション」の「一般」を選択する。
    - 確認項目
{{#Hide-7}}        1. 「タブグループ」以下に「新しいウィンドウではなく新しいタブで開く」が表示されない。(Hide-7){{/Hide-7}}
{{#Hide-12}}        1. 「タブグループ」以下に「Ctrl+Tabで最近使用した順にタブを切り替える」が表示されない。(Hide-12){{/Hide-12}}
{{#Hide-9}}        1. 「ダウンロード」グループが表示されない。(Hide-9){{/Hide-9}}
<!--/GROUP-->
{{#Hide-10}}
1. 「表示」メニューを開き、「ズーム」→「拡大」をクリックしてページを拡大表示する。
    - 確認項目
        1. ロケーションバーの右端に拡大・縮小表示倍率ボタンが表示されない。（Hide-10）
{{/Hide-10}}
{{#Hide-2}}
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
1. 追加のツールと機能の「サイドバー」で右クリックし、「ツールバーに追加」をクリックする。
1. カスタマイズを終了し、ツールバーの「サイドバー」アイコンをクリックする。
    - 確認項目
        1. 「同期タブ」が存在しない。(Hide-2)
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
1. ツールバーの「サイドバー」アイコンで右クリックし、「メニューに移動」をクリックする。
1. カスタマイズを終了し、パネルメニューの「サイドバー」をクリックする。
    - 確認項目
        1. 「同期タブ」が存在しない。(Hide-2)
{{/Hide-2}}
{{#Hide-11}}
1. プラグインを使用するページを開き、プラグイン領域をクリックして再生を指示する。例： `https://helpx.adobe.com/jp/flash-player/kb/235703.html` （Flashの場合）
    - 確認項目
        1. プラグインの有効化の可否を尋ねるポップアップに「常に許可」ボタンが表示されない。（Hide-11）
{{/Hide-11}}

### 後始末

1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
1. パネルメニューの「サイドバー」で右クリックし、「メニューから削除」をクリックする。
1. カスタマイズを終了する。

{{#Hide-4}}
## パーミッション設定UIの非表示化

### 確認する項目

 - Hide-4

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 以下のアドオンを無効化する。
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
1. 以下のカスタマイズを無効化する。
{{#Security-4-3}}    1. Security-4-3（ポップアップブロックを有効化する）：{{mcd_local_file}}/autoconfig.jscから項目を削除{{/Security-4-3}}
{{#use_globalchromecss}}
{{#Privacy-6-3}}    1. Privacy-6-3（オフラインキャッシュの設定UIを有効化する）：globalChrome.cssと{{mcd_local_file}}/autoconfig.jscから項目を削除{{/Privacy-6-3}}
{{#Hide-1}}    1. Hide-1（「セキュリティ」ペインを有効化する）：globalChrome.cssから項目を削除{{/Hide-1}}
{{/use_globalchromecss}}

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
3. 「コンテンツ」ペインを選択し、「ポップアップ」の「許可サイト」ボタンをクリックする。
    - 確認項目
        1. 「サイトのアドレス」の入力欄が表示されない。(Hide-4)
        2. 「サイトを削除」ボタンが表示されない。(Hide-4)
        3. 「すべてのサイトを削除」ボタンが表示されない。(Hide-4)
4. 「セキュリティ」ペインを選択し、「一般」の「許可サイト」ボタンをクリックする。
    - 確認項目
        1. 「サイトのアドレス」の入力欄が表示されない。(Hide-4)
        2. 「サイトを削除」ボタンが表示されない。(Hide-4)
        3. 「すべてのサイトを削除」ボタンが表示されない。(Hide-4)
5. 「詳細」ペイン→「ネットワーク」タブを選択し、「例外サイト」ボタンをクリックする。
    - 確認項目
        1. 「サイトのアドレス」の入力欄が表示されない。(Hide-4)
        2. 「サイトを削除」ボタンが表示されない。(Hide-4)
        3. 「すべてのサイトを削除」ボタンが表示されない。(Hide-4)

### 後始末

1. 以下のアドオンを有効化する。
{{#use_disableaddons}}    1. Disable Addons{{/use_disableaddons}}
1. 以下のカスタマイズを有効化する。
{{#Security-4-3}}    1. Security-4-3{{/Security-4-3}}
{{#use_globalchromecss}}
{{#Privacy-6-3}}    1. Privacy-6-3{{/Privacy-6-3}}
{{#Hide-1}}    1. Hide-1{{/Hide-1}}
{{/use_globalchromecss}}
{{/Hide-4}}


{{#Hide-13}}
## タブモーダルの背景の完全透過

### 確認する項目

 - Hide-13

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. `{{desktop_shortcut_path}}` がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. テストケースの `alert.html` を開く。
    - 確認項目
        1. タブモーダル形式で表示されたメッセージダイアログの背景が暗転せずそのままである。(Hide-13)
{{/Hide-13}}
