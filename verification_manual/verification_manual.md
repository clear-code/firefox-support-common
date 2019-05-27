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

{{#Admin-1-2 || Network-2-3 || Network-2-8 || Security-4-5}}
## 検証の準備

{{#is_upgrade_from_uncontrolled}}
* 現行バージョンのFirefoxのセットアップ手順を確認し、現行環境を復元できる用意を整えておく。
{{/is_upgrade_from_uncontrolled}}
{{#Admin-1-2}}
* リモート設定ファイルを参照できない環境で検証する場合、MCD用設定ファイルの「Admin-1-2」に対応する設定をコメントアウトし、ローカル設定ファイルのみを使用するように設定する。
{{/Admin-1-2}}
{{#Network-2-3 || Network-2-8}}
* プロキシ自動設定スクリプトを参照できない環境で検証する場合、「Network-2-3」または「Network-2-8」でのPACファイルの参照先URLを `data:application/javascript,` と設定する。
{{/Network-2-3 || Network-2-8}}
{{#Security-4-5}}
* ポップアップの許可対象サイトを参照できない環境で検証する場合、ポップアップの許可対象サイト一覧に `example.com` を加えるよう設定する。
{{/Security-4-5}}
* 検証環境からインターネット上のWebサイトに接続できる状態にしておく。フィルタリングソフトウェア、ファイアウォール等で接続が制限されている場合、一部の検証を実施できない場合がある。
* 以下のページから検証用テストケース集をダウンロードし、検証環境に用意しておく（テストケースリストは `testcases/index.html` に存在する）。

        https://github.com/clear-code/firefox-support-common/

{{/Admin-1-2 || Network-2-3 || Network-2-8 || Security-4-5}}

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

{{#is_upgrade_from_uncontrolled}}
## 現行環境への上書きインストール

### 確認する項目

{{#Install-7-2}} - Install-7-2{{/Install-7-2}}
{{#Admin-1-1 || Admin-1-2}} - Admin-1-1/2{{/Admin-1-1 || Admin-1-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. `{{meta_installer_file_name}}\*.exe` が作成済みの状態にする。
1. 現行バージョンのFirefoxがセットアップ済みの状態にしておく。

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
{{/is_upgrade_from_uncontrolled}}


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
1. 「コントロールパネル」→「プログラムと機能」（Windows 10では「設定」→「アプリ」→「アプリと機能」）で以下がインストールされているならばアンインストールする。
    1. {{meta_installer_name}}
    1. Mozilla Firefox
    1. Mozilla Maintenance Service
1. 以下のファイル、フォルダを削除する。
    1. `{{install_path}}`
    1. `C:\Program Files (x86)\ClearCode Inc`
    1. Firefoxのユーザープロファイル（`%AppData%\Mozilla`）
    1. Firefoxのテンポラリファイルおよびキャッシュファイル（`%LocalAppData%\Mozilla`）

### 検証

1. `{{meta_installer_file_name}}\*.exe` を実行する。
<!--GROUP-->
    - 確認項目
{{#Install-3-2}}
        1. メタインストーラのウィザードが表示される。(Install-3-2)
{{/Install-3-2}}
{{#Install-3-3}}
        1. メタインストーラのウィザードが表示されない。(Install-3-3)
{{/Install-3-3}}
{{#Install-6-1}}
        1. ウィザードが日本語表示になっている。(Install-6-1)
{{/Install-6-1}}
{{#Install-6-2}}
        1. ウィザードが英語表示になっている。(Install-6-2)
{{/Install-6-2}}
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
<!--/GROUP-->
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
        1. デスクトップのショートカットが{{#Application-1-1 || Application-1-3}}存在する。(Application-1-1/3){{/Application-1-1 || Application-1-3}}{{#Application-1-2}}存在しない。 (Application-1-2){{/Application-1-2}}
{{/Application-1}}
{{#Application-2}}
        1. スタートメニューのショートカットが{{#Application-2-1 || Application-2-3}}存在する。(Application-2-1/3){{/Application-2-1 || Application-2-3}}{{#Application-2-2}}存在しない (Application-2-2){{/Application-2-2}}
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
        1. 「コントロールパネル」→「プログラムと機能」（Windows 10では「設定」→「アプリ」→「アプリと機能」）で、「Mozilla Firefox {{firefox_version}}」がインストールされている。（ベータ版を用いた検証の場合、バージョン表記は「beta」を除いた数字が期待される。）(Install-7-\*)
{{/Install-7}}
{{#Install-1}}
        1. 「コントロールパネル」→「プログラムと機能」（Windows 10では「設定」→「アプリ」→「アプリと機能」）で、「{{meta_installer_name}}」がインストールされている。(Install-1-\*)
{{/Install-1}}
{{#Install-9-2}}
        1. 「コントロールパネル」→「プログラムと機能」（Windows 10では「設定」→「アプリ」→「アプリと機能」）で、「{{meta_installer_name}}」のバージョンが「{{meta_installer_version}}」と表示されている。(Install-9-2)
{{/Install-9-2}}
{{#Update-4}}
        1. 「コントロールパネル」→「プログラムと機能」（Windows 10では「設定」→「アプリ」→「アプリと機能」）で、「Mozilla Maintenance Service」がインストールされて{{#Update-4-1}}いる。(Update-4-1){{/Update-4-1}}{{#Update-4-2}}いない。(Update-4-2){{/Update-4-2}}
{{/Update-4}}
<!--/GROUP-->

## 専用ユーザープロファイルの作成と使用

- 専用ユーザープロファイルの作成先は `{{special_profile_path}}` {{#special_profile_actual_path}}（{{special_profile_actual_path}}）{{/special_profile_actual_path}}とする。
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
1. デスクトップのショートカットのプロパティを開く。
    - 確認項目
        1. 作業フォルダが `"（Firefoxの実行ファイルがあるフォルダパス）"` である。(Application-1-3)
        2. 「リンク先」末尾に `-profile {{special_profile_path}}\{{special_profile_name}}` というオプションが指定されている。（環境変数の参照記法がそのまま含まれている）(Application-1-3)
{{/Application-1-3}}
{{#Application-2-3}}
1. スタートメニューのショートカットのプロパティを開く。
    - 確認項目
        1. 作業フォルダが `"（Firefoxの実行ファイルがあるフォルダパス）"` である。(Application-2-3)
        2. 「リンク先」末尾に `-profile {{special_profile_path}}\{{special_profile_name}}` というオプションが指定されている。（環境変数の参照記法がそのまま含まれている）(Application-2-3)
{{/Application-2-3}}
{{#Application-6-2}}
1. Windowsエクスプローラ（フォルダウィンドウ）を開き、アドレスバーに `{{special_profile_path}}\{{special_profile_name}}` と入力してEnterを押す。
1. デスクトップのショートカットをダブルクリックし、Firefoxを起動する。
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

1. 「コントロールパネル」→「プログラムと機能」（Windows 10では「設定」→「アプリ」→「アプリと機能」）で以下がインストールされているならばアンインストールする。
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
    1. デスクトップのショートカット
    1. スタートメニューのショートカット
    1. クイック起動、タスクバー、およびスタートメニュー内に作成されたショートカット
3. 旧バージョン、新バージョンの各メタインストーラ作成キット内のバッチファイルを実行し、インストーラの実行ファイルを作成しておく。

### 検証

1. 旧バージョンのメタインストーラを実行する。
1. デスクトップのショートカットをダブルクリックし、Firefoxを起動する。
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
1. デスクトップのショートカットをダブルクリックし、Firefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}
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
1. デスクトップのショートカットをダブルクリックし、Firefoxを起動する。
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
{{#Admin-5}} - Admin-5-\* {{/Admin-5}}
{{#Startup-1}} - Startup-1-\* {{/Startup-1}}
{{#Startup-2}} - Startup-2-\* {{/Startup-2}}
{{#Startup-3}} - Startup-3-\* {{/Startup-3}}
{{#Startup-4-2}} - Startup-4-2 {{/Startup-4-2}}
{{#Startup-5-2 || Startup-5-4}} - Startup-5-2/4 {{/Startup-5-2 || Startup-5-4}}
{{#Startup-7}} - Startup-7-\* {{/Startup-7}}
{{#Startup-10-2}} - Startup-10-2 {{/Startup-10-2}}
{{#Update-4-2}} - Update-4-2 {{/Update-4-2}}
{{#Appearance-7-2}} - Appearance-7-2 {{/Appearance-7-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. Firefoxのユーザープロファイル `{{special_profile_path}}` {{#special_profile_actual_path}}（{{special_profile_actual_path}}）{{/special_profile_actual_path}}を削除する。
{{#Admin-2}}
1. 導入対象のアドオンがない場合、テストケースリストの「{61FD08D8-A2CB-46c0-B36D-3F531AC53C12}.xpi」リンクからアドオンをダウンロードして、`{{install_path}}\browser\extensions\{61FD08D8-A2CB-46c0-B36D-3F531AC53C12}.xpi`に配置する。
{{/Admin-2}}
{{#Startup-3}}
1. システムの「既定のブラウザ」を別のブラウザに設定する（例えばIEであれば「インターネットオプション」から既定のブラウザに設定可能）。
{{/Startup-3}}
{{#Security-9-3}}{{#Startup-4-2 || Startup-10-2}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Startup-4-2 || Startup-10-2}}{{/Security-9-3}}
{{#Security-35-2}}{{#Startup-7-3}}
1. Policy Engineでのabout:support無効化設定を解除し、一時的に有効化しておく。
{{/Startup-7-3}}{{/Security-35-2}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。{{^Startup-1}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1}}
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
{{#Appearance-7-2}}
        1. UIの表示言語が指定の通りになっている。(Appearance-7-2)
{{/Appearance-7-2}}
{{#Admin-2-1}}
        1. パネルメニューにアドオンの有効化の可否を尋ねる項目が表示されている。(Admin-2-1)
{{/Admin-2-1}}
{{#Admin-2-2}}
        1. パネルメニューにアドオンの有効化の可否を尋ねる項目が表示されていない。(Admin-2-2)
{{/Admin-2-2}}
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
{{#Startup-5-2 || Startup-5-4}}
1. メニューバーの「ブックマーク」を開く。
    - 確認項目
        1. 既定の項目が作成されていない。(Startup-5-2/4)
1. Firefoxのウィンドウのツールバー上で右クリックし、「ブックマークツールバー」を選択する。
    - 確認項目
        1. ブックマークツールバー上に既定の項目が作成されていない。(Startup-5-2/4)
{{/Startup-5-2 || Startup-5-4}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
{{#Startup-3-2}}
1. オプション画面の「一般」を開く。
    - 確認項目
        1. 既定のブラウザの項目内の「起動時にFirefoxが既定のブラウザであるか確認する」のチェックが外れていて、無効化されている。(Startup-3-2)
{{/Startup-3-2}}
{{#Update-4-2}}
1. オプション画面の「一般」を開く。
    - 確認項目
        1. 「更新のインストールにバックグラウンドサービスを使用する」のチェックが存在しないか、チェックが外れており無効化されている。(Update-4-2)
{{/Update-4-2}}
{{#Admin-5}}
1. 「オプション」を開く
    - 確認項目
       1. ページ上部に「あなたの所属組織が一部のオプションの変更を制限しています。」というメッセージが{{#Admin-5-1}}表示されている。(Admin-5-1){{/Admin-5-1}}{{#Admin-5-2}}と表示されていない。(Admin-5-2){{/Admin-5-2}}
{{/Admin-5}}
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Startup-4-2}}
        1. `browser.startup.homepage_override.mstone` の値が `ignore` である。(Startup-4-2)
{{/Startup-4-2}}
{{#Startup-10-2}}
        1. `media.hardware-video-decoding.failed` の値が `true` に設定されている。(Startup-10-2)
{{/Startup-10-2}}
{{#Startup-7}}
1. システムの時計を1年先の日付に進め、Firefoxを再起動する。
    - 確認項目
        1. 「お久しぶりです！ Firefoxはしばらく使われていないようです。プロファイルを掃除して新品のようにきれいにしますか？」というメッセージが{{#Startup-7-1}}表示される。（Startup-7-1）{{/Startup-7-1}}{{#Startup-7-2 || Startup-7-3}}表示されない。（Startup-7-2/3）{{/Startup-7-2 || Startup-7-3}}
1. システムの時計を進めることができない場合は`about:config`を開いて設定値を確認する。
    - 確認項目
  {{#Startup-7-1}}
        1. `browser.disableResetPrompt`の値が`false`である (Startup-7-1)
  {{/Startup-7-1}}
  {{#Startup-7-2}}
        1. `browser.disableResetPrompt`の値が`true`である (Startup-7-2)
  {{/Startup-7-2}}
{{#Startup-7-3}}
1. ロケーションバーに`about:support`と入力して確定する
    - 確認項目
        1. 「Firefoxをリフレッシュ」ボタンが無効化されている (Startup-7-3)
1. ロケーションバーに `https://support.mozilla.org/kb/reset-firefox-easily-fix-most-problems` と入力して確定する
    - 確認項目
        1. 「Firefoxをリフレッシュ」ボタンを押しても何も起こらない (Startup-7-3)
{{/Startup-7-3}}
{{/Startup-7}}

### 後始末

1. 検証用に導入したアドオンを削除する。
{{#Security-9-3 || Security-35-2}}{{#Startup-4-2 || Startup-10-2 || Startup-7-3}}
1. Policy Engineに加えた変更を元に戻す。
{{/Startup-4-2 || Startup-10-2 || Startup-7-3}}{{/Security-9-3 || Security-35-2}}
{{#Startup-7}}
1. 1年進めたシステムの時計を元に戻す。
{{/Startup-7}}

## 起動方法の制御

### 確認する項目

{{#Application-1-1 || Application-1-3}} - Application-1-1/3 {{/Application-1-1 || Application-1-3}}
{{#Application-2-1 || Application-2-3}} - Application-2-1/3 {{/Application-2-1 || Application-2-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Application-1}}
1. その状態のまま、デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxの追加起動を試みる。
    - 確認項目
        1. {{^start_with_no_remote}}Firefoxの新しいウィンドウが開かれる。{{/start_with_no_remote}}{{#start_with_no_remote}}「Firefoxは起動していますが応答しません。」というメッセージが出て、Firefoxの新しいウィンドウが開かれない。{{/start_with_no_remote}}(Application-1-1/3)
1. Firefoxを終了する。
{{/Application-1}}
{{#Application-2}}
1. スタートメニューのショートカットをクリックしてFirefoxを起動する。
1. その状態のまま、スタートメニューのショートカットをクリックしてFirefoxの多重起動を試みる。
    - 確認項目
        1. {{^start_with_no_remote}}Firefoxの新しいウィンドウが開かれる。{{/start_with_no_remote}}{{#start_with_no_remote}}「Firefoxは起動していますが応答しません。」というメッセージが出て、Firefoxの新しいウィンドウが開かれない。{{/start_with_no_remote}}(Application-2-1/3)
{{/Application-2}}

{{#Application-5}}
## ウィンドウのアイコンの変更

### 確認する項目

 - Application-5-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. タスクバー上に表示された項目にポインタを載せ、ジャンプリストを表示させる。
    - 確認項目
        1. タスクバー上の項目、もしくはジャンプリストの項目に指定のアイコンが表示されている。(Application-5-\*)
1. 前項で項目のタイトルを確認できない場合、Ctrl-Shift-ESCを押下し、タスクマネージャを起動して、「アプリケーション」タブを選択する。
    - 確認項目
        1. 項目に指定のアイコンが表示されている。(Application-5-\*)

{{/Application-5}}

<!--======================================================================-->

# セキュリティに関わるカスタマイズ

## 証明書の自動インポート

### 確認する項目

{{#Security-1-3}} - Security-1-3 {{/Security-1-3}}
{{#Security-1-4}} - Security-1-4 {{/Security-1-4}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-1-3}}
1. Windowsの証明書データベースに、証明書（{{imported_certs}}）がインポートされた状態にしておく。
   この時、証明書はレジストリ上の以下の位置のいずれかに存在しているものとする。
    - `HKEY_LOCAL_MACHINE\Software\Microsoft\SystemCertificates\Root\Certificates`
    - `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SystemCertificates\Root\Certificates`
    - `HKEY_LOCAL_MACHINE\Software\Microsoft\EnterpriseCertificates\Root\Certificates`
1. インポート済みの証明書がない場合、次の手順でダミーの証明書をインポートする。
    - スタートメニューから「mmc.exe」を実行する
    - 「ファイル > スナップインの追加と削除」を選ぶ
    - 「証明書」を選び、「コンピューターアカウント」を選択する。
    ｰ 「ローカル コンピューター」を選択する。
    - 「完了」をクリックしてウィザードを終了する。
    - 画面左のツリーから「コンソール ルート」→「証明書（ローカル コンピューター）」と展開していく。
    - 「証明書（ローカル コンピューター）」配下の「信頼されたルート証明機関」を右クリックし、メニューから「すべてのタスク > インポート」を選択する。
    - ファイルとしてテストケースの「dummy.crt」を選択する。また、配置先証明書ストアは「証明書をすべて次のストアに配置する」→「信頼されたルート証明機関」を選択する。
    - ウィザードの完了後、「信頼されたルート証明書」→「証明書」の一覧に「dummy.clear-code.com」という証明書が表示されることを確認する。
1. MCD設定ファイルに以下の設定を追加しておく。
    - `lockPref("logging.pipnss", 5);`
    - `lockPref("logging.config.sync", true);`
    - `lockPref("logging.config.add_timestamp", true);`
    - `lockPref("logging.config.clear_on_startup", true);`
    - `lockPref("logging.config.LOG_FILE","C:\\Users\\Public\\nss.log");`
1. `C:\Users\Public\nss.log-*` を全て削除しておく。
{{/Security-1-3}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Security-1-3}}
1. `C:\Users\Public\nss.log-*` の位置に出力されたログファイルを開く。
    - 確認項目
        1. インポート対象の証明書（{{imported_certs}}）のすべてについて、`D/pipnss Imported '（証明書の一般名）'`というログが出力されている。(Security-1-3)
{{/Security-1-3}}
{{#Security-1-4}}
1. オプション画面の「プライバシーとセキュリティ」を開く。
1. 「証明書」セクションの「証明書を表示」ボタンをクリックして証明書マネージャを開く。
1. 「認証局証明書」の一覧を表示する。
    - 確認項目
        1. インポートするよう指定した証明書が一覧に登録されている。(Security-1-4)
{{/Security-1-4}}

{{#Security-1-3}}
### 後始末

1. Windowsの証明書データベースに検証用に追加した証明書があれば、全て削除する。
1. MCD設定ファイルに追加した設定を全て削除する
1. `C:\Users\Public\nss.log-*` を全て削除する。
{{/Security-1-3}}

{{#Security-3-3 || Security-3-4 || Security-3-5 || Security-3-6 || Security-3-7}}
## アドオンの利用制限

### 確認する項目

- Security-3-3/4/5/6

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-3-3 || Security-3-4 || Security-3-7}}
1. テストケースリストの「{61FD08D8-A2CB-46c0-B36D-3F531AC53C12}.xpi」リンクから署名済みアドオンをダウンロードしておく。
{{/Security-3-3 || Security-3-4 || Security-3-7}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. アドオンのインストールを許可する対象のサイトを開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
{{#Security-3-5 || Security-3-6}}
        1. 「サイト別設定」タブで「アドオンのインストール」において「許可」にチェックが入っている。(Security-3-5/6)
        1. 「アドオンのインストール」を「ブロック」に変更してFirefoxを再起動し、再び同じページの「ページの情報」の「サイト別設定」タブを開いた時、「アドオンのインストール」において{{#Security-3-6}}「許可」にチェックが入っている。(Security-3-6){{/Security-3-6}}{{#Security-3-5}}「ブロック」にチェックが入っている。(Security-3-5){{/Security-3-5}}
{{/Security-3-5 || Security-3-6}}
<!--/GROUP-->
<!--GROUP-->
1. Firefoxのウィンドウに署名済みアドオンのファイルをドラッグ&ドロップする。
    - 確認項目
{{#Security-3-3 || Security-3-4 || Security-3-7}}
        1. 「ソフトウェアのインストールはシステム管理者により無効化されています。」と表示され、アドオンがインストールされない。(Security-3-3/4/7)
{{/Security-3-3 || Security-3-4 || Security-3-7}}
<!--/GROUP-->
{{#Security-3-4 || Security-3-7}}
1. アドオンマネージャを開く。
    - 確認項目
        1. 「アドオン入手」が表示されない。(Security-3-4/7)
        1. 歯車アイコンが表示されている場合、そのポップアップメニュー内に「ファイルからアドオンをインストール」が含まれない。(Security-3-4/7)
        1. 「拡張機能」タブが選択された状態で、アドオンマネージャ上にアドオンのインストールパッケージをドラッグ&ドロップして、アドオンがインストールされない。(Security-3-4/7)
        1. 「アドオンを検索」欄に「Tab」と入力してEnterすると、「利用可能なアドオン」の検索結果が何も表示されない。(Security-3-4/7)
{{/Security-3-4 || Security-3-7}}
{{#Security-3-3}}
1. （Policy Engineを利用している場合のみ）ロケーションバーに`about:addons`と入力して確定する。
    - 確認項目
        1. `about:addons`への遷移がブロックされる (Security-3-3)
{{/Security-3-3}}

{{/Security-3-3 || Security-3-4 || Security-3-5 || Security-3-6 || Security-3-7}}

{{#Security-4}}
## 広告などのポップアップのブロック

### 確認する項目

- Security-4-\*

### 準備：

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    - カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証：

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. テストケースの `popupblock.html` を開く。
    - 確認項目
        1. ポップアップブロックの通知が{{^Security-4-3 || Security-4-7}}表示される。(Security-4-1/4/5/6/8){{/Security-4-3 || Security-4-7}}{{#Security-4-3 || Security-4-7}}表示されずに、タブまたはウィンドウが開かれる。(Security-4-3/7){{/Security-4-3 || Security-4-7}}
<!--/GROUP-->
{{#Security-4-5 || Security-4-6}}
1. ポップアップの許可対象のサイトを開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
        1. 「サイト別設定」タブで「ポップアップウィンドウを開く」において「許可」にチェックが入っている。(Security-4-5/6)
        1. 「ポップアップウィンドウを開く」を「ブロック」に変更してFirefoxを再起動し、再び同じページの「ページの情報」の「サイト別設定」タブを開いた時、「ポップアップウィンドウを開く」において{{#Security-4-6}}「許可」にチェックが入っている。(Security-4-6){{/Security-4-6}}{{#Security-4-5}}「ブロック」にチェックが入っている。(Security-4-5){{/Security-4-5}}
{{/Security-4-5 || Security-4-6}}
{{/Security-4}}

## 攻撃サイトに対する警告

### 確認する項目

{{#Security-5}} - Security-5-\* {{/Security-5}}
{{#Security-6}} - Security-6-\* {{/Security-6}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

{{#Security-5}}
1. テストケースリストのリンクから`https://itisatrap.org/firefox/its-an-attack.html` を開く。
    - 確認項目
        1. 攻撃サイトとしてブロック{{#Security-5-1}}される。(Security-5-1){{/Security-5-1}}{{#Security-5-2}}されない。(Security-5-2){{/Security-5-2}}
1. テストケースリストのリンクから`https://itisatrap.org/firefox/unwanted.html` を開く。
    - 確認項目
        1. 望ましくないソフトウェアの提供サイトとしてブロック{{#Security-5-1}}される。(Security-5-1){{/Security-5-1}}{{#Security-5-2}}されない。(Security-5-2){{/Security-5-2}}
{{/Security-5}}
{{#Security-6}}
1. テストケースリストのリンクから `https://itisatrap.org/firefox/its-a-trap.html` を開く。
    - 確認項目
        1. 詐欺サイトとしてブロック{{#Security-6-1}}される。(Security-6-1){{/Security-6-1}}{{#Security-6-2}}されない。(Security-6-2){{/Security-6-2}}
{{/Security-6}}

## about:ページの利用制限

### 確認する項目

{{#Security-9-3}} - Security-9-3 {{/Security-9-3}}
{{#Security-34-2}} - Security-34-2 {{/Security-34-2}}
{{#Security-35-2}} - Security-35-2 {{/Security-35-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    - カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Security-9-3}}
1. ロケーションバーに`about:config`と入力して確定する
    - 確認項目
        1. `about:config`への遷移がブロックされる (Security-9-3)
{{/Security-9-3}}
{{#Security-34-2}}
1. ロケーションバーに`about:profiles`と入力して確定する
    - 確認項目
        1. `about:profiles`への遷移がブロックされる (Security-34-2)
{{/Security-34-2}}
{{#Security-35-2}}
1. ロケーションバーに`about:support`と入力して確定する
    - 確認項目
        1. `about:support`への遷移がブロックされる (Security-35-2)
{{/Security-35-2}}

{{#Security-12}}
## JavaScriptの実行制限

### 確認する項目

- Security-12-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
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

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Security-13}}
1. テストケースの `local-file-link.html` を、{{#Security-13-1 || Security-13-3}}ローカルファイルの読み込みを許可するサイト{{/Security-13-1 || Security-13-3}}{{#Security-13-2}}Web上{{/Security-13-2}}に設置してから開き、ページ内のリンクをクリックする。{{#Security-13-2}}  
   （例： `http://www.clear-code.com/temp/local-file-link.html` ）{{/Security-13-2}}
    - 確認項目
{{#Security-13-1 || Security-13-3}}
        1. `C:\file.txt` の位置に置いたファイルの内容が読み込まれる。(Security-13-1/3)
{{/Security-13-1 || Security-13-3}}
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
{{#Security-18-2}}   - Security-18-2 {{/Security-18-2}}
{{#Security-19-2}}   - Security-19-2 {{/Security-19-2}}
{{#Security-21-2}}   - Security-21-2 {{/Security-21-2}}
{{#Security-25-2}}   - Security-25-2 {{/Security-25-2}}
{{#Security-26-2}}   - Security-26-2 {{/Security-26-2}}
{{#Security-27-2}}   - Security-27-2 {{/Security-27-2}}
{{#Security-28-2}}   - Security-28-2 {{/Security-28-2}}
{{#Security-31-2}}   - Security-31-2 {{/Security-31-2}}
{{#Privacy-15-2}}   - Privacy-15-2 {{/Privacy-15-2}}
{{#Privacy-18-2 || Privacy-18-3}}   - Privacy-18-2/3 {{/Privacy-18-2 || Privacy-18-3}}
{{#Privacy-19-2}}   - Privacy-19-2 {{/Privacy-19-2}}
{{#Privacy-22-2}}   - Privacy-22-2 {{/Privacy-22-2}}
{{#Privacy-24-2}}   - Privacy-24-2 {{/Privacy-24-2}}
{{#Privacy-33-3}}   - Privacy-33-3 {{/Privacy-33-3}}
{{#Update-1-3}}   - Update-1-3 {{/Update-1-3}}
{{#Update-2-2}}   - Update-2-2 {{/Update-2-2}}
{{#Plugin-8-2}}   - Plugin-8-2 {{/Plugin-8-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. Firefoxのユーザープロファイル `{{special_profile_path}}` {{#special_profile_actual_path}}（{{special_profile_actual_path}}）{{/special_profile_actual_path}}を削除する。
{{#disable_devtools}}
1. Policy Engineでの開発ツール無効化設定を解除し、一時的に有効化しておく。
{{/disable_devtools}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}
2. ロケーションバーに`about:blank`と入力し、空のページを開く。
3. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）→「開発ツールを表示」で開発ツールを表示する。
4. 開発ツール右上の歯車アイコンをクリックする。
5. 「ブラウザとアドオンのデバッガを有効」と「リモートデバッガを有効」にチェックを入れる。
6. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）→「ブラウザツールボックス」でブラウザツールボックスを開く。途中、リモートデバッグの接続許可を求められるので「OK」をクリックする。
7. ブラウザツールボックスで「ネットワーク」を選択する。
8. ブラウザツールボックス内の「再読み込み」ボタンをクリックする。
9. そのまま10分放置する。
    - 確認項目
{{#Update-1-1}}
        1. (Update-1-1)を除いて、一切のネットワーク通信が記録されない。(Security-15-2)
{{/Update-1-1}}
{{^Update-1-1}}
        1. 一切のネットワーク通信が記録されない。(Security-15-2)
{{/Update-1-1}}

{{#disable_devtools}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/disable_devtools}}
{{/Security-15-2}}

## 外部リソースへのアクセスの制限

### 確認する項目

{{#Security-15-2}} - Security-15-2 {{/Security-15-2}}
{{#Security-18-2}} - Security-18-2 {{/Security-18-2}}
{{#Security-19-2}} - Security-19-2 {{/Security-19-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#disable_devtools}}
1. Policy Engineでの開発ツール無効化設定を解除し、一時的に有効化しておく。
{{/disable_devtools}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
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
        1. 無反応である、もしくはADB Helperアドオンが準備中になっている。(Security-15-2)
{{/Security-15-2}}

{{#disable_devtools}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/disable_devtools}}


{{#Security-16}}
## フルスクリーン表示の制限

### 確認する項目

- Security-16-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
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
{{#disable_devtools}}
1. Policy Engineでの開発ツール無効化設定を解除し、一時的に有効化しておく。
{{/disable_devtools}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. `about:debugging` を開き、テストケースから `blocked-addon.xpi` を「一時的なアドオンを読み込む」で読み込ませる。
    - 確認項目
        1. 読み込ませたアドオンが {{#Security-21-1}}エラーとなり読み込みに失敗する。(Security-21-1){{/Security-21-1}}{{#Security-21-2}}エラーとなることなく一時的な拡張機能一覧に表示されている。(Security-21-2){{/Security-21-2}}

{{#disable_devtools}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/disable_devtools}}
{{/Security-21}}

{{#Security-23}}
## プラグインのサンドボックス内実行

### 確認する項目

- Security-23-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-9-3}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Security-9-3}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに`about:config`と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
        1. `dom.ipc.plugins.sandbox-level.default` の値が{{#Security-23-1 || Security-23-2}}`0`である。(Security-23-1/2){{/Security-23-1 || Security-23-2}}{{#Security-23-3}}`1`である。(Security-23-3){{/Security-23-3}}
        1. `dom.ipc.plugins.sandbox-level.flash` の値が{{#Security-23-1}}`0`である。(Security-23-1){{/Security-23-1}}{{#Security-23-2 || Security-23-3}}`1`である。(Security-23-2/3){{/Security-23-2 || Security-23-3}}

{{#Security-9-3}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/Security-9-3}}

{{/Security-23}}

{{#Security-25}}
## プロトコルごとの外部Webアプリケーションへの連携

### 確認する項目

- Security-25-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
3. オプション画面の「一般」を開く。
    - 確認項目
        1. ファイルの種類「irc」「ircs」「mailto」「webcal」のそれぞれについて、選択肢として{{#Security-25-1}}Webアプリケーション名が表示される。（Security-25-1）{{/Security-25-1}}{{#Security-25-2}}「毎回確認する」と「他のプログラムを選択する...」の2つだけ(Windowsの既定のアプリケーション設定により追加されたアプリケーションは除く)が表示される。（Security-25-2）{{/Security-25-2}}
{{/Security-25}}

## ダウンロードしたファイルの保護

### 確認する項目

{{#Security-26}} - Security-26-\* {{/Security-26}}
{{#Security-27}} - Security-27-\* {{/Security-27}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. フィルタリングソフトなどにより危険なソフトウェアのダウンロードがブロックされる場合は実際の動作での検証が不可能なため、安全でない実行ファイルのダウンロードが可能な状態にしておく。
<!--
{{#Security-26}}
1. 検証用にHTTPで端末から `http://download.safebrowsingtest.com/download` としてアクセス可能なサーバーを用意する
    1. 端末の hosts ファイルにアクセス先のサーバーのアドレスとホスト名を追記する。( 例: `127.0.0.1 download.safebrowsingtest.com` を `%SYSTEMROOT%\System32\drivers\etc\hosts` に追記し、名前解決できるようにする。)
    1. サーバーにて `mkdir -p /tmp/download && echo "TEST" > /tmp/download/test` などとして `/tmp/download` 以下に `test` というファイルを用意する。
    1. サーバーにて `sudo ruby -run -e httpd /tmp -p 80` などとして /tmp をHTTP経由でアクセスできる状態にする。
{{/Security-26}}
-->

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `http://testsafebrowsing.appspot.com/` と入力し、ページを開く。
{{#Security-26}}
<!--
1. ロケーションバーに `http://download.safebrowsingtest.com/download` と入力し、ページを開く。
1. 「test」ファイルのリンクをクリックする。
-->
1. 「Desktop Download Warnings」セクションの「3. Should show an "dangerous host" warning」のリンクをクリックする。
1. ファイルの取り扱いを尋ねられるので、ファイルとして保存するよう指示し、ダウンロード完了を待つ。
1. ダウンロードボタンをクリックし、ダウンロードの一覧を開く。
    - 確認項目
        1. ダウンロード一覧の一番上の項目に{{#Security-26-1}}「このファイルはウイルスやマルウェアが含まれています。」という警告のメッセージが表示される。（Security-26-1）{{/Security-26-1}}{{#Security-26-2}}特に警告のメッセージは表示されない。（Security-26-2）{{/Security-26-2}}
{{/Security-26}}
{{#Security-27}}
<!--
1. ロケーションバーに `http://testsafebrowsing.appspot.com/` と入力し、ページを開く。
-->
1. 「Desktop Download Warnings」セクションの「4. Should show an "uncommon" warning, for .exe」のリンクをクリックする。
1. ファイルの取り扱いを尋ねられるので、ファイルとして保存するよう指示し、ダウンロード完了を待つ。
1. ダウンロードボタンをクリックし、ダウンロードの一覧を開く。
    - 確認項目
        1. ダウンロード一覧の一番上の項目に{{#Security-27-1}}「このファイルを開くのは危険です。」という警告のメッセージが表示される。（Security-27-1）{{/Security-27-1}}{{#Security-27-2}}特に警告のメッセージは表示されない。（Security-27-2）{{/Security-27-2}}
{{/Security-27}}
1. フィルタリングソフトなどにより危険なソフトウェアのダウンロードがブロックされる場合、実際の挙動での検証が不可能のため、`about:config` もしくは `about:support` で以下の設定の反映状況のみ確認する。
    - 確認項目
{{#Security-26}}
        1. `browser.safebrowsing.downloads.enabled` が{{#Security-26-1}} `true` である。(Security-26-1){{/Security-26-1}}{{#Security-26-2}} `false` である。(Security-26-2){{/Security-26-2}}
{{/Security-26}}
{{#Security-27}}
        1. `browser.safebrowsing.downloads.remote.block_potentially_unwanted` と  `browser.safebrowsing.downloads.remote.block_uncommon` がどちらも{{#Security-27-1}} `true` である。(Security-27-1){{/Security-27-1}}{{#Security-27-2}} `false` である。(Security-27-2){{/Security-27-2}}
{{/Security-27}}


## その他のセキュリティに関わる設定

### 確認する項目

{{#Security-28}} - Security-28-\* {{/Security-28}}
{{#Security-29}} - Security-29-\* {{/Security-29}}
{{#Security-30}} - Security-30-\* {{/Security-30}}
{{#Security-31}} - Security-31-\* {{/Security-31}}
{{#Security-32}} - Security-32-\* {{/Security-32}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-9-3}}{{#Security-28 || Security-31 || Security-32}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Security-28 || Security-31 || Security-32}}{{/Security-9-3}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに`about:config`と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Security-28}}
        1. `network.captive-portal-service.enabled` の値が{{#Security-28-1}}`true`である。(Security-28-1){{/Security-28-1}}{{#Security-28-2 || Security-28-3}}`false`である。(Security-28-2/3){{/Security-28-2 || Security-28-3}}
{{/Security-28}}
{{#Security-31}}
        1. `browser.safebrowsing.blockedURIs.enabled` の値が{{#Security-31-1}}`false`である。(Security-31-1){{/Security-31-1}}{{#Security-31-2}}`true`である。(Security-31-2){{/Security-31-2}}
{{/Security-31}}
{{#Security-32}}
        1. `xpinstall.whitelist.required` の値が{{#Security-32-1}}`true`である。(Security-32-1){{/Security-32-1}}{{#Security-32-2}}`false`である。(Security-32-2){{/Security-32-2}}
{{/Security-32}}
{{#Security-30}}

{{#Security-29}}
1. `https://piro.sakura.ne.jp` を開き、Ctrl-Shift-KでWebコンソールを開く。
1. `document.cookie = 'secure=true; Secure'` を実行する。
1. `document.cookie` を実行する。(`secure=true` という結果が出力される。)
1. `http://piro.sakura.ne.jp` を新しいタブで開き、Ctrl-Shift-KでWebコンソールを開く。
1. `document.cookie = 'secure=false; Secure'` を実行する。(HTTPSで設定したCookieの値をHTTPなページから書き換える)
1. `https://piro.sakura.ne.jp` のタブに戻り、ページを再読み込みする。
1. `document.cookie` を実行する。
    - 確認項目
        1. {{#Security-29-1}}`secure=false` という結果が出力される。（Security-29-1）{{/Security-29-1}}{{#Security-29-2}}`secure=true` という結果が出力される。（Security-29-2）{{/Security-29-2}}
{{/Security-29}}

1. テストケースの `block_script_with_wrong_mime.py` を実行し誤ったMIMEタイプを返すHTTPサーバーを起動する。
1. Firefoxで `http://(HTTPサーバーのIPアドレス):8888/block_script_with_wrong_mime.html` を開く。
    - 確認項目
{{#Security-30-1}}
        1. アラートダイアログに`3`が表示され、スクリプトがブロックされていない。(Security-30-1)
{{/Security-30-1}}
{{#Security-30-2}}
        1. アラートダイアログが表示されず、スクリプトがブロックされている。(Security-30-2)
{{/Security-30-2}}
1. Pythonの実行環境がない場合、about:configを開いて次の設定値を確認する。
    - 確認項目
{{#Security-30-1}}
        1. `security.block_script_with_wrong_mime`の値が`false`である (Security-30-1)
{{/Security-30-1}}
{{#Security-30-2}}
        1. `security.block_script_with_wrong_mime`の値が`true`である (Security-30-2)
{{/Security-30-2}}
{{/Security-30}}

{{#Security-9-3}}{{#Security-28 || Security-31 || Security-32}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/Security-28 || Security-31 || Security-32}}{{/Security-9-3}}

<!--======================================================================-->

# プライバシー情報に関わるカスタマイズ

## プライバシー情報の利用制限

### 確認する項目

{{#Privacy-1}} - Privacy-1-\* {{/Privacy-1}}
{{#Privacy-2-2}} - Privacy-2-2 {{/Privacy-2-2}}
{{#Privacy-2-3}} - Privacy-2-3 {{/Privacy-2-3}}
{{#Privacy-3-2}} - Privacy-3-2 {{/Privacy-3-2}}
{{#Privacy-4-2}} - Privacy-4-2 {{/Privacy-4-2}}
{{#Privacy-5-2}} - Privacy-5-2 {{/Privacy-5-2}}
{{#Privacy-5-3}} - Privacy-5-3 {{/Privacy-5-3}}
{{#Privacy-6-3 || Privacy-6-4}} - Privacy-6-3/4 {{/Privacy-6-3 || Privacy-6-4}}
{{#Privacy-7}} - Privacy-7-\* {{/Privacy-7}}
{{#Privacy-8-2}} - Privacy-8-2 {{/Privacy-8-2}}
{{#Privacy-10-2}} - Privacy-10-2 {{/Privacy-10-2}}
{{#Privacy-12}} - Privacy-12-\* {{/Privacy-12}}
{{#Privacy-13}} - Privacy-13-\* {{/Privacy-13}}
{{#Privacy-15-2}} - Privacy-15-2 {{/Privacy-15-2}}
{{#Privacy-16}} - Privacy-16-\* {{/Privacy-16}}
{{#Privacy-17}} - Privacy-17-\* {{/Privacy-17}}
{{#Privacy-18-2 || Privacy-18-3}} - Privacy-18-2/3 {{/Privacy-18-2 || Privacy-18-3}}
{{#Privacy-19-2}} - Privacy-19-2 {{/Privacy-19-2}}
{{#Privacy-21-2}} - Privacy-21-2 {{/Privacy-21-2}}
{{#Privacy-32}} - Privacy-32-\* {{/Privacy-32}}
{{#Privacy-33-2 || Privacy-33-3 || Privacy-33-4 || Privacy-33-5}} - Privacy-33-2/3/4/5 {{/Privacy-33-2 || Privacy-33-3 || Privacy-33-4 || Privacy-33-5}}
{{#Privacy-35}} - Privacy-35-\* {{/Privacy-35}}
{{#Privacy-36}} - Privacy-36-\* {{/Privacy-36}}
{{#Privacy-37}} - Privacy-37-\* {{/Privacy-37}}
{{#Privacy-38}} - Privacy-38-\* {{/Privacy-38}}
{{#Privacy-39}} - Privacy-39-\* {{/Privacy-39}}
{{#Privacy-40}} - Privacy-40-\* {{/Privacy-40}}
{{#Privacy-33-2 || Privacy-33-4}}{{#Privacy-41}} - Privacy-41-\* {{/Privacy-41}}{{/Privacy-33-2 || Privacy-33-4}}
{{^Privacy-33-2 || Privacy-33-4}}{{#Privacy-41-2}} - Privacy-41-2 {{/Privacy-41-2}}{{/Privacy-33-2 || Privacy-33-4}}
{{#Privacy-42}} - Privacy-42-\* {{/Privacy-42}}
{{#Privacy-43-2}} - Privacy-43-2{{/Privacy-43-2}}
{{#Privacy-33-3 || Privacy-33-5 && Privacy-43-4}} - Privacy-43-4{{/Privacy-33-3 || Privacy-33-5 && Privacy-43-4}}
{{#Privacy-44}} - Privacy-44-\* {{/Privacy-44}}
{{#Privacy-45}} - Privacy-45-\* {{/Privacy-45}}
{{#Privacy-46}} - Privacy-46-\* {{/Privacy-46}}
{{#Privacy-47}} - Privacy-47-\* {{/Privacy-47}}
{{#Privacy-48}} - Privacy-48-\* {{/Privacy-48}}
{{#Privacy-49}} - Privacy-49-\* {{/Privacy-49}}
{{#Privacy-50}} - Privacy-50-\* {{/Privacy-50}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. Firefoxのユーザープロファイル `{{special_profile_path}}` {{#special_profile_actual_path}}（{{special_profile_actual_path}}）{{/special_profile_actual_path}}を削除する。
1. Firefoxのテンポラリファイルおよびキャッシュファイル（`%LocalAppData%\Mozilla`）を削除する。
{{#Security-9-3}}{{#Privacy-8-2 || Privacy-15-2 || Privacy-19-2 || Privacy-33-2 || Privacy-33-3 || Privacy-33-4 || Privacy-33-5 || Privacy-42-2 || Privacy-44 || Privacy-45 || Privacy-46 || Privacy-47 || Privacy-48 || Privacy-49 || Privacy-50}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Privacy-8-2 || Privacy-15-2 || Privacy-19-2 || Privacy-33-2 || Privacy-33-3 || Privacy-33-4 || Privacy-33-5 || Privacy-42-2 || Privacy-44 || Privacy-45 || Privacy-46 || Privacy-47 || Privacy-48 || Privacy-49 || Privacy-50}}{{/Security-9-3}}
{{#disable_devtools}}{{#Privacy-7 || Privacy-16 || Privacy-32 || Privacy-37}}
1. Policy Engineでの開発ツール無効化設定を解除し、一時的に有効化しておく。
{{/Privacy-7 || Privacy-16 || Privacy-32 || Privacy-37}}{{/disable_devtools}}
{{#Privacy-1 && MenuShortcut-3}}
1. MenuShortcut-3によるプライベートブラウジングの無効化設定を解除し、一時的に有効化しておく。
{{/Privacy-1 && MenuShortcut-3}}
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

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}
{{#Privacy-36}}
1. テンポラリファイルおよびキャッシュファイルフォルダ内の `thumbnails` フォルダを開いて、`https://addons.mozilla.org/` サイト内のリンクを何度か遷移する。
    - 確認項目
        1. サムネイル画像が{{#Privacy-36-1}}保存される。（Privacy-36-1）{{/Privacy-36-1}}{{#Privacy-36-2}}保存されない。（Privacy-36-2）{{/Privacy-36-2}}
{{/Privacy-36}}
{{#Privacy-33-2 || Privacy-33-4 && Privacy-41}}
1. ブラウザウィンドウで `http://www.kantei.go.jp/` を開く。
    - 確認項目
        1. トラッキング保護機能が働いた旨の通知ポップアップが{{#Privacy-41-1}}表示される。(Privacy-41-1){{/Privacy-41-1}}{{#Privacy-41-2}}表示されない。(Privacy-41-2){{/Privacy-41-2}}
{{/Privacy-33-2 || Privacy-33-4 && Privacy-41}}
{{#Privacy-35-3 || Privacy-35-4}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「プライバシーとセキュリティ」を開く。
    - 確認項目
        1. 「ブロックリストを変更」ボタンが無効化されている。（Privacy-35-3/4）
1. Firefoxを終了し、MCD用設定ファイル内の以下の行をコメントアウトする。（Privacy-35-3/4）
    * `lockPref("pref.privacy.disable_button.change_blocklist", true);`
1. Firefoxを起動する。
{{/Privacy-35-3 || Privacy-35-4}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「プライバシーとセキュリティ」を開く。
    - 確認項目
{{#Privacy-1}}
{{#Privacy-1-2 || Privacy-1-5}}
        1. 「履歴」で「Firefoxに履歴を記憶させる」が選択されているか、「記憶させる履歴を詳細設定」で「常にプライベートブラウジングモード」のチェックが外れていて選択不可になっている。(Privacy-1-2/5)
{{/Privacy-1-2 || Privacy-1-5}}
{{#Privacy-1-3}}
        1. 「履歴」で「Firefoxに履歴を一切記憶させない」が選択されているか「記憶させる履歴を詳細設定」で「常にプライベートブラウジングモード」のチェックが入っていて選択不可になっている。(Privacy-1-3) 
{{/Privacy-1-3}}
{{#Privacy-1-2 || Privacy-1-3}}
        1. 「履歴」→「記憶させる履歴を詳細設定する」が選択されており、「Firefoxの終了時に履歴を消去する」の{{#Privacy-1-2 || Privacy-1-3}}項目が存在しないか、チェックが外れていて選択不可になっている。(Privacy-1-2/3){{/Privacy-1-2 || Privacy-1-3}}
{{/Privacy-1-2 || Privacy-1-3}}
{{#Privacy-1-4 || Privacy-1-6}}
        1. 「Firefoxの終了時に履歴を消去する」の「設定」で、指定した項目にチェックが入っていて選択不可になっている。(Privacy-1-4/6)
{{/Privacy-1-4 || Privacy-1-6}}
{{#Privacy-1-5}}
        1. （一部の履歴の削除を禁止する設定を導入した場合のみ）「Firefoxの終了時に履歴を消去する」の「設定」で、指定した項目にチェックが外れていて選択不可になっている。(Privacy-1-5)
{{/Privacy-1-5}}
{{/Privacy-1}}
{{#Privacy-35}}
        1. 「ブロックリストを変更」ボタンを押して表示されるブロックリストの選択で、{{#Privacy-35-1 || Privacy-35-3}}「簡易ブロック」が選択されている。（Privacy-35-1/3）{{/Privacy-35-1 || Privacy-35-3}}{{#Privacy-35-2 || Privacy-35-4}}「広範ブロック」が選択されている。（Privacy-35-2/4）{{/Privacy-35-2 || Privacy-35-4}}
{{/Privacy-35}}
{{#Privacy-43}}
{{#Privacy-33-3 || Privacy-33-5 && Privacy-43-4}}
        1. 「トラッキング防止」の項目で「ブロックしない」が選択されている。
{{/Privacy-33-3 || Privacy-33-5 && Privacy-43-4}}
        1. 「ウェブサイトに"Do Not Track"信号を送り、追跡されたくないことを知らせます」の項目で「常に送る」が{{#Privacy-43-2}}選択されている。(Privacy-43-2){{/Privacy-43-2}}
        {{^Privacy-43-2}}選択されていない。(Privacy-43-1/3/4){{/Privacy-43-2}}
{{/Privacy-43}}
{{#Privacy-46-3 || Privacy-46-4}}
        1. 「許可設定」→「カメラ」→「設定」で「カメラへのアクセスの要求をブロック」{{#Privacy-46-3}}がチェックされていない。(Privacy-46-3){{/Privacy-46-3}}{{#Privacy-46-4}}がチェック済みである。(Privacy-46-4){{/Privacy-46-4}}
{{/Privacy-46-3 || Privacy-46-4}}
{{#Privacy-47-3 || Privacy-47-4}}
        1. 「許可設定」→「マイク」→「設定」で「マイクへのアクセスの要求をブロック」{{#Privacy-47-3}}がチェックされていない。(Privacy-47-3){{/Privacy-47-3}}{{#Privacy-47-4}}がチェック済みである。(Privacy-47-4){{/Privacy-47-4}}
{{/Privacy-47-3 || Privacy-47-4}}
{{#Script-2-6}}
        1. 「許可設定」→「通知」→「設定」で「通知の許可の要求をブロック」がチェック済みである。(Script-2-6)
{{/Script-2-6}}
<!--GROUP-->
1. オプション画面の「詳細」→「ネットワーク」を開く。
    - 確認項目
{{#Privacy-6-4}}
        1. 「オフライン作業用のデータの保存を許可しているウェブサイト」のリストに、オフラインデータの保存を確認無しで許可するよう指定したサイトが表示されている。(Privacy-6-4)
{{/Privacy-6-4}}
<!--/GROUP-->
<!--GROUP-->
1. オプション画面の「プライバシーとセキュリティ」を開く。
    - 確認項目
{{#Privacy-18-2 || Privacy-18-3}}
        1. 「Firefoxが技術的な対話データをMozillaへ送信することを許可する」のチェックが外れている。(Privacy-18-2/3)
{{/Privacy-18-2 || Privacy-18-3}}
{{#Privacy-21-2}}
        1. 「Firefoxに、あなたに代わって未送信のクラッシュレポートを送信するのを許可する」のチェックが外れている。(Privacy-21-2)
{{/Privacy-21-2}}
<!--/GROUP-->
{{#Privacy-35-3 || Privacy-35-4}}
1. Firefoxを終了し、MCD用設定ファイル内の以下の行をコメントアウト状態から復帰させる。
    * `// lockPref("pref.privacy.disable_button.change_blocklist", true);`
1. Firefoxを起動する。
{{/Privacy-35-3 || Privacy-35-4}}
{{#Privacy-2-2 || Privacy-2-3 || Privacy-3-2 || Privacy-4-2 || Privacy-4-3 || Privacy-5-2 || Privacy-5-3 || Privacy-40-1 || Privacy-40-2}}
1. テストケースの `password.html` を開く。
{{/Privacy-2-2 || Privacy-2-3 || Privacy-3-2 || Privacy-4-2 || Privacy-4-3 || Privacy-5-2 || Privacy-5-3 || Privacy-40-1 || Privacy-40-2}}
<!--GROUP-->
1. ユーザID、パスワードを入力して送信する。
    - 確認項目
{{#Privacy-2-2 || Privacy-2-3 || Privacy-5-2 || Privacy-5-3}}
{{#Privacy-5-2 || Privacy-5-3}}
        1. パスワードの保存を尋ねられない。(Privacy-5-2/3)
        1. ファイルを再読み込みしてもパスワードが自動入力されない。(Privacy-5-2/3)
{{/Privacy-5-2 || Privacy-5-3}}
{{#Privacy-2-2 || Privacy-2-3}}
        1. ユーザID入力欄をダブルクリックしても入力履歴が表示されない。(Privacy-2-2/3)
{{/Privacy-2-2 || Privacy-2-3}}
{{/Privacy-2-2 || Privacy-2-3 || Privacy-5-2 || Privacy-5-3}}
{{^Privacy-5-2}}{{^Privacy-5-3}}
{{#Privacy-40-1}}
        1. パスワードの保存を提案するポップアップが表示され、その中に「パスワードを開示」チェックボックスが表示される。（Privacy-40-1）
{{/Privacy-40-1}}
{{#Privacy-40-2}}
        1. 「パスワードを開示」チェックボックスが表示されない。（Privacy-40-2）
{{/Privacy-40-2}}
{{/Privacy-5-3}}{{/Privacy-5-2}}
<!--/GROUP-->
{{#Privacy-3-2}}
1. ファイルに名前を付けて保存し、Firefoxを再起動する。
    - 確認項目
        1. 「履歴」→「すべての履歴を表示」で「ダウンロード」の一覧に項目が存在しない。(Privacy-3-2)
{{/Privacy-3-2}}
{{#Privacy-4-2 || Privacy-4-3}}
1. ロケーションバーに `password` と入力する。
    - 確認項目
        1. ロケーションバーのオートコンプリートの項目として履歴が表示されない。(Privacy-4-2/3)
{{/Privacy-4-2 || Privacy-4-3}}
{{#Privacy-39}}
1. テストケースの `insecure-password.html` を開く。
1. パスワードの入力欄にフォーカスを移す。
    - 確認項目
        1. 安全でないフォームである旨の警告のメッセージが{{#Privacy-39-1}}表示される。(Privacy-39-1){{/Privacy-39-1}}{{#Privacy-39-2}}表示されない。（Privacy-39-2）{{/Privacy-39-2}}
{{/Privacy-39}}
{{#Privacy-12}}
1. テストケースの「browser.html」を開き「localStorage」の欄を確認する
    - 確認項目
        1. {{#Privacy-12-1}}`enabled` と出力される。(Privacy-12-1){{/Privacy-12-1}}{{#Privacy-12-2}}`disabled` と表示される。(Privacy-12-2){{/Privacy-12-2}}
{{/Privacy-12}}
{{#Privacy-13}}
1. テストケースの「browser.html」を開き「indexedDB」の欄を確認する
    - 確認項目
        1. {{#Privacy-13-1}}`enabled` と出力される。(Privacy-13-1){{/Privacy-13-1}}{{#Privacy-13-3}}`disabled` と表示される。(Privacy-13-3){{/Privacy-13-3}}
{{/Privacy-13}}
{{#Privacy-38}}
1. テストケースの「browser.html」を開き「beacon」の欄を確認する
    - 確認項目
        1. {{#Privacy-38-1}}`enabled` と表示される。(Privacy-38-1){{/Privacy-38-1}}{{#Privacy-38-2}}`disabled` と表示される。(Privacy-38-2){{/Privacy-38-2}}
{{/Privacy-38}}
1. ロケーションバーに`about:config`と入力し、詳細設定一覧を開く。
<!--GROUP-->
1. 各設定値を確認する。
    - 確認項目
{{#Privacy-6-3}}
        1. `offline.cache.enabled`の値が`false`、または`offline.cache.capacity`の値が`1`である。(Privacy-6-3)
{{/Privacy-6-3}}
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
{{#Privacy-33-2 || Privacy-33-3 || Privacy-33-4 || Privacy-33-5}}
        1. `privacy.trackingprotection.enabled` の値が{{#Privacy-33-2 || Privacy-33-4}}`true`である。(Privacy-33-2/4){{/Privacy-33-2 || Privacy-33-4}}{{#Privacy-33-3 || Privacy-33-5}}`false`である。(Privacy-33-3/5){{/Privacy-33-3 || Privacy-33-5}}
{{/Privacy-33-2 || Privacy-33-3 || Privacy-33-4 || Privacy-33-5}}
        1. `privacy.trackingprotection.pbmode.enabled` の値が{{#Privacy-33-2 || Privacy-33-4}}`true`である。(Privacy-33-2/4){{/Privacy-33-2 || Privacy-33-4}}{{#Privacy-33-3 || Privacy-33-5}}`false`である。(Privacy-33-3/5){{/Privacy-33-3 || Privacy-33-5}}
{{/Privacy-33-2 || Privacy-33-3 || Privacy-33-4 || Privacy-33-5}}
{{#Privacy-42-2}}
        1. `app.shield.optoutstudies.enabled` の値が{{#Privacy-42-1}}`true`である。(Privacy-42-1){{/Privacy-42-1}}{{#Privacy-42-2}}`false`である。(Privacy-42-2){{/Privacy-42-2}}
{{/Privacy-42-2}}
{{#Privacy-48}}
        1. `network.http.sendRefererHeader` の値が{{#Privacy-48-3}}`0`である。(Privacy-48-3){{/Privacy-48-3}}{{#Privacy-48-2}}`1`である。(Privacy-48-2){{/Privacy-48-2}}{{#Privacy-48-3}}`2`である。(Privacy-48-1){{/Privacy-48-1}}
{{/Privacy-48}}
{{#Privacy-44}}
        1. `network.http.referer.defaultPolicy` の値が{{#Privacy-44-1}}`0`である。(Privacy-44-1){{/Privacy-44-1}}{{#Privacy-44-2}}`1`である。(Privacy-44-2){{/Privacy-44-2}}{{#Privacy-44-3}}`2`である。(Privacy-44-3){{/Privacy-44-3}}{{#Privacy-44-4}}`3`である。(Privacy-44-4){{/Privacy-44-4}}
{{/Privacy-44}}
{{#Privacy-45}}
        1. `network.http.referer.defaultPolicy.pbmode` の値が{{#Privacy-45-1}}`0`である。(Privacy-45-1){{/Privacy-45-1}}{{#Privacy-45-2}}`1`である。(Privacy-45-2){{/Privacy-45-2}}{{#Privacy-45-3}}`2`である。(Privacy-45-3){{/Privacy-45-3}}{{#Privacy-45-4}}`3`である。(Privacy-45-4){{/Privacy-45-4}}
{{/Privacy-45}}
{{#Privacy-49}}
        1. `network.http.referer.defaultPolicy.trackers` の値が{{#Privacy-49-1}}`0`である。(Privacy-49-1){{/Privacy-49-1}}{{#Privacy-49-2}}`1`である。(Privacy-49-2){{/Privacy-49-2}}{{#Privacy-49-3}}`2`である。(Privacy-49-3){{/Privacy-49-3}}{{#Privacy-49-4}}`3`である。(Privacy-49-4){{/Privacy-49-4}}
{{/Privacy-49}}
{{#Privacy-50}}
        1. `network.http.referer.defaultPolicy.trackers.pbmode` の値が{{#Privacy-50-1}}`0`である。(Privacy-50-1){{/Privacy-50-1}}{{#Privacy-50-2}}`1`である。(Privacy-50-2){{/Privacy-50-2}}{{#Privacy-50-3}}`2`である。(Privacy-50-3){{/Privacy-50-3}}{{#Privacy-50-4}}`3`である。(Privacy-50-4){{/Privacy-50-4}}
{{/Privacy-50}}
{{#Privacy-46}}
        1. `permissions.default.camera` の値が{{#Privacy-46-1}}`0`である。(Privacy-46-1){{/Privacy-46-1}}{{#Privacy-46-2}}`1`である。(Privacy-46-2){{/Privacy-46-2}}{{#Privacy-46-3}}`2`である。(Privacy-46-3){{/Privacy-46-3}}
{{/Privacy-46}}
{{#Privacy-47}}
        1. `permissions.default.microphone` の値が{{#Privacy-47-1}}`0`である。(Privacy-47-1){{/Privacy-47-1}}{{#Privacy-47-2}}`1`である。(Privacy-47-2){{/Privacy-47-2}}{{#Privacy-47-3}}`2`である。(Privacy-47-3){{/Privacy-47-3}}
{{/Privacy-47}}
{{#Privacy-5-2 || Privacy-5-3}}
  {{#Privacy-40-1}}
        1. `signon.rememberSignons.visibilityToggle` の値が`true`である (Privacy-40-1)
  {{/Privacy-40-1}}
  {{#Privacy-40-2}}
        1. `signon.rememberSignons.visibilityToggle` の値が`false`である (Privacy-40-2)
  {{/Privacy-40-2}}
{{/Privacy-5-3 || Privacy-5-2}}

<!--/GROUP-->
{{#Privacy-7 || Privacy-16}}
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
        1. `dns-resolution-request: dns-prefetch.example.com` というログがブラウザコンソールに{{#Privacy-16-1}}出力される。(Privacy-16-1){{/Privacy-16-1}}{{#Privacy-16-2 || Privacy-16-3}}出力されない。(Privacy-16-2/3){{/Privacy-16-2 || Privacy-16-3}}
{{/Privacy-16}}
1. ブラウザコンソールを閉じる。
{{/Privacy-7 || Privacy-16}}
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
        1. 「最近閉じたウィンドウ」それ自体もしくはその配下の項目が表示されない。(Privacy-10-2)
{{/Privacy-10-2}}
{{#Privacy-17}}
1. ツールバー上の検索窓にフォーカスし `a` と入力する。
    - 確認項目
        1. `a` の補完候補が{{#Privacy-17-1}}表示される。(Privacy-17-1){{/Privacy-17-1}}{{#Privacy-17-2 || Privacy-17-3}}表示されない。(Privacy-17-2/3){{/Privacy-17-2 || Privacy-17-3}}
1. ツールバー上のロケーションバーにフォーカスし「新しい検索語句」等、履歴やブックマーク等からの候補が表示され得ないテキストを入力する。
    - 確認項目
        1. 補完候補が{{#Privacy-17-1}}表示される。(Privacy-17-1){{/Privacy-17-1}}{{#Privacy-17-2 || Privacy-17-3}}表示されない。(Privacy-17-2/3){{/Privacy-17-2 || Privacy-17-3}}
1. ツールバー上の検索窓の虫眼鏡のアイコンをクリックし、ポップアップ表示されたパネルの最下部の「検索設定を変更」をクリックする。
1. 開かれた設定画面の「既定の検索エンジン」欄を見る。
    - 確認項目
        1. 「検索候補を使用する」{{#Privacy-17-1}}にチェックが入っていて選択不可になっている。(Privacy-17-1){{/Privacy-17-1}}{{#Privacy-17-2 || Privacy-17-3}}のチェックが外れていて選択不可になっている。(Privacy-17-2/3){{/Privacy-17-2 || Privacy-17-3}}
        1. 「アドレスバーに検索候補を表示する」{{#Privacy-17-1}}にチェックが入っていて選択不可になっている。(Privacy-17-1){{/Privacy-17-1}}{{#Privacy-17-2 || Privacy-17-3}}のチェックが外れていて選択不可になっている。(Privacy-17-2/3){{/Privacy-17-2 || Privacy-17-3}}
{{/Privacy-17}}
1. Firefoxを終了する。
{{#Privacy-32 || Privacy-37}}
1. `C:\Users\Public\http.log` の位置に出力されているログファイル（複数ある場合はサイズが最も大きい物）をブラウザで開き、テストケースの`httplog.html`所定のスクリプトを実行する。
    - 確認項目
{{#Privacy-32}}
        1. {{#Privacy-32-1}}「All skipped? false」{{/Privacy-32-1}}{{#Privacy-32-2}}「All skipped? true」{{/Privacy-32-2}}とコンソールに出力される。
{{/Privacy-32}}
{{#Privacy-37}}
        1. {{#Privacy-37-1}}「All cancelled? false」{{/Privacy-37-1}}{{#Privacy-37-2}}「All cancelled? true」{{/Privacy-37-2}}とコンソールに出力される。
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

{{#Privacy-7 || Privacy-16}}
1. about:configで以下の設定をリセットする。
{{#Privacy-16}}
    1. `network.dns.notifyResolution` （真偽型）
{{/Privacy-16}}
    1. `devtools.chrome.enabled` （真偽型）
{{/Privacy-7 || Privacy-16}}
{{#Security-9-3 || disable_devtools}}{{#Privacy-8-2 || Privacy-15-2 || Privacy-19-2 || Privacy-33-2 || Privacy-33-3 || Privacy-42-2 || Privacy-44 || Privacy-45 || disable_devtools}}
1. Policy Engineに加えた変更を元に戻す。
{{/disable_devtools || Privacy-8-2 || Privacy-15-2 || Privacy-19-2 || Privacy-33-2 || Privacy-33-3 || Privacy-42-2 || Privacy-44 || Privacy-45 || disable_devtools}}{{/Security-9-3 || disable_devtools}}
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
{{#Security-3-3}}
1. Policy Engineでのアドオンマネージャ無効化設定を解除し、一時的に有効化しておく
{{/Security-3-3}}
{{#Security-9-3}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Security-9-3}}
1. 十分な日数分の履歴項目を以下の手順で用意する。
    1. システムの日付と時刻について、インターネット経由での調整を無効にする。例えばWindowsであれば、タスクバーの時計を右クリックして「日付と時刻の調整」を選択し、「日付と時刻」ダイアログの「インターネット時刻」タブで「設定の変更」ボタンをクリックし、「インターネット時刻サーバーと同期する」のチェックを外す。（※要：管理者権限）
    1. システムの日付を5＋2日以上前の日付に変更する。
    1. Firefox上で何らかのWebページを開き、リンクを辿ってページを遷移する。
    1. この操作を、日付を1日ずつ進めながら繰り返す。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
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
9. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
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
{{#Security-3-3 || Security-9-3}}
1. Policy Engineに加えた変更を元に戻す。
{{/Security-3-3 || Security-9-3}}
{{/Privacy-9-1}}

{{#Privacy-14}}
## 位置情報の利用制限

### 確認する項目

- Privacy-14-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. テストケースの「browser.html」を開き「geolocation」の欄を確認する
    - 確認項目
{{#Privacy-14-3 || Privacy-14-6}}
        1. `disabled`と表示されている (Privacy-14-3)
{{/Privacy-14-3 || Privacy-14-6}}
{{#Privacy-14-1 || Privacy-14-4 }}
        1. `enabled`と表示されている (Privacy-14-1/4)
        1. 「exec」をクリックすると「このサイトに位置情報の共有を許可しますか？」と尋ねられる。
{{/Privacy-14-1 || Privacy-14-4 }}
{{#Privacy-14-4 || Privacy-14-6}}
1. 確認無しでの位置情報の取得を許可するサイトのページを開き、「ページの情報」を開いて「サイト別設定」タブを選択する。
    - 確認項目
        1. 「位置情報の送信」で、「標準設定を使用する」のチェックが外れており、{{#Privacy-14-4}}「許可」が選択されている。(Privacy-14-4){{/Privacy-14-4}}{{#Privacy-14-6}}「ブロック」が選択されている。(Privacy-14-6){{/Privacy-14-6}}
1. 「位置情報の送信」で、「{{#Privacy-14-4}}ブロック{{/Privacy-14-4}}{{#Privacy-14-6}}許可{{/Privacy-14-6}}」を選択してFirefoxを再起動する。
1. 確認無しでの位置情報の取得を許可するよう設定していたサイトのページを開き、「ページの情報」を開いて「サイト別設定」タブを選択する。
    - 確認項目
        1. 「位置情報の送信」で、「標準設定を使用する」のチェックが外れており、{{#Privacy-14-4}}「ブロック」が選択されている。(Privacy-14-4){{/Privacy-14-4}}{{#Privacy-14-6}}「許可」が選択されている。(Privacy-14-6){{/Privacy-14-6}}
{{/Privacy-14-4 || Privacy-14-6}}

{{/Privacy-14}}

{{#Privacy-22-2 || Privacy-22-3 || Privacy-24-2 || Privacy-24-3}}
## Firefox Syncの利用制限

### 確認する項目

{{#Privacy-22-2 || Privacy-22-3}}- Privacy-22-2/3{{/Privacy-22-2 || Privacy-22-3}}
{{#Privacy-24-2 || Privacy-24-3}}- Privacy-24-2/3{{/Privacy-24-2 || Privacy-24-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開く。
    - 確認項目
        1. 「Syncにログイン」の項目が存在しない。{{#Privacy-22-2 || Privacy-22-3}}(Privacy-22-2/3){{/Privacy-22-2 || Privacy-22-3}}{{#Privacy-24-2 || Privacy-24-3}}(Privacy-24-2/3){{/Privacy-24-2 || Privacy-24-3}}
1. 「ツール」メニューを開く。
    - 確認項目
        1. 「Syncにログイン」が存在しない。{{#Privacy-22-2 || Privacy-22-3}}(Privacy-22-2/3){{/Privacy-22-2 || Privacy-22-3}}{{#Privacy-24-2 || Privacy-24-3}}(Privacy-24-2/3){{/Privacy-24-2 || Privacy-24-3}}
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
        1. 「Sync」が存在しない。{{#Privacy-22-2 || Privacy-22-3}}(Privacy-22-2/3){{/Privacy-22-2 || Privacy-22-3}}{{#Privacy-24-2 || Privacy-24-3}}(Privacy-24-2/3){{/Privacy-24-2 || Privacy-24-3}}
        2. 「Syncにサインイン」が存在しない。{{#Privacy-22-2 || Privacy-22-3}}(Privacy-22-2/3){{/Privacy-22-2 || Privacy-22-3}}{{#Privacy-24-2 || Privacy-24-3}}(Privacy-24-2/3){{/Privacy-24-2 || Privacy-24-3}}

{{/Privacy-22-2 || Privacy-22-3 || Privacy-24-2 || Privacy-24-3}}

{{#Privacy-27-2 || Privacy-27-3}}
## プライバシーに関わる機能の利用制限

### 確認する項目

 - Privacy-27-2/3

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
        1. 「Pocket」が存在しない。(Privacy-27-2)
1. Webページ中の任意のリンクを右クリックしてコンテキストメニューを開く。
    - 確認項目
        1. 「リンクをPocketに保存」が存在しない。(Privacy-27-2)
{{/Privacy-27-2 || Privacy-27-3}}


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

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
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

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「プライバシーとセキュリティ」を開く。
    - 確認項目
        1. 「サイトから送られてきたCookieを保存する」に{{^Privacy-11-4}}チェックが入っている。（Privacy-11-1/2/3/5）{{/Privacy-11-4}}{{#Privacy-11-4}}チェックが入っていない。（Privacy-11-4）{{/Privacy-11-4}}
        1. 「サードパーティCookieの保存」で{{^Privacy-11-4}}「常に許可」が選択されている。（Privacy-11-1/2/3/5）{{/Privacy-11-4}}{{#Privacy-11-4}}「常に拒否」が選択されている。（Privacy-11-4）{{/Privacy-11-4}}
{{^Privacy-11-4}}
        1. 「Cookieを保存する期間」で{{^Privacy-11-3}}「サイトが指定した期限まで」が選択されている。（Privacy-11-1/2/5）{{/Privacy-11-3}}{{#Privacy-11-3}}「Firefoxを終了するまで」が選択されている。（Privacy-11-3）{{/Privacy-11-3}}
{{/Privacy-11-4}}
{{#Privacy-11-5 || Privacy-11-6 || Privacy-11-7}}
1. Cookie保存の許可対象のサイトを開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
        1. 「サイト別設定」タブで「Cookieデータの保存」において「許可」にチェックが入っている。（Privacy-11-5）
        1. 「ポップアップウィンドウを開く」を「ブロック」に変更してFirefoxを再起動し、再び同じページの「ページの情報」の「サイト別設定」タブを開いた時、{{#Privacy-11-6}}「Cookieデータの保存」において「許可」にチェックが入っている。（Privacy-11-6）{{/Privacy-11-6}}{{#Privacy-11-5 || Privacy-11-7}}「ブロック」にチェックが入っている。（Privacy-11-5/7）{{/Privacy-11-5 || Privacy-11-7}}
{{/Privacy-11-5 || Privacy-11-6 || Privacy-11-7}}

{{/Privacy-11}}

{{#Privacy-34}}
## フォームへのユーザー入力値のセッション情報への保存の可否

### 確認する項目

- Privacy-34-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
2. Firefoxのユーザープロファイル `{{special_profile_path}}` {{#special_profile_actual_path}}（{{special_profile_actual_path}}）{{/special_profile_actual_path}}を削除する。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。{{^Startup-1-2}}「設定移行ウィザード」が表示されたら、設定をインポートせずにウィザードを終了する。{{/Startup-1-2}}
1. テストケースの `password.html` を開く。
1. ユーザID欄に「ユーザ入力値」と入力し、20秒待つ。
1. ユーザープロファイル内の `sessionstore-backups` フォルダ内の `recovery.jsonlz4` を開く。
   - 確認項目
       1. ファイル内に「ユーザ入力値」という文字列が{{#Privacy-34-1}}含まれている。（Privacy-34-1）{{/Privacy-34-1}}{{#Privacy-34-2}}含まれていない。（Privacy-34-2）{{/Privacy-34-2}}
{{/Privacy-34}}

<!--======================================================================-->

# Webブラウズ機能に関するカスタマイズ

{{#Websearch-1-1 || Websearch-1-3 || Websearch-2}}
## 検索エンジンの制限

### 確認する項目

{{#Websearch-1-1 || Websearch-1-3}} - Websearch-1-1/3 {{/Websearch-1-1 || Websearch-1-3}}
{{#Websearch-2-2}} - Websearch-2-2 {{/Websearch-2-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. ロケーションバーに `https://addons.mozilla.org/` と入力し、ページを開く。
1. Web検索バーのアイコンをクリックする。
    - 確認項目
{{#Websearch-1}}
        1. Web検索バーのアイコンに「+」のバッジが{{#Websearch-1-1}}表示される。(Websearch-1-1){{/Websearch-1-1}}{{#Websearch-1-3}}表示されない。(Websearch-1-3){{/Websearch-1-3}}
        1. パネル上に「”Firefoxアドオン”を追加」という項目が{{#Websearch-1-1}}表示される。(Websearch-1-1){{/Websearch-1-1}}{{#Websearch-1-3}}表示されない。(Websearch-1-3){{/Websearch-1-3}}
{{/Websearch-1}}
{{#Websearch-2-2}}
        1. パネル上に、無効にした検索エンジンが表れていない（ないし有効にした検索エンジンのみが表示される）。(Websearch-2-2)
{{/Websearch-2-2}}
{{#Websearch-2-2}}
1. パネル下部の「検索設定を変更」をクリックする。(Websearch-2-2)
    - 確認項目
    -   1. 「既定の検索エンジン」のドロップダウンリストに、無効にした検索エンジンが表れていない。(Websearch-2-2)
        1. 「ワンクリック検索エンジン」のリストに、無効にした検索エンジンが表れていない。(Websearch-2-2)
{{/Websearch-2-2}}

{{/Websearch-1-1 || Websearch-1-3 || Websearch-2}}


{{#Location-1 || Location-2 || Location-3}}
## ロケーションバーの表示の制御

### 確認する項目

{{#Locatio-1}} - Location-1-\* {{/Locatio-1}}
{{#Locatio-2}} - Location-2-\* {{/Locatio-2}}
{{#Locatio-3}} - Location-3-\* {{/Locatio-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Locatio-1}}
1. ロケーションバーに `http://example.com/` のように `http://` で始まるURLを入力し、ページを開く。
    - 確認項目
        1. ロケーションバーのURL表記に `http://` が{{#Location-1-2}}含まれている。(Location-1-2){{/Location-1-2}}{{#Location-1-1}}含まれていない。(Location-1-1){{/Location-1-1}}
{{/Locatio-1}}
{{#Locatio-2}}
1. ロケーションバーに `https://日本語.jp/` のように日本語ドメインのURLを入力し、ページを開く。
    - 確認項目
        1. ロケーションバーのURLが{{#Location-2-1}}日本語で表示されている。(Location-2-1){{/Location-2-1}}{{#Location-2-2}}punycode形式で表示されている。(Location-2-2){{/Location-2-2}}
{{/Locatio-2}}
{{#Locatio-3}}
1. ロケーションバーに `localhost` のように一単語の（名前解決可能な）ホスト名を入力し、ページを開く。
    - 確認項目
        1. {{#Location-3-1}}ホスト名を単語とした検索結果が表示される。(Location-3-1){{/Location-3-1}}{{#Location-3-2}}そのホストが名前解決され、ページが表示される。(Location-3-2){{/Location-3-2}}
{{/Locatio-3}}
{{/Location-1 || Location-2 || Location-3}}


## ダウンロードに関する機能の制御

### 確認する項目

{{#Download-1}} - Download-1-\* {{/Download-1}}
{{#Download-2}} - Download-2-\* {{/Download-2}}
{{#Download-3}} - Download-3-\* {{/Download-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
2. Firefoxのユーザープロファイル `{{special_profile_path}}` {{#special_profile_actual_path}}（{{special_profile_actual_path}}）{{/special_profile_actual_path}}を削除する。
3. 既定のダウンロード先（`{{download_dir}}`）を用意しておく。用意できない場合は、Download-2-1の参照先を `C:\` などの実在するパスに変更し、以下の説明も読み替える。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Download-2 || Download-3-1 || Download-3-2}}
1. ロケーションバーに `https://getfirefox.com/` と入力し、ページを開く。
1. 「今すぐダウンロード」のボタン（リンク）をクリックする。
1. ファイルのダウンロードが開始され、保存方法を尋ねるダイアログが表示されるので、ファイルの保存操作をキャンセルする。
1. 再ダウンロードのリンクを右クリックし、メニューから「名前を付けてリンク先を保存」を選択する。
{{#Download-2}}
    - 確認項目
        1. {{#Download-2-1 || Download-2-2 || Download-2-4 || Download-2-5}}ダウンロード先として`{{download_dir}}`が選択された状態でファイル選択ダイアログが開かれる。(Download-2-1/2/4/5){{/Download-2-1 || Download-2-2 || Download-2-4 || Download-2-5}}{{#Download-2-3}}ホームディレクトリ内の「ダウンロード」が選択された状態でファイル選択ダイアログが開かれる。(Download-2-3) {{/Download-2-3}}
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
1. Firefoxのダウンロード用ボタンをクリックする。ファイルのダウンロードが開始され、保存方法を尋ねるダイアログが表示されるので、「ファイルを保存」を選択する。
{{#Download-3-3 || Download-3-4}}
    - 確認項目
        1. ダウンロード先ディレクトリを選択するダイアログが開かれる。（Download-3-3/4）
{{/Download-3-3 || Download-3-4}}
{{#Download-3-1 || Download-3-2}}
1. ロケーションバーに `http://www.mozilla.org/` と入力し、ページを開く。
1. Webページ中の任意のリンクを右クリックし、「名前を付けてリンク先を保存」を選択する。
    - 確認項目
        1. ダウンロード先として{{#Download-3-1}}`{{download_dir}}`内の「subfolder」が選択された状態でファイル選択ダイアログが開かれる。(Download-3-1){{/Download-3-1}}{{#Download-3-2}}`{{download_dir}}`が選択された状態でファイル選択ダイアログが開かれる。(Download-3-2){{/Download-3-2}}
{{^Download-1-2}}
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「一般」を開く。
    - 確認項目
        1. 「ダウンロード」は「次のフォルダに保存する」が選択されている。(Download-3-\*)
        1. ダウンロード先として{{#Download-3-1}}`{{download_dir}}`内の `subfolder` が表示されている。(Download-3-1){{/Download-3-1}}{{#Download-3-2}}`{{download_dir}}`が表示されている。(Download-3-2){{/Download-3-2}}
{{/Download-1-2}}
{{/Download-3-1 || Download-3-2}}
{{/Download-3}}

## タブの操作に関する機能の制御

### 確認する項目

{{#Tab-1}} - Tab-1-\* {{/Tab-1}}
{{#Tab-2}} - Tab-2-\* {{/Tab-2}}
{{#Tab-3}} - Tab-3-\* {{/Tab-3}}
{{#Tab-5}} - Tab-5-\* {{/Tab-5}}
{{#Tab-9}} - Tab-9-\* {{/Tab-9}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Tab-3}}
1. テストケース `links.html` を用意する。
{{/Tab-3}}
{{#Security-9-3}}{{#Tab-2-3 || Tab-9-2}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Tab-2-3 || Tab-9-2}}{{/Security-9-3}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
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
{{#Tab-5}}
1. タブバー上の「+」ボタンをクリックして新しいタブを開く。またはパネルメニューを開き、パネルメニュー内の「新しいウィンドウ」をクリックする。
    - 確認項目
{{#Tab-5-1}}
        1. 右上に歯車アイコンのある空白ページが表示される。(Tab-5-1)
{{/Tab-5-1}}
{{#Tab-5-3 || Tab-5-4}}
        1. 右上に歯車アイコンのない空白ページが表示される。{{#Tab-5-3 || Tab-5-4}}(Tab-5-3/4){{/Tab-5-3 || Tab-5-4}}
{{/Tab-5-3 || Tab-5-4}}
{{/Tab-5}}
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

{{#Security-9-3}}{{#Tab-2-3 || Tab-9-2}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/Tab-2-3 || Tab-9-2}}{{/Security-9-3}}


{{#Tab-10 || Tab-11 || Tab-12 || Tab-13 || Tab-14 || Tab-15 || Tab-16}}
## 新しいタブページの表示制御

### 確認する項目

{{#Tab-10}} - Tab-10-\* {{/Tab-10}}
{{#Tab-11}} - Tab-11-\* {{/Tab-11}}
{{#Tab-12}} - Tab-12-\* {{/Tab-12}}
{{#Tab-13}} - Tab-13-\* {{/Tab-13}}
{{#Tab-14}} - Tab-14-\* {{/Tab-14}}
{{#Tab-15}} - Tab-15-\* {{/Tab-15}}
{{#Tab-16}} - Tab-16-\* {{/Tab-16}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. タブバーの「＋」ボタンをクリックして新しいタブを開く
{{#Tab-10}}
1. 検索バーの表示を確認する
{{#Tab-10-1}}
    - 画面上に検索バーが表示されている (Tab-10-1)
{{/Tab-10-1}}
{{#Tab-10-2 || Tab-10-4}}
    - 画面上に検索バーが表示されている
    - 右上の歯車メニューで「検索」のチェックが固定されている (Tab-10-2/4)
{{/Tab-10-2 || Tab-10-4}}
{{#Tab-10-3 || Tab-10-5}}
    - 画面上に検索バーが表示されていない
    - 右上の歯車メニューで「検索」のチェックが固定されている (Tab-10-3/5)
{{/Tab-10-3 || Tab-10-5}}
{{/Tab-10}}

{{#Tab-11}}
1. トップサイトの表示を確認する
{{#Tab-11-1}}
    - 画面上にトップサイトが表示されている (Tab-11-1)
{{/Tab-11-1}}
{{#Tab-11-2 || Tab-11-5}}
    - 画面上にトップサイトが表示されている
    - 右上の歯車メニューで「トップサイト」のチェックが固定されている (Tab-11-2/5)
{{/Tab-11-2 || Tab-11-5}}
{{#Tab-11-3}}
    - 画面上にトップサイトが表示されている
    - 右上の歯車メニューで「トップサイト」のチェックが固定されている
    - 右上の歯車メニューで「2行で表示」のチェックが固定されている (Tab-11-3)
{{/Tab-11-3}}
{{#Tab-11-4 || Tab-11-6}}
    - 画面上にトップサイトが表示されていない
    - 右上の歯車メニューで「トップサイト」のチェックが固定されている (Tab-11-4/6)
{{/Tab-11-4 || Tab-11-6}}
{{/Tab-11}}

{{#Tab-16-2}}
1. トップサイトの一覧を確認する
    - 一覧に表示されているサイトが指定の通りになっている (Tab-16-2)
{{/Tab-16-2}}

{{#Tab-12}}
1. ハイライトの表示を確認する
{{#Tab-12-1}}
    - 画面上にハイライトが表示されている (Tab-12-1)
{{/Tab-12-1}}
{{#Tab-12-2 || Tab-12-4}}
    - 画面上にハイライトが表示されている
    - 右上の歯車メニューで「ハイライト」のチェックが固定されている (Tab-12-2/4)
{{/Tab-12-2 || Tab-12-4}}
{{#Tab-12-3 || Tab-12-5}}
    - 画面上にハイライトが表示されていない
    - 右上の歯車メニューで「ハイライト」のチェックが固定されている (Tab-12-3/5)
{{/Tab-12-3 || Tab-12-5}}
{{/Tab-12}}

{{#Tab-13}}
1. スニペットの表示を確認する
{{#Tab-13-1}}
    - 画面上にスニペットが表示されている (Tab-13-1)
    - 右上の歯車メニューで「スニペット」のチェックが入っている (Tab-13-1)
{{/Tab-13-1}}
{{#Tab-13-2 || Tab-13-4}}
    - 画面上にスニペットが表示されている
    - 右上の歯車メニューで「スニペット」のチェックが固定されている (Tab-13-2/4)
{{/Tab-13-2 || Tab-13-4}}
{{#Tab-13-3 || Tab-13-5}}
    - 画面上にスニペットが表示されていない
    - 右上の歯車メニューで「スニペット」のチェックが固定されている (Tab-13-3/5)
{{/Tab-13-3 || Tab-13-5}}
{{/Tab-13}}

{{#Tab-14}}
1. インポートボタンの表示を確認する
{{#Tab-14-1}}
    - 画面上にインポートボタンが表示されている (Tab-14-1)
{{/Tab-14-1}}
{{#Tab-14-2 || Tab-14-3}}
    - 画面上にインポートボタンが表示されていない (Tab-14-2/3)
{{/Tab-14-2 || Tab-14-3}}
{{/Tab-14}}

{{#Tab-15}}
1. 新機能ツアーの表示を確認する
{{#Tab-15-1}}
    - 画面左上にFirefoxのアイコンが色付きで表示されている (Tab-15-1)
{{/Tab-15-1}}
{{#Tab-15-2}}
    - 画面左上にFirefoxのアイコンが表示されていない、またはグレーで表示されている (Tab-15-2)
{{/Tab-15-2}}
{{/Tab-15}}


{{/Tab-10 || Tab-11 || Tab-12 || Tab-13 || Tab-14 || Tab-15 || Tab-16}}


{{#Tab-17 || Tab-18}}
## 複数のタブに関わる機能の制御

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

## 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. 3つ以上のタブを開く。
{{#Tab-17}}
1. キーボードショートカットのCtrl-Tabを入力する。
    - 確認項目
        1. {{#Tab-17-1}}タブのサムネイルが横一列に表示され、最近表示した順にタブが切り替わる。(Tab-17-1){{/Tab-17-1}}{{#Tab-17-2}}タブが画面上の順番通りに切り替わる。(Tab-17-2){{/Tab-17-2}}
{{/Tab-17}}
{{#Tab-18}}
1. Ctrlキーを押しながら、アクティブでないタブをクリックする。
    - 確認項目
        1. {{#Tab-18-1}}クリックされたタブの色が変わり、複数のタブがハイライトされた状態になる。(Tab-18-1){{/Tab-18-1}}{{#Tab-18-2}}クリックされたタブがフォーカスされる。(Tab-18-2){{/Tab-18-2}}
{{/Tab-18}}


{{/Tab-17 || Tab-18}}


{{#Ui-1}}
## 内蔵PDFビューアの使用

### 確認する項目

- Ui-1-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「プログラム」を開く。
    - 確認項目
        1. ファイルの種類「PDF文書（PDF）」（「Adobe Acrobat Document」、「PDFファイル」となっている場合もあるため注意）の取り扱い方法{{#Ui-1-1}}が「Firefoxでプレビュー表示」となっている。(Ui-1-1){{/Ui-1-1}}{{#Ui-1-2 || Ui-1-3}}の選択肢に「Firefoxでプレビュー表示」が存在しない。(Ui-1-2/3){{/Ui-1-2 || Ui-1-3}}
{{/Ui-1}}



## その他のWebアプリ向けAPIの使用制限

### 確認する項目

{{#Script-2}} - Script-2-\* {{/Script-2}}
{{#Script-3}} - Script-3-\* {{/Script-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-9-3}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Security-9-3}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Script-2-3}}
1. テストケースリストから `https://labs.othersight.jp/webpushtest/` のリンクをクリックする。
    - 確認項目
        1. ページ内に「Service Worker not available」と表示されている。(Script-2-3)
{{/Script-2-3}}
<!--GROUP-->
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Script-2}}
        1. `dom.push.enabled` の値が{{#Script-2-1}}`true`である。(Script-2-1){{/Script-2-1}}{{#Script-2-3}}`false`である。(Script-2-3){{/Script-2-3}}
        1. `dom.serviceWorkers.enabled` の値が{{#Script-2-1}}`true`である。(Script-2-1){{/Script-2-1}}{{#Script-2-3}}`false`である。(Script-2-3){{/Script-2-3}}
{{/Script-2}}
{{#Script-3}}
        1. `dom.gamepad.enabled` の値が{{#Script-3-1}}`true`である。(Script-3-1){{/Script-3-1}}{{#Script-3-2}}`false`である。(Script-3-2){{/Script-3-2}}
{{/Script-3}}
<!--/GROUP-->
{{#Script-2-4 || Script-2-6}}
1. 確認なしでpush通知を許可する対象のサイトを開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。
    - 確認項目
        1. 「サイト別設定」タブで「通知を受信する」において{{#Script-2-4}}「許可」にチェックが入っている。(Script-2-4){{/Script-2-4}}{{#Script-2-6}}「ブロック」にチェックが入っている。(Script-2-6){{/Script-2-6}}
1. 「通知を受信する」で、「{{#Script-2-4}}ブロック{{/Script-2-4}}{{#Script-2-6}}許可{{/Script-2-6}}」を選択してFirefoxを再起動する。
1. 確認なしでpush通知を許可するよう設定していたサイトのページを開き、「ページの情報」を開いて「サイト別設定」タブを選択する。
    - 確認項目
        1. 「通知を受信する」で、「標準設定を使用する」のチェックが外れており、{{#Script-2-4}}「ブロック」が選択されている。(Script-2-4){{/Script-2-4}}{{#Script-2-6}}「許可」にチェックが入っている。(Script-2-6){{/Script-2-6}}
{{/Script-2-4 || Script-2-6}}

{{#Security-9-3}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/Security-9-3}}

{{#Stability-1}}
## ハードウェアアクセラレーションの使用

### 確認する項目

- Stability-1-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「一般」を開く。
1. 「推奨のパフォーマンス設定を利用する」のチェックを外す。
    - 確認項目
        1. 「ハードウェアアクセラレーション機能を使用する」に{{#Stability-1-1}}チェックが入っている。(Stability-1-1){{/Stability-1-1}}{{#Stability-1-2}}チェックが入っていない。(Stability-1-2){{/Stability-1-2}}
{{/Stability-1}}
1. 「推奨のパフォーマンス設定を利用する」のチェックを元に戻す。


{{#Stability-2-2 || Stability-2-3}}
## プロセス分離の制御

### 確認する項目

{{#Stability-2-2}}
- Stability-2-2
{{/Stability-2-2}}
{{#Stability-2-3}}
- Stability-2-3
{{/Stability-2-3}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 1回Firefoxを起動し、終了する。
   （初回起動時は必ずプロセス分離が無効化されるため、必ず2回目以降の起動時の状態で検証する。）

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. about:supportを開く
    - 確認項目
       1. 「アプリケーション基本情報」の「マルチプロセスウィンドウ」に{{#Stability-2-2}}「有効」と表示されている。(Stability-2-2){{/Stability-2-2}}{{#Stability-2-3}}「無効」と表示されている。(Stability-2-3){{/Stability-2-3}}
{{/Stability-2-2 || Stability-2-3}}

{{#Appearance-1-2 || Appearance-1-3}}
## 表示フォントの設定

### 確認する項目

- Appearance-1-2/3

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-9-3}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Security-9-3}}
{{#disable_devtools}}
1. Policy Engineでの開発ツール無効化設定を解除し、一時的に有効化しておく
{{/disable_devtools}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. about:configを開き、以下の設定を行う。
    - `font.name.serif.ja`（文字列型）を`missing`に設定する。
    - `font.name.sans-serif.ja`（文字列型）を`missing`に設定する。
    - `font.name.monospace.ja`（文字列型）を`missing`に設定する。
3. テストケースの `font.html` を開く。
4. 「Serif / セリフ体（明朝）」の箇所を右クリックし、「要素を調査」を選択して、インスペクタ右端の「フォント」をクリックする。
    - 確認項目
        1. `missing` ではなく、 `font.name-list.serif.ja` に設定したフォントのいずれかの名前が表示される。（Appearance-1-2/3）
5. 「Sans-Serif / サンセリフ体（ゴシック）」の箇所を右クリックし、「要素を調査」を選択して、インスペクタ右端の「フォント」をクリックする。
    - 確認項目
        1. `missing` ではなく、 `font.name-list.sans-serif.ja` に設定したフォントのいずれかの名前が表示される。（Appearance-1-2/3）
6. 「Monospace / 等幅」の箇所を右クリックし、「要素を調査」を選択して、インスペクタ右端の「フォント」をクリックする。
    - 確認項目
        1. `missing` ではなく、 `font.name-list.monospace.ja` に設定したフォントのいずれかの名前が表示される。（Appearance-1-2/3）

### 後始末

1. about:configで以下の設定をリセットする。
    1. `font.name.serif.ja`（文字列型）
    2. `font.name.sans-serif.ja`（文字列型）
    3. `font.name.monospace.ja`（文字列型）
{{#Security-9-3 || disable_devtools}}
1. Policy Engineに加えた変更を元に戻す。
{{/Security-9-3 || disable_devtools}}
{{/Appearance-1-2 || Appearance-1-3}}

{{#Appearance-2-2 || Appearance-3-2 || Appearance-5-1 || Appearance-6-1}}
## ツールバーの項目

### 確認する項目

{{#Appearance-2-2}} - Appearance-2-2 {{/Appearance-2-2}}
{{#Appearance-3-2}} - Appearance-3-2 {{/Appearance-3-2}}
{{#Appearance-5-1}} - Appearance-5-1 {{/Appearance-5-1}}
{{#Appearance-6-1}} - Appearance-6-1 {{/Appearance-6-1}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
    - 確認項目
{{#Appearance-2-2}}
        1. ツールバーに表示されている項目が、指定の通りとなっている。（Appearance-2-2）
{{/Appearance-2-2}}
{{#Appearance-5-1}}
        1. ブックマークツールバーが表示されている。（Appearance-5-1）
{{/Appearance-5-1}}
{{#Appearance-6-1}}
        1. メニューバーが表示されている。（Appearance-6-1）
{{/Appearance-6-1}}
{{#Appearance-2-2}}
2. ツールバーカスタマイズで、ツールバーおよびパネルメニューの内容を変更する。
3. Firefoxを再起動する。
    - 確認項目
        1. （表示項目を固定した場合は）ツールバーに表示されている項目が、指定の通りとなっている。（Appearance-2-2）
{{/Appearance-2-2}}
{{#Appearance-3-2}}
1. ロケーションバーの表示を確認する
    - 確認項目
        1. ロケーションバーと検索バーが統合されていない (Appearance-3-2)
{{/Appearance-3-2}}
{{/Appearance-2-2 || Appearance-3-2 || Appearance-5-1 || Appearance-6-1}}

{{#Appearance-4-1}}
## Windows 7におけるウィンドウコントロールの不具合の回避

### 確認する項目

 - Appearance-4-1

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. Windowsのテーマを「クラシック」に切り替えておく。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
2. ツールバーを右クリックし、「メニューバー」にチェックを入れる。
3. テストケースの `popup-with-flags.html` を開く。
4. ページ内の「toolbar」というリンクをクリックする。
5. ポップアップがブロックされた場合は、ブロック通知からポップアップを開き直す。
    - 確認項目
        1. 開かれたポップアップウィンドウのウィンドウコントロール（最小化、最大化、閉じる）がクリック可能で、動作する。(Appearance-4-1)
{{/Appearance-4-1}}

## Webブラウズ操作のその他のカスタマイズ

### 確認する項目

{{#Ui-2}} - Ui-2-\* {{/Ui-2}}
{{#Ui-5}} - Ui-5-\* {{/Ui-5}}
{{#Ui-6}} - Ui-6-\* {{/Ui-6}}
{{#Ui-7}} - Ui-7-\* {{/Ui-7}}
{{#Ui-9-2}} - Ui-9-2 {{/Ui-9-2}}
{{#Script-1}} - Script-1-\* {{/Script-1}}
{{#Script-4}} - Script-4-\* {{/Script-4}}
{{#Script-5}} - Script-5-\* {{/Script-5}}
{{#Performance-1-2}} - Performance-1-2 {{/Performance-1-2}}
{{#Performance-2-2}} - Performance-2-2 {{/Performance-2-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-9-3}}{{#Performance-1 || Performance-2}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Performance-1 || Performance-2}}{{/Security-9-3}}
{{#disable_devtools}}{{#Privacy-7 || Privacy-16 || Privacy-32 || Privacy-37}}
1. Policy Engineでの開発ツール無効化設定を解除し、一時的に有効化しておく
{{/Privacy-7 || Privacy-16 || Privacy-32 || Privacy-37}}{{/disable_devtools}}


### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Ui-2}}
1. コンテンツ領域にフォーカスした状態でF7キーを押す。
   - 確認項目
       1. キャレットブラウズの開始の可否を{{#Ui-2-1}}尋ねられる。（Ui-2-1）{{/Ui-2-1}}{{#Ui-2-2}}尋ねられない。（Ui-2-2）{{/Ui-2-2}}
{{/Ui-2}}
{{#Ui-9-2}}
1. ロケーションバーにフォーカスした状態でTabキーを押す。
   - 確認項目
       1. ロケーションバーの右側にあるツールバーボタンにフォーカスが移動しない（Ui-9-2）
{{/Ui-9-2}}
1. ロケーションバーに `http://www.clear-code.com/blog/` と入力し、ページを開く。
{{#Ui-5}}
    - 確認項目
        1. ロケーションバー内に本または書類形のアイコン（マウスオーバーで「リーダービューに切り替えます」という内容のツールチップが表示される）が{{#Ui-5-1}}表示される。（Ui-5-1）{{/Ui-5-1}}{{#Ui-5-2}}表示されない。（Ui-5-2）{{/Ui-5-2}}
{{/Ui-5}}
1. テストケースの `textfield.html` を開く。
{{#Ui-6}}
1. テキスト入力欄に一旦フォーカスし、ページ内の他の箇所をクリックしてフォーカスを外す。
    - 確認項目
        1. テキスト入力欄中の `abc` の下に赤い波線が{{#Ui-6-1}}表示される。（Ui-6-1）{{/Ui-6-1}}{{#Ui-6-2}}表示されない。（Ui-6-2）{{/Ui-6-2}}
{{/Ui-6}}
{{#Ui-7}}
1. ロケーションバー右側の「…」をクリックする。
    - 確認項目
        1. メニューに「スクリーンショットを撮る」が{{#Ui-7-1}}表示される。（Ui-7-1）{{/Ui-7-1}}{{#Ui-7-2 || Ui-7-3}}表示されない。（Ui-7-2）{{/Ui-7-2 || Ui-7-3}}
{{/Ui-7}}
{{#Script-1}}
1. テストケースの `alert.html` を開く。
    - 確認項目
        1. 2つ目以降のダイアログに、以後のダイアログを表示しないようにするかどうかを尋ねるチェックボックスが{{#Script-1-1}}表示される。（Script-1-1）{{/Script-1-1}}{{#Script-1-2}}表示されない。（Script-1-2）{{/Script-1-2}}
{{/Script-1}}
{{#Script-4 || Script-5}}
1. テストケースの `mouseevent.html` を開く。
{{#Script-4}}
1. コンテンツ内の文字を選択して、キーボードショートカット「Ctrl-C」でコピーする。
    - 確認項目
{{#Script-4-1}}
        1. コンソール上に `copy` という文字が出力される。（Script-4-1）
{{/Script-4-1}}
{{#Script-4-2}}
        1. コンソール上に `copy` という文字が出力されない。（Script-4-2）
{{/Script-4-2}}
{{/Script-4}}
{{#Script-5}}
1. コンテンツ領域の上で右クリックする。
    - 確認項目
{{#Script-5-1}}
        1. コンテキストメニューが開かれない。（Script-5-1）
{{/Script-5-1}}
{{#Script-5-2}}
        1. コンテキストメニューが開かれる。（Script-5-2）
{{/Script-5-2}}
{{/Script-5}}
{{/Script-4 || Script-5}}
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

{{#Security-9-3}}{{#Performance-1 || Performance-2}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/Performance-1 || Performance-2}}{{/Security-9-3}}

{{#Script-6}}
## 音声の自動再生の制御

### 確認する項目

- Script-6-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。

### 検証

1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
        1. `media.autoplay.default` の値が {{#Script-6-1}}`0` である。(Script-6-1){{/Script-6-1}}{{#Script-6-2}}`1` である。(Script-6-2){{/Script-6-2}}

### 後始末

1. Policy Engineに加えた変更を元に戻す。

{{/Script-6}}

<!--======================================================================-->

# ネットワーク処理に関するカスタマイズ

{{#Network-2}}
## プロキシの設定

### 確認する項目

- Network-2-\*

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
1. 自動プロキシ設定スクリプトのURLが未設定の場合、設定する。
   {{pac_url_setup}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
1. オプション画面の「一般」→「ネットワークプロキシ」→「接続設定」を開く。
    - 確認項目
{{#Network-2-1 || Network-2-6}}
        1. 「プロキシを使用しない」が選択されている。(Network-2-1/6)
{{/Network-2-1 || Network-2-6}}
{{#Network-2-2 || Network-2-7}}
        1. 「手動でプロキシを設定する」が選択されている。(Network-2-2/7)
        1. 各プロキシが指定通りに設定されている。(Network-2-2/7)
{{/Network-2-2 || Network-2-7}}
{{#Network-2-3 || Network-2-8}}
        1. 「自動プロキシ設定スクリプトURL」が選択されている。(Network-2-3/8)
        1. 「自動プロキシ設定スクリプトURL」の欄に、予め指定しておいたURLが入力されている。(Network-2-3/8)  
           （`{{pac_url}}` または `data:application/javascript,`）
{{/Network-2-3 || Network-2-8}}
{{#Network-2-4 || Network-2-9}}
        1. 「このネットワークのプロキシ設定を自動検出する」が選択されている。(Network-2-4/9)
{{/Network-2-4 || Network-2-9}}
{{#Network-2-5 || Network-2-10}}
        1. 「システムのプロキシ設定を利用する」が選択されている。(Network-2-5/10)
{{/Network-2-5 || Network-2-10}}

{{/Network-2}}

## その他のネットワーク関連設定

### 確認する項目

{{#Network-1-1}} - Network-1-1 {{/Network-1-1}}
{{#Network-4-1}} - Network-4-1 {{/Network-4-1}}
{{#Network-5-2}} - Network-5-2 {{/Network-5-2}}
{{#Network-6}} - Network-6-\* {{/Network-6}}
{{#Network-7}} - Network-7-\* {{/Network-7}}
{{#Network-8}} - Network-8-\* {{/Network-8}}
{{#Network-10}} - Network-10-\* {{/Network-10}}
{{#Network-11-2}} - Network-11-2 {{/Network-11-2}}
{{#Network-12}} - Network-12-\* {{/Network-12}}
{{#Network-13}} - Network-13-\* {{/Network-13}}
{{#Network-14}} - Network-14-\* {{/Network-14}}
{{#Network-17}} - Network-17-\* {{/Network-17}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-9-3}}{{#Network-1-1 || Network-4-1 || Network-5-2 || Network-6 || Network-7 || Network-8 || Network-10 || Network-13 || Network-14 || Network-17}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Network-1-1 || Network-4-1 || Network-5-2 || Network-6 || Network-7 || Network-8 || Network-10 || Network-13 || Network-14 || Network-17}}{{/Security-9-3}}
{{#Network-12}}
1. テストケースの `sample.jar` を任意のサーバーに設置し、Content-Type `application/java-archive` を伴って返却されるように設定しておく。
   ファイルの設置先は `{{jar_file_sample_url_base}}/sample.jar` とする。
{{/Network-12}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Network-1-1}}
        1. `general.useragent.extra.microsoftdotnet` が項目として存在しない、もしくは、値が未定義である。(Network-1-1)
{{/Network-1-1}}
{{#Network-4-1}}
        1. `network.automatic-ntlm-auth.trusted-uris` の値が「{{ntlm_single_signon_hosts}}」である。(Network-4-1)
{{/Network-4-1}}
{{#Network-5-2}}
{{#max_connections}}
        1. `network.http.max-connections` の値が{{max_connections}}である。(Network-5-2)
{{/max_connections}}
{{#max_persistent_connections_per_server}}
        1. `network.http.max-persistent-connections-per-server` の値が{{max_persistent_connections_per_server}}である。(Network-5-2)
{{/max_persistent_connections_per_server}}
{{#max_persistent_connections_per_proxy}}
        1. `network.http.max-persistent-connections-per-proxy` の値が{{max_persistent_connections_per_proxy}}である。(Network-5-2)
{{/max_persistent_connections_per_proxy}}
{{/Network-5-2}}
{{#Network-6}}
        1. `network.http.spdy.enabled` の値が{{#Network-6-1}}`true`である。(Network-6-1){{/Network-6-1}}{{#Network-6-2}}`false`である。(Network-6-2){{/Network-6-2}}
{{/Network-6}}
{{#Network-7}}
        1. `security.tls.insecure_fallback_hosts`の値が{{#Network-7-1}}未設定または空文字である。(Network-7-1){{/Network-7-1}}{{#Network-7-2}}`{{ntlm_single_signon_hosts}}`である。(Network-7-2){{/Network-7-2}}
{{/Network-7}}
{{#Network-8}}
        1. `network.dns.disableIPv6` の値が{{#Network-8-1}}`false`である。(Network-8-1){{/Network-8-1}}{{#Network-8-2}}`true`である。(Network-8-2){{/Network-8-2}}
{{#dns_disable_prefetch}}
        1. `network.dns.disablePrefetch` の値が{{#Network-8-1}}`false`である。(Network-8-1){{/Network-8-1}}{{#Network-8-2}}`true`である。(Network-8-2){{/Network-8-2}}
{{/dns_disable_prefetch}}
{{/Network-8}}
{{#Network-10}}
        1. `network.dns.blockDotOnion` の値が{{#Network-10-1}}`false`である。(Network-10-1){{/Network-10-1}}{{#Network-10-2}}`true`である。(Network-10-2){{/Network-10-2}}
{{/Network-10}}
{{#Network-13}}
        1. `security.tls.version.max` の値が{{#Network-13-1}}`4`である。(Network-13-1){{/Network-13-1}}{{#Network-13-2 || Network-13-3}}`3`以下である。(Network-13-2/3){{/Network-13-2 || Network-13-3}}
{{/Network-13}}
{{#Network-17}}
        1. `security.tls.version.max` の値が{{#Network-17-1}}`1`である。(Network-17-1){{/Network-17-1}}{{#Network-17-2}}`2`以上である。(Network-17-2){{/Network-17-2}}
{{/Network-17}}
{{#Network-14}}
        1. `security.pki.sha1_enforcement_level` の値が{{#Network-14-1}}`0`である。(Network-14-1){{/Network-14-1}}{{#Network-14-2}}`1`である。(Network-14-2){{/Network-14-2}}{{#Network-14-3}}`2`である。(Network-14-3){{/Network-14-3}}{{#Network-14-4}}`3`である。(Network-14-4){{/Network-14-4}}{{#Network-14-5}}`4`である。(Network-14-5){{/Network-14-5}}
{{/Network-14}}
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

{{#Security-9-3}}{{#Network-1-1 || Network-4-1 || Network-5-2 || Network-6 || Network-7 || Network-8 || Network-10 || Network-13 || Network-14}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/Network-1-1 || Network-4-1 || Network-5-2 || Network-6 || Network-7 || Network-8 || Network-10 || Network-13 || Network-14}}{{/Security-9-3}}

<!--======================================================================-->

# 自動更新のカスタマイズ

## Firefoxおよびアドオンの自動更新の制限

### 確認する項目

{{#Update-1-4}} - Update-1-4 {{/Update-1-4}}
{{#Update-2-2 || Update-2-3}} - Update-2-2/3 {{/Update-2-2 || Update-2-3}}
{{#Update-3-2}} - Update-3-2 {{/Update-3-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#Security-9-3}}
1. Policy Engineでのabout:config無効化設定を解除し、一時的に有効化しておく。
{{/Security-9-3}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
{{#Update-1-4}}
1.  「ヘルプ」→「Firefoxについて」を開く。
    - 確認項目
        1. 「ソフトウェアの更新を確認」が表示されない。(Update-1-4)
{{/Update-1-4}}
1. ロケーションバーに `about:config` と入力し、詳細設定一覧を開いて、各設定値を確認する。
    - 確認項目
{{#Update-2-2 || Update-2-3}}
        1. `extensions.update.enabled` の値が`false`である。(Update-2-2/3)
{{/Update-2-2 || Update-2-3}}
{{#Update-3-2}}
        1. `browser.search.update` の値が`false`である。(Update-3-2)
{{/Update-3-2}}

{{#Security-9-3}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/Security-9-3}}

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
{{#Security-3-3}}
1. Policy Engineでのアドオンマネージャ無効化設定を解除し、一時的に有効化しておく
{{/Security-3-3}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. アドオンマネージャを開き、「プラグイン」を選択する。
    - 確認項目
        1. 個別の制御を行っていないNPAPIプラグインが既定の状態で{{#Plugin-10-1}}無効化されている。（Plugin-10-1）{{/Plugin-10-1}}{{#Plugin-10-2}}有効化されている。（Plugin-10-2）{{/Plugin-10-2}}{{#Plugin-10-3}}「実行時に確認する」が選択されている。(Plugin-10-3){{/Plugin-10-3}}

### 後始末

{{#Security-3-3}}
1. Policy Engineに加えた変更を元に戻す。
{{/Security-3-3}}
1. 各プラグインの制御が可能であるかどうか自体を検証した場合、{{mcd_local_file}}に加えた変更を元に戻す。
{{/Plugin-10}}

## プラグインの個別制御

### 確認する項目

{{#Security-24}} - Security-24-\* {{/Security-24}}
{{#Security-33}} - Security-33-\* {{/Security-33}}
{{#Plugin-2}} - Plugin-2-\* {{/Plugin-2}}
{{#Plugin-8}} - Plugin-8-\* {{/Plugin-8}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
{{^Security-24-2}}
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{/Security-24-2}}
{{#Security-24-2}}
    1. カスタマイズ済みFirefox(32bit版)のインストールが完了した状態にする。
{{/Security-24-2}}
{{#Plugin-2 || Security-24 || Security-33}}
1. Adobe Flashプラグインが未導入の場合、`{{flash_download_url}} ` からAdobe Flash プラグインのインストーラをダウンロードし、インストールしておく。
{{/Plugin-2 || Security-24 || Security-33}}
{{#Security-3-3}}
{{#Plugin-2 || Plugin-8}}
1. Policy Engineでのアドオンマネージャ無効化設定を解除し、一時的に有効化しておく
{{/Plugin-2 || Plugin-8}}
{{/Security-3-3}}


### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. アドオンマネージャを開き、「プラグイン」を選択する。
    - 確認項目
{{#Plugin-2}}
        1. Adobe Flashプラグインの項目が表示されており、{{#Plugin-2-1 || Plugin-2-4}}「無効化する」が選択されている。(Plugin-2-1/4){{/Plugin-2-1 || Plugin-2-4}}{{#Plugin-2-2 || Plugin-2-5}}「常に有効化する」が選択されている。(Plugin-2-2/5){{/Plugin-2-2 || Plugin-2-5}}{{#Plugin-2-3}}「実行時に確認する」が選択されている。(Plugin-2-3){{/Plugin-2-3}}
{{/Plugin-2}}
{{#Plugin-8}}
        1. OpenH264のプラグインが{{#Plugin-8-1}}表示される。(Plugin-8-1){{/Plugin-8-1}}{{#Plugin-8-2}}表示されない。(Plugin-8-2){{/Plugin-8-2}}
        1. 「Primetime Content Decryption Module」が{{#Plugin-8-1}}表示される。(Plugin-8-1){{/Plugin-8-1}}{{#Plugin-8-2}}表示されない。(Plugin-8-2){{/Plugin-8-2}}
        1. 「Widevine Content Decryption Module」が{{#Plugin-8-1}}表示される。(Plugin-8-1){{/Plugin-8-1}}{{#Plugin-8-2}}表示されない。(Plugin-8-2){{/Plugin-8-2}}
{{/Plugin-8}}
{{#Security-24 || Security-33}}
1. Flashプラグインの「設定」ボタンをクリックする。
    - 確認項目
{{#Security-24}}
        1. 32bit版Firefoxにおいて、「Adobe Flashの保護モードを有効化」に{{#Security-24-1}}チェックが入っている。（Security-24-1）{{/Security-24-1}}{{#Security-24-2}}チェックが入っていない。（Security-24-2）{{/Security-24-2}}
           （64bit版Firefoxにおいては機能が存在しないため確認を省略する。）
{{/Security-24}}
{{#Security-33}}
        1. 「危険ででしゃばりなFlashコンテンツをブロック」に{{#Security-33-1}}チェックが入っている。（Security-33-1）{{/Security-33-1}}{{#Security-33-2}}チェックが入っていない。（Security-33-2）{{/Security-33-2}}
{{/Security-33}}
{{/Security-24 || Security-33}}

{{#Security-3-3}}
{{#Plugin-2 || Plugin-8}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/Plugin-2 || Plugin-8}}
{{/Security-3-3}}

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

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. 外部アプリケーションで開く必要があるファイルへのリンクをクリックする。
1. 「次のファイルを開こうとしています」のダイアログが表示されたら、起動する外部アプリケーションを選択して「OK」をクリックする。
1. テンポラリフォルダの内容を確認する。
    - 確認項目
        1. ダウンロードしたファイルがテンポラリフォルダに保存されている。(External-1-1/2)
        1. テンポラリファイルのプロパティにおいて、「読み取り専用」が{{#External-1-1}}チェックありもしくは半チェック（四角形の塗りつぶし、または半透明のチェックマーク）の状態である。(External-1-1){{/External-1-1}}{{#External-1-2}}チェック無しの状態である。(External-1-2){{/External-1-2}}
1. 外部アプリケーションを終了しFirefoxも終了して、テンポラリフォルダの内容を確認する。
    - 確認項目
        1. ダウンロードしたファイルが{{#External-1-1}}テンポラリフォルダから消えている。(External-1-1){{/External-1-1}}{{#External-1-2}}テンポラリフォルダに残っている。(External-1-2){{/External-1-2}}
{{/External-1}}

## IE Viewの制御

### 確認する項目

{{#Addon-IEView-1-2 || Addon-IEView-1-3 || Addon-IEView-1-4 || Addon-IEView-1-5}} - Addon-IEView-1-2/3/4/5 {{/Addon-IEView-1-2 || Addon-IEView-1-3 || Addon-IEView-1-4 || Addon-IEView-1-5}}
{{#Addon-IEView-2-1 || Addon-IEView-2-2}} - Addon-IEView-2-1/2 {{/Addon-IEView-2-1 || Addon-IEView-2-2}}
{{#Addon-IEView-3-2}} - Addon-IEView-3-2 {{/Addon-IEView-3-2}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。
{{#disable_devtools}}
1. Policy Engineでの開発ツール無効化設定を解除し、一時的に有効化しておく。
{{/disable_devtools}}

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. 自動的にIEを起動するよう設定されたページへのリンクがあるページを開き、そのリンクから新しいタブを開く。
    - 確認項目
{{#Addon-IEView-1}}
        1. IEが起動する。（Addon-IEView-1-2/3/4/5）
{{/Addon-IEView-1}}
{{#Addon-IEView-1-3 || Addon-IEView-1-5}}
        1. Firefox上のタブが閉じられる。（Addon-IEView-1-3/5）
{{/Addon-IEView-1-3 || Addon-IEView-1-5}}
{{#Addon-IEView-2-1 || Addon-IEView-2-2}}
        1. 指定したパスのIEが起動しており、指定したオプションも反映されている。（Addon-IEView-2-1/2）
{{/Addon-IEView-2-1 || Addon-IEView-2-2}}
<!--/GROUP-->
{{#Addon-IEView-3-2}}
1. 自動的にIEを起動するよう設定されたページ以外のページを開く。
1. パネルメニューの「開発ツール」（またはメニューバーの「Web開発」）をクリックし、サブメニューの「インスペクター」をクリックする。
1. 「HTMLを検索」欄に「#src_xsale」と入力し、Enterキーを押す。
    - 確認項目
        1. 「見つかりませんでした。」と表示される。（Addon-IEView-3-2）
{{/Addon-IEView-3-2}}

{{#disable_devtools}}
### 後始末

1. Policy Engineに加えた変更を元に戻す。
{{/disable_devtools}}


<!--======================================================================-->

# キーボードショートカット、メニュー項目のカスタマイズ

## タブとウィンドウの操作

### 確認する項目

{{#MenuShortcut-3}} - MenuShortcut-3 {{/MenuShortcut-3}}
{{#MenuShortcut-10}} - MenuShortcut-10 {{/MenuShortcut-10}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
    - 確認項目
{{#MenuShortcut-3}}
        1. 「Ctrl-Shift-P」を押して、新しいプライベートウィンドウが開かれない。(MenuShortcut-3)
{{/MenuShortcut-3}}
<!--/GROUP-->
<!--GROUP-->
1. 「ファイル」メニューを開く。
    - 確認項目
{{#MenuShortcut-3}}
        1. 「新しいプライベートウィンドウを開く」が存在しない。(MenuShortcut-3)
{{/MenuShortcut-3}}
<!--/GROUP-->
{{#MenuShortcut-10}}
1. 「ツール」メニューを開く。
    - 確認項目
        1. 「ウェブ開発」が存在しない。(MenuShortcut-10)
{{/MenuShortcut-10}}
1. パネルメニューを開く。
{{#MenuShortcut-3}}
    - 確認項目
        1. 「新しいプライベートウィンドウ」が存在しない。(MenuShortcut-3)
{{/MenuShortcut-3}}
<!--GROUP-->
1. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。
    - 確認項目
{{#MenuShortcut-10}}
        1. 「開発ツール」が存在しない。(MenuShortcut-10)
{{/MenuShortcut-10}}
<!--/GROUP-->

## ツール

### 確認する項目

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

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
    - 確認項目
{{#MenuShortcut-11}}
        1. 「Ctrl-Shift-I」を押して、開発ツールが開かれない。(MenuShortcut-11)
        1. 「F12」を押して、開発ツールが開かれない。(MenuShortcut-11)
{{/MenuShortcut-11}}
{{#MenuShortcut-12}}        1. 「Ctrl-Shift-C」を押して、インスペクタが開かれない。(MenuShortcut-12){{/MenuShortcut-12}}
{{#MenuShortcut-13}}        1. 「Ctrl-Shift-K」を押して、Webコンソールが開かれない。(MenuShortcut-13){{/MenuShortcut-13}}
{{#MenuShortcut-14}}        1. 「Ctrl-Shift-S」を押して、デバッガが開かれない。(MenuShortcut-14){{/MenuShortcut-14}}
{{#MenuShortcut-15}}        1. 「Shift-F7」を押して、スタイルエディタが開かれない。(MenuShortcut-15){{/MenuShortcut-15}}
{{#MenuShortcut-16}}        1. 「Shift-F5」を押して、プロファイラが開かれない。(MenuShortcut-16){{/MenuShortcut-16}}
{{#MenuShortcut-17}}        1. 「Ctrl-Shift-E」を押して、ネットワークモニターが開かれない。(MenuShortcut-17){{/MenuShortcut-17}}
{{#MenuShortcut-18}}        1. 「Shitf-F2」を押して、開発ツールバーが開かれない。(MenuShortcut-18){{/MenuShortcut-18}}
{{#MenuShortcut-20}}        1. 「Shift-F8」を押して、WebIDEが開かれない。(MenuShortcut-20){{/MenuShortcut-20}}
{{#MenuShortcut-21}}        1. 「Ctrl-Shift-Alt-I」を押して、ブラウザツールボックスが開かれない。(MenuShortcut-21){{/MenuShortcut-21}}
{{#MenuShortcut-22}}        1. 「Ctrl-Shift-J」を押して、ブラウザコンソールが開かれない。(MenuShortcut-22){{/MenuShortcut-22}}
{{#MenuShortcut-23}}        1. 「Ctrl-Shift-M」を押して、レスポンシブデザインビューが開かれない。(MenuShortcut-23){{/MenuShortcut-23}}
{{#MenuShortcut-25}}        1. 「Shift-F4」を押してスクラッチパッド、が開かれない。(MenuShortcut-25){{/MenuShortcut-25}}
<!--
{{#MenuShortcut-26}}        1. 「Ctrl-U」を押して、ページのソースが開かれない。(MenuShortcut-26){{/MenuShortcut-26}}
-->
<!--GROUP-->
{{^MenuShortcut-10}}
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
{{/MenuShortcut-10}}
<!--/GROUP-->
<!--GROUP-->
{{^MenuShortcut-10}}
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
{{/MenuShortcut-10}}
<!--/GROUP-->

## ヘルプ

### 確認する項目

{{#Appearance-8-2}} - Appearance-8-2 {{/Appearance-8-2}}
{{#MenuShortcut-35}} - MenuShortcut-35 {{/MenuShortcut-35}}
{{#MenuShortcut-36}} - MenuShortcut-36 {{/MenuShortcut-36}}
{{#MenuShortcut-37}} - MenuShortcut-37 {{/MenuShortcut-37}}
{{#MenuShortcut-38}} - MenuShortcut-38 {{/MenuShortcut-38}}
{{#MenuShortcut-39}} - MenuShortcut-39 {{/MenuShortcut-39}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
1. 通常のWebページ（例：`http://www.example.com/`）を開く。
<!--GROUP-->
1. 「ヘルプ」メニューを開く。
    - 確認項目
{{#Appearance-8-2}}        1. 指定のサポート情報ページ用の項目が表示されている。(Appearance-8-2){{/Appearance-8-2}}
{{#MenuShortcut-35}}        1. 「トラブルシューティング情報」が存在しないか無効化されている。(MenuShortcut-35){{/MenuShortcut-35}}
{{#MenuShortcut-36}}        1. 「フィードバックを送信」が存在しないか無効化されている。(MenuShortcut-36){{/MenuShortcut-36}}
{{#MenuShortcut-37}}        1. 「アドオンを無効にして再起動」が存在しないか無効化されている。(MenuShortcut-37){{/MenuShortcut-37}}
{{#MenuShortcut-38}}        1. 「詐欺サイトを報告」が存在しないか無効化されている。(MenuShortcut-38){{/MenuShortcut-38}}
<!--/GROUP-->
<!--GROUP-->
1. パネルメニューを開き、パネルメニュー内の「？」をクリックする。
    - 確認項目
{{#MenuShortcut-35}}        1. 「トラブルシューティング情報」が存在しないか無効化されている。(MenuShortcut-35){{/MenuShortcut-35}}
{{#MenuShortcut-36}}        1. 「フィードバックを送信」が存在しないか無効化されている。(MenuShortcut-36){{/MenuShortcut-36}}
{{#MenuShortcut-37}}        1. 「アドオンを無効にして再起動」が存在しないか無効化されている。(MenuShortcut-37){{/MenuShortcut-37}}
{{#MenuShortcut-38}}        1. 「詐欺サイトを報告」が存在しないか無効化されている。(MenuShortcut-38){{/MenuShortcut-38}}
<!--/GROUP-->
{{#MenuShortcut-39}}
1. `https://itisatrap.org/firefox/its-a-trap.html` を開く。
1. 「ヘルプ」メニューを開く。
    - 確認項目
        1. 「詐欺サイトの誤警告を指摘」が存在しないか無効化されている。(MenuShortcut-39)
1. パネルメニューを開き、パネルメニュー内の「？」をクリックする。
    - 確認項目
        1. 「詐欺サイトの誤警告を指摘」が存在しないか無効化されている。(MenuShortcut-39)
{{/MenuShortcut-39}}


## 履歴とブックマーク

### 確認する項目

{{#MenuShortcut-44}} - MenuShortcut-44 {{/MenuShortcut-44}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
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

{{#MenuShortcut-55}} - MenuShortcut-55 {{/MenuShortcut-55}}
{{#MenuShortcut-57}} - MenuShortcut-57 {{/MenuShortcut-57}}

### 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。
    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。

### 検証

1. デスクトップのショートカットがある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
<!--GROUP-->
1. `https://addons.mozilla.org` を開き、何もない所で右クリックする。
    - 確認項目
{{#MenuShortcut-57}}        1. 「要素を調査」が存在しない。(MenuShortcut-57){{/MenuShortcut-57}}
<!--/GROUP-->
<!--GROUP-->
1. ページ内に埋め込まれた画像の上で右クリックする。
    - 確認項目
{{#MenuShortcut-55}}        1. 「デスクトップの背景に設定」が存在しない。(MenuShortcut-55){{/MenuShortcut-55}}
<!--/GROUP-->

