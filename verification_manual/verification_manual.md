% Firefoxカスタマイズ内容の検証手順
% 株式会社クリアコード
% 20XX年X月X日

# 1 はじめに

対象のFirefoxのバージョンは{{firefox_version}}とする。

検証環境は{{windows_version}}とする。

参照する設定資料は{{configuration_sheet_name}}とする。

# 2 新規インストールに関するカスタマイズ

## 2.1 メタインストーラを使用した、新規インストールの手順

- メタインストーラの名称は{{meta_installer_name}}、ファイル名は{{meta_installer_file_name}}とする。 
- メタインストーラの表示バージョンは{{meta_installer_version}}とする。 
- Firefoxのインストール先は{{install_path}}とする。 
- デスクトップのショートカットは{{desktop_shortcut_path}} に作成するものとする。 
- スタートメニューのショートカットは{{start_menu_shortcut_path}}に作成するものとする。 

### 2.1.1 確認する項目

- Install-1-\* 
- Install-2-\* 
- Install-3-\* 
- Install-4-\* 
- Install-5-\* 
- Install-6-\* 
- Install-7-\* 
- Install-8-\* 
- Install-9-2 
- Application-1-\* 
- Application-2-\* 
- Application-3-\* 
- Admin-1-\* 
- Update-4-\* 

### 2.1.2 準備

1. コントロールパネル→プログラムと機能で以下がインストールされているならばアンインストールする。  
    1. {{meta_installer_name}} 
    2. Mozilla Firefox  
    3. Mozilla Maintenance Service  
2. 以下のファイル、フォルダを削除する。
    1. {{install_path}} 
    2. C:\\Program Files (x86)\\ClearCode Inc  
    3. Firefoxのユーザープロファイル（%AppData%\\Mozilla） 
    4. Firefoxのテンポラリファイルおよびキャッシュファイル（%LocalAppData%\\Mozilla） 

### 2.1.3 検証

1. メタインストーラ作成キット一式を用意する。
    - 確認項目 
        1. メタインストーラ作成キット一式の格納フォルダ名が「{{meta_installer_file_name}}-source」である。(Install-2-\*) 
2. 不要なファイルを削除する。
    - {{meta_installer_file_name}}\*.exe
3. fainstall.iniを開き、検証環境に合わせて内容を修正する。 
    - フルパスが指定されている箇所で当該パスのドライブが存在しない場合、検証用としてファイル中の「（ドライブレター）:/」の指定をすべて「C:/（ドライブレター）/」に置換する。\
      以下、ファイルの作成先はすべて置換後のパスで読み替える。 
4. {{meta_installer_file_name}}.batを実行する。
    - 確認項目
        1. {{meta_installer_file_name}}.exeが作成される。(Install-9-1)\
           または、{{meta_installer_file_name}}-{{meta_installer_version}}.exeが作成される。(Install-9-2) 
5. 作成された{{meta_installer_file_name}}\*.exeを実行する。
    - 確認項目
        1. メタインストーラの圧縮ファイルを展開する様子を示すダイアログが表示される。 
        2. メタインストーラのウィザードが表示される。(Install-3-2)(Install-6-\*)\
            または、ウィザードが表示されない。(Install-3-3) 
        3. インストール完了後に「{{finish_title}}」のタイトルで「{{finish_message}}」のメッセージが表示される。(Install-4-2)\
            または、メッセージが表示されない。(Install-4-1)
        4. インストール完了後に「{{restart_title}}」のタイトルで「{{restart_message}}」のメッセージが表示される。(Install-5-2)\
            または、メッセージが表示されない。(Install-5-1)

6. インストールされた環境が想定通りか確認する。
    - 確認項目
        1. 以下のファイル、フォルダが存在する。
            1. {{install_path}}\\firefox.exe (Install-8-\*) 
            2. {{install_path}}\\{{mcd_local_file}} (Admin-1-\*) 
            3. {{desktop_shortcut_path}} (Application-1-1/3) 
            4. {{start_menu_shortcut_path}} (Application-2-1/3) 
        2. 以下のファイル、フォルダが存在しない。
            1. {{desktop_shortcut_path}} (Application-1-2) 
            2. {{start_menu_shortcut_path}} (Application-2-2) 
        3. Windows Vista以前のクイック起動バーにMozilla Firefoxのショートカットが表示されている。(Application-3-1)\
            またはショートカットが表示されていない。(Application-3-2) 
        4. コントロールパネル→プログラムと機能で、以下の通りとなっている。 
            1. 「Mozilla Firefox {{firefox_version}}」がインストールされている。（ベータ版を用いた検証の場合、バージョン表記は「beta」を除いた数字が期待される。）(Install-7-\*) 
            2. 「{{meta_installer_name}}」がインストールされている。(Install-1-\*) 
            3. 「{{meta_installer_name}}」のバージョンが「{{meta_installer_version}}」と表示されている。(Install-9-2) 
            4. 「Mozilla Maintenance Service」がインストールされている。(Update-4-1)\
                または、インストールされていない。(Update-4-2) 

## 2.2 専用ユーザープロファイルの作成と使用

- 専用ユーザープロファイルの作成先は{{special_profile_path}}とする。 
- 専用ユーザープロファイルの名前は{{special_profile_name}}とする。 

### 2.2.1 確認する項目

- Application-1-3 
- Application-2-3 
- Application-6-2 

### 2.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 2.2.3 検証

1. Windowsエクスプローラ（フォルダウィンドウ）を開き、ロケーションバーに「{{special_profile_path}}」と入力してEnterを押す。 

    - 確認項目
         
        1. 「{{special_profile_name}}」フォルダが存在する。(Application-6-2) 

        2. フォルダの内容は空である。(Application-6-2) 

2. {{desktop_shortcut_path}}のプロパティを開く。 

    - 確認項目 

        1. 作業フォルダが「"（Firefoxの実行ファイルがあるフォルダパス）"」である。(Application-1-3) 

        2. 「リンク先」末尾に「-profile {{special_profile_path}}\\{{special_profile_name}}」というオプションが指定されている。（環境変数の参照記法がそのまま含まれている）(Application-1-3) 

3. {{start_menu_shortcut_path}}のプロパティを開く。 

    - 確認項目 

        1. 作業フォルダが「"（Firefoxの実行ファイルがあるフォルダパス）"」である。(Application-2-3) 

        2. 「リンク先」末尾に「-profile {{special_profile_path}}\\{{special_profile_name}}」というオプションが指定されている。（環境変数の参照記法がそのまま含まれている）(Application-2-3) 

4. Windowsエクスプローラ（フォルダウィンドウ）を開き、ロケーションバーに「{{special_profile_path}}\\{{special_profile_name}}」と入力してEnterを押す。 

5. {{desktop_shortcut_path}}をダブルクリックし、Firefoxを起動する。 

    - 確認項目 

        1. Firefoxの起動後、4で開いたフォルダに「prefs.js」などのファイルが作成される。 
 
## 2.3 旧バージョンとの共存

### 2.3.1 確認する項目

- Install-1-2 

- Install-2-2 

- Application-1-3 

- Appliaction-2-3 

- Application-6-\* 

### 2.3.2 準備

1. コントロールパネル→プログラムと機能
    で以下がインストールされているならばアンインストールする。  

    1. {{meta_installer_name}} 

    2. 旧バージョンのメタインストーラ 

    3. Mozilla Firefox  

    4. Mozilla Maintenance Service  

2. 以下のファイル、フォルダを削除する。
     

    1. {{install_path}} 

    2. 旧バージョンのメタインストーラによってインストールされたFirefox 

    3. C:\\Program Files (x86)\\ClearCode Inc  

    4. Firefoxのユーザープロファイル（%AppData%\\Mozilla） 

    5. Firefoxのテンポラリファイルおよびキャッシュファイル（%LocalAppData%\\Mozilla） 

    6. スタートメニューに登録されたショートカット（%AppData%\\Microsoft\\Internet Explorer\\Quick
        Launch\\User Pinned\\StartMenu\\
        内に作られたショートカット） 

3. 旧バージョン、新バージョンの各メタインストーラ作成キット内のバッチファイルを実行し、インストーラの実行ファイルを作成しておく。 

### 2.3.3 検証

1. 旧バージョンのメタインストーラを実行する。 

2. {{desktop_shortcut_path}}をダブルクリックし、Firefoxを起動する。 

3. パネルメニューを開き、パネルメニュー内の「？」をクリックして、サブメニューから「Firefoxについて」を選択する。 

    - 確認項目 

        1. Firefoxのバージョンが旧バージョンのメタインストーラに同梱されたバージョンであると表示される。 

4. ユーザが変更可能な何らかの設定を変更する。 

    - 例： 

        1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
             

        2. オプション画面の「検索」を開く。 

        3. 「既定の検索エンジン」を「Google」から「Yahoo！
            JAPAN」に変更する。 

5. Firefoxを終了する。 

6. 旧バージョン起動用のショートカットをスタートメニューのよく使うアプリケーション一覧の上にドラッグし、「スタート
    メニューに表示する」の表示が出たらドロップする。(Application-1-3)(Application-2-3) 

    - 確認項目 

        1. スタートメニュー最上部に、ボーダーラインで区切られた状態で旧バージョン起動用のショートカットが表示される。 

        2. 追加されたショートカットを右クリックして「プロパティ」を選択して開かれたショートカットのプロパティにおいて、ショートカットのリンク先が旧バージョンの実行ファイルの位置である。 

7. 新バージョンのメタインストーラを実行する。 

    - 確認項目
         

        1. 以下のファイル、フォルダが存在する。
             

            1. （旧バージョンのFirefoxのインストール先）\\firefox.exe 

            2. （旧バージョンのFirefoxのインストール先）\\{{mcd_local_file}} 

            3. {{install_path}}\\firefox.exe(Install-1-2)(Install-2-2) 

            4. {{install_path}}\\{{mcd_local_file}}(Install-1-2)(Install-2-2) 

8. {{desktop_shortcut_path}}をダブルクリックし、Firefoxを起動する。 

9. パネルメニューを開き、パネルメニュー内の「？」をクリックして、サブメニューから「Firefoxについて」を選択する。 

    - 確認項目 

        1. Firefoxのバージョンが{{firefox_version}}であると表示される。(Install-1-2)(Install-2-2) 

10. 旧バージョンで設定した設定が維持されている。(Application-1-3)(Application-2-3)(Application-6-1)または、設定が初期状態になっている。
    (Application-1-3)(Application-2-3)(Application-6-2) 

    - 例： 

        1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
             

        2. オプション画面の「検索」を開く。 

        3. 「既定の検索エンジン」として「Google」が選択されている。(Application-6-1)または「Yahoo！
            JAPAN」が選択されている。(Application-6-2) 

11. Firefoxを終了する。 

12. スタートメニュー最上部に、ボーダーラインで区切られた状態で存在しているショートカットを右クリックして「プロパティ」を選択し、ショートカットのプロパティを開く。 

    - 確認項目 

        1. ショートカットのリンク先が新バージョンの実行ファイルの位置である。(Application-1-3)(Application-2-3) 

13. 旧バージョンのメタインストーラを実行する。 

    - 確認項目
         

        1. 以下のファイル、フォルダが存在する。
             

            1. （旧バージョンのFirefoxのインストール先）\\firefox.exe 

            2. （旧バージョンのFirefoxのインストール先）\\{{mcd_local_file}} 

            3. {{install_path}}\\firefox.exe(Install-1-2)(Install-2-2) 

            4. {{install_path}}\\{{mcd_local_file}}(Install-1-2)(Install-2-2) 

14. {{desktop_shortcut_path}}をダブルクリックし、Firefoxを起動する。 

15. パネルメニューを開き、パネルメニュー内の「？」をクリックして、サブメニューから「Firefoxについて」を選択する。 

    - 確認項目 

        1. Firefoxのバージョンが旧バージョンのメタインストーラに同梱されたバージョンであると表示される。 

16. 旧バージョンで設定した設定が維持されている。(Application-1-3)(Application-2-3)(Application-6-\*) 

    - 例： 

        1. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
             

        2. オプション画面の「検索」を開く。 

        3. 「既定の検索エンジン」として「Yahoo！
            JAPAN」が選択されている。(Application-6-\*)
             

 

# 3 起動時の状態に関するカスタマイズ

## 3.1 起動時の状態の制御

### 3.1.1 確認する項目

- Admin-2-\* 

- Admin-3-\* 

- Startup-1-\* 

- Startup-2-\* 

- Startup-3-\* 

- Startup-4-2 

- Startup-5-2 

- Startup-6-\* 

- Startup-7-\* 

- Startup-8-\* 

- Startup-9-2 

### 3.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. Firefoxのユーザープロファイル（{{special_profile_path}}）を削除する。 

3. 以下のアドオンを無効化する。 

    1. Disable about:config 

    2. globalChrome.css 

### 3.1.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。 

    - 確認項目
         

        1. Firefoxが起動した時に「設定移行ウィザード」が表示される。(Startup-1-1)\
            または、表示されない。
            (Startup-1-2) 

        2. Firefoxを既定のブラウザにするか尋ねられる。(Startup-3-1)\
            または、尋ねられない。(Startup-3-2) 

        3. Firefox既定のホーム画面が表示される。(Startup-2-1)\
            または、{{home_page}}が表示される。
            (Startup-2-2/3) 

2. ホームページが既定のホームページ（about:home）でない場合、ロケーションバーに「about:home」と入力し、ホームページを開く。(Startup-6-\*)  

    - 確認項目
         

        1. ホームページ内に「あなたの権利について……」のリンクおよび情報が表示される。(Startup-6-1)\
            または、表示されない。(Startup-6-2) 

3. 任意のWebページを開く。 

4. Webページ内のリンクをドラッグし、ツールバー上の「ホーム」ボタンにドロップする。 

5. 「このWebページまたはファイルを新しいホームページに設定します。よろしいですか？」と問われるので「はい」を選択する。 

6. ツールバー上の「ホーム」ボタンをクリックする。 

    - 確認項目 

        1. 3でドラッグ&ドロップしたリンク先のページが開かれる。(Startup-2-2)\
            または、既定のホームページが開かれる。(Startup-2-3) 

7. ロケーションバーに「about:config」と入力し、詳細設定一覧を開いて、各設定値を確認する。 

    - 確認項目 

        1. 「extensions.autoDisableScopes」の値が「15」である。(Admin-2-1)\
            または、「11」である。(Admin-2-2) 

        2. 「extensions.shownSelectionUI」の値が「false」である。(Admin-3-1)\
            または、「true」である。(Admin-3-2) 

        3. 「browser.startup.homepage\_override.mstone」の値が「ignore」である。(Startup-4-2) 

        4. 「browser.disableResetPrompt」の値が「false」である。(Startup-7-1)\
            または、「true」である。(Startup-7-2) 

        5. 「browser.requestE10sFeedback」の値が「false」である。(Startup-9-2) 

8. 詳細設定において、「extensions.lastAppVersion」を「1.0」に変更する。 

9. Firefoxを再起動する。 

    - 確認項目 

        1. アドオンの更新の確認が行われる。(Admin-3-1)\
            または、確認が行われない。(Admin-3-2) 

10. メニューバーの「ブックマーク」を開く。 

    - 確認項目 

        1. 既定の項目が作成されていない。(Startup-5-2) 

11. Firefoxのウィンドウのツールバー上で右クリックし、「ブックマークツールバー」を選択する。 

    - 確認項目 

        1. ブックマークツールバー上に既定の項目が作成されていない。(Startup-5-2) 

12. ロケーションバーに「 https://www.mozilla.org/ja/firefox/{{meta_installer_version}}/tour/ 」と入力し、ページを開く。(Startup-8-\*) 

    - 確認方法 

        1. UIツアーの開始を促すメッセージがツールバー上に表示される。(Startup-8-1)\
            または、表示されない。(Startup-8-2) 

13. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

14. オプション画面の「一般」を開く。 

    - 確認項目 

        1. 既定のブラウザの項目内の「起動時にFirefoxが既定のブラウザであるか確認する」のチェックが外れていて、無効化されている。
            (Startup-3-2) 

15. Firefoxを終了し、以下のアドオンを有効化する。 

    - globalChrome.css 

16. Firefoxを起動し、パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

17. オプション画面の「一般」を開く。 

    - 確認項目 

        1. 「現在のページを使用」「ブックマークを使う」「初期設定に戻す」ボタンが表示されていない。
            (Startup-2-3) 

### 3.1.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable about:config 

    2. globalChrome.css 

## 3.2 アドオンの署名確認の無効化

### 3.2.1 確認する項目

- Admin-4-1 

### 3.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. アドオンの未署名のインストールパッケージとして、テストケースのunsigned-sample-addon@clear-code.com.xpiを用意する。 

### 3.2.3 検証

1. 用意したインストールパッケージを{{install_path}}\\browser\\extensions\\unsigned-sample-addon@clear-code.com.xpiの位置に置く。 

2. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。 

3. Admin-2-2が選択されている場合、アドオンを有効化しFirefoxを再起動する。 

    - 確認項目
         

        1. Firefoxのウィンドウ下部に白背景・青色文字で「hello,
            world!」というメッセージが表示されている。(Admin-4-1) 

### 3.2.4 後始末

1. {{install_path}}\\browser\\extensions\\unsigned-sample-addon@clear-code.com.xpiを削除する。 

## 3.3 起動方法の制御

### 3.3.1 確認する項目

- Application-1-1/3 

- Application-2-1/3 

### 3.3.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 3.3.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。 

2. その状態のまま、{{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxの追加起動を試みる。
      

    - 確認項目
          

        1. Firefoxの新しいウィンドウが開かれる。(Application-1-1)\
            または、「Firefoxは起動していますが応答しません。」というメッセージが出てFirefoxの新しいウィンドウが開かれない。(Application-1-3) 

3. Firefoxを終了する。 

4. {{start_menu_shortcut_path}}をダブルクリックしてFirefoxを起動する。   

5. その状態のまま、{{start_menu_shortcut_path}}をダブルクリックしてFirefoxの多重起動を試みる。   

    - 確認項目
          

        1. Firefoxの新しいウィンドウが開かれる。(Application-2-1)\
            または、「Firefoxは起動していますが応答しません。」というメッセージが出てFirefoxの新しいウィンドウが開かれない。(Application-2-3) 

## 3.4 ウィンドウ名の制御

- メインウィンドウのタイトルは{{window_title}}とする。 

### 3.4.1 確認する項目

- Application-4-\* 

- Application-5-\* 

### 3.4.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 3.4.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
      

2. タスクバー上に表示された項目にポインタを載せ、ジャンプリストを表示させる。
     

    - 確認項目
          

        1. 項目のタイトルが「{{window_title}}」で終わっている。
            （※確認できないときはスキップ）(Application-4-\*) 

        2. タスクバー上に指定のアイコンが表示されている。(Application-5-\*) 

3. 3で項目のタイトルを確認できない場合、Ctrl-Shift-ESCを押下し、タスクマネージャを起動して、「アプリケーション」タブを選択する。
     

    - 確認項目
          

        1. 項目のタイトルが「{{window_title}}」で終わっている。 (Application-4-\*) 

 

# 4 セキュリティに関わるカスタマイズ

## 4.1 証明書の自動インポート

### 4.1.1 確認する項目

- Security-1-1 

- Security-2-\* 

### 4.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 4.1.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. 「ツール」→「オプション」→「詳細」→「証明書」→「証明書を表示」ボタンから証明書マネージャを開く。 

    - 確認項目
          

        1. インポートするよう設定した証明書がすべて指定通りにインポートされている。
             (Security-1-1) 

3. インポートされた証明書をすべて削除する。  

4. Firefoxを再起動する。 

5. 「ツール」→「オプション」→「詳細」→「証明書」→「証明書を表示」ボタンから証明書マネージャを開く。 

    - 確認項目
          

        1. インポートするよう設定した証明書がすべて指定通りにインポートされている。
            (Security-2-1)\
            または、再インポートされていない。 (Security-2-2) 

## 4.2 アドオンの利用制限

### 4.2.1 確認する項目

- Security-3-3/4 

### 4.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. globalChrome.css 

3. Admin-4-1が選択されている場合はテストケースのunsigned-sample-addon@clear-code.com.xpiを、そうでなければ署名済みアドオンのインストールパッケージを用意する。 

### 4.2.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. Firefoxのウィンドウにアドオンのインストールパッケージをドラッグ&ドロップする。 

    - 確認項目 

        1. 「ソフトウェアのインストールはシステム管理者により無効化されています。」と表示され、アドオンがインストールされない。(Security-3-3/4) 

3. Security-3-4が選択されている場合、アドオンマネージャを開く。 

    - 確認項目 

        1. 「アドオン入手」が表示されない。(Security-3-4) 

        2. 歯車アイコンのポップアップメニュー内に「ファイルからアドオンをインストール」が含まれない。(Security-3-4) 

        3. 「拡張機能」タブが選択された状態で、アドオンマネージャ上にアドオンのインストールパッケージをドラッグ&ドロップして、アドオンがインストールされない。(Security-3-4) 

4. Security-3-3が選択されている場合、以下の各方法でアドオンマネージャへのアクセスを試みる。 

    - 確認項目
         

        1. パネルメニューに「アドオン」の項目が存在しない。
            (Security-3-3) 

        2. パネルメニュー内の「カスタマイズ」をクリックした後の「追加のツールと機能」の項目一覧に「アドオン」の項目が存在しない。
            (Security-3-3) 

        3. Alt-Tを押下して開いた「ツール」メニュー内に「アドオン」の項目が存在しない。
            (Security-3-3) 

        4. ロケーションバーに「about:addons」と入力し、Alt-Enterして、タブが開かれない（開かれてもすぐ閉じられる）。
            (Security-3-3) 

        5. ロケーションバーに「about:addons」と入力し、Enterして、何も起こらない（ページが読み込まれない）。
             (Security-3-3) 

        6. ロケーションバーに「about:about」と入力しEnterして「about:」一覧を表示する。 

        7. 「about:addons」
            のリンクを中クリックまたはCtrl-clickし、空白のページがタブで開かれるか、タブが開かれないか、タブが開かれてすぐに閉じられる。(Security-3-3) 

        8. 「about:addons」
            のリンクを左クリックし、空白のページが読み込まれる。
             (Security-3-3) 

5. 「 https://addons.mozilla.org 」を開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。 

    - 確認項目 

        1. 「サイト別設定」タブで「アドオンのインストール」において「標準設定を使用する」にチェックが入っている。(Security-3-3) 

6. 「 https://marketplace.firefox.com 」を開き、ページのコンテキストメニューから「ページの情報を表示」を選択して、「ページの情報」ダイアログを開く。 

    - 確認項目 

        1. 「サイト別設定」タブで「アドオンのインストール」において「標準設定を使用する」にチェックが入っている。(Security-3-3) 

### 4.2.4 後始末

1. 以下のアドオンを有効化する。 

    - globalChrome.css 

 

## 4.3 広告などのポップアップのブロック

### 4.3.1 確認する項目

1. Security-4-\* 

### 4.3.2 準備：

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    - カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 4.3.3 検証：

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. テストケースの「popupblock.html」を開く。 

    - 確認項目 

        1. ポップアップブロックの通知が表示される。(Security-4-1/2/4) 

            または、ポップアップブロックの通知が表示されずに、タブまたはウィンドウが開かれる。(Security-4-3) 

3. ポップアップの表示を許可するドメインのページを開く。 

    - 確認項目 

        1. ポップアップブロックの通知が表示されずに、タブまたはウィンドウが開かれる。(Security-4-2) 

## 4.4 攻撃サイトに対する警告

### 4.4.1 確認する項目

- Security-5-\* 

- Security-6-\* 

### 4.4.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 4.4.3 検証

1. Firefoxのロケーションバーに「 http://itisatrap.org/firefox/its-a-trap.html 」と入力し、Enterを押下する。
     

    - 確認項目 

        1. 偽装サイトとしてブロックされる。(Security-6-1)\
            または、ブロックされない。(Security-6-2) 

1. Firefoxのロケーションバーに「 https://itisatrap.org/firefox/its-an-attack.html 」と入力し、Enterを押下する。
     

    - 確認項目 

        1. 攻撃サイトとしてブロックされる。(Security-5-1)\
            または、ブロックされない。(Security-5-2) 

1. Firefoxのロケーションバーに「 http://itisatrap.org/firefox/unwanted.html 」と入力し、Enterを押下する。
     

    - 確認項目 

        1. 不要なソフトウェアの提供サイトとしてブロックされる。(Security-5-1)\
            または、ブロックされない。(Security-5-2) 

## 4.5 about:ページの利用制限

### 4.5.1 確認する項目

- Security-8-2 

- Security-9-2 

### 4.5.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    - カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. Disable
    About Somethingを用いて{{disabled_about_pages}}の使用を禁止しておく。 

### 4.5.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. 以下の各方法でabout:configへのアクセスを試みる。(Security-9-2) 

    1. 確認項目
         

        1. ロケーションバーに「about:config」と入力し、Alt-Enterして、タブが開かれない（開かれてもすぐ閉じられる）。
            (Security-9-2) 

        2. ロケーションバーに「about:config」と入力し、Enterして、何も起こらない（ページが読み込まれない）。
             (Security-9-2) 

        3. ロケーションバーに「about:about」と入力しEnterして「about:」一覧を表示する。 

        4. 「about:config」
            のリンクを中クリックまたはCtrl-clickし、空白のページがタブで開かれるか、タブが開かれないか、タブが開かれてすぐに閉じられる。(Security-9-2) 

        5. 「about:config」
            のリンクを左クリックし、空白のページが読み込まれる。  (Security-9-2) 

3. 以下の各方法で{{disabled_about_pages}}へのアクセスを試みる。(Security-8-2) 

    1. 確認項目
         

        1. ロケーションバーに「{{disabled_about_pages}}」と入力し、Alt-Enterして、タブが開かれない（開かれてもすぐ閉じられる）。
            (Security-8-2) 

        2. ロケーションバーに「{{disabled_about_pages}}」と入力し、Enterして、何も起こらない（ページが読み込まれない）。
             (Security-8-2) 

        3. ロケーションバーに「about:about」と入力しEnterして「about:」一覧を表示する。 

        4. 「{{disabled_about_pages}}」
            のリンクを中クリックまたはCtrl-clickし、空白のページがタブで開かれるか、タブが開かれないか、タブが開かれてすぐに閉じられる。(Security-8-2) 

        5. 「{{disabled_about_pages}}」
            のリンクを左クリックし、空白のページが読み込まれる。 (Security-8-2) 

## 4.6 エラーコンソールの利用制限

### 4.6.1 確認する項目

- Security-10-2 

### 4.6.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. globalChrome.css 

    2. UI Text Overrider 

### 4.6.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニュー内の「開発ツール」を開く。 

    - 確認項目 

        1. 「エラーコンソール」が存在しない。(Security-10-2) 

3. メニューバーの「ツール」から「Web開発」を開く。 

    - 確認項目 

        1. 「エラーコンソール」が存在しない。(Security-10-2) 

### 4.6.4 後始末：

1. 以下のアドオンを有効化する。 

    1. globalChrome.css 

    2. UI Text Overrider 

## 4.7 SNS連携機能とソーシャルAPIの利用制限

### 4.7.1 確認する項目

- Security-11-2 

### 4.7.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 4.7.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。 

    - 確認項目 

        1. 「このページを共有」ボタンが存在する。(Security-11-1)\
            または、存在しない。(Security-11-2) 

3. ロケーションバーに「 https://activations.cdn.mozilla.net/ja/ 」と入力し、Enterを押してページを開く。 

4. いずれかのサービスの「今すぐ追加」ボタンをクリックする。 

    - 確認項目 

        1. 何も起こらない。(Security-11-2) 

## 4.8 JavaScriptの実行制限

### 4.8.1 確認する項目

- Security-12-2/3 

### 4.8.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 4.8.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. テストケースの「popupblock.html」を開く。 

    - 確認項目 

        1. 何も起こらない。ポップアップブロックの通知も表示されない。(Security-12-2/3) 

3. JavaScriptの実行を許可するドメインのページを開く。(Security-12-2) 

    - 確認項目 

        1. ページ内のスクリプトが動作している（ポップアップブロックの通知が表示される）。(Security-12-2) 

 

## 4.9 ローカルファイルの読み込みの制限

### 4.9.1 確認する項目

- Security-14-\* 

### 4.9.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 4.9.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. テストケースの「cross-directory.html」を開く。 

    - 確認項目 

        1. 「./cross-directory.html: 200
            」および「../configuration-sheets/constumize-item-list.csv:
            200」の2つの出力が得られる。(Security-14-1)\
            または、「./cross-directory.html:
            200 」のみが得られもう片方はエラーが出力される。(Security-14-2) 

## 4.10 バックグラウンドで行われる通信の制限

### 4.10.1 確認する項目

- Security-5-2 

- Security-6-2 

- Security-11-2 

- Security-15-2 

- Privacy-33-3 

### 4.10.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. Firefoxのユーザープロファイル（{{special_profile_path}}）を削除する。 

3. 以下のアドオンを無効化する。 

    1. globalChrome.css 

    2. UI Text Overrider 

### 4.10.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「about:blank」と入力し、空のページを開く。 

3. パネルメニューの「開発ツール」→「開発ツールを表示」で開発ツールを表示する。 

4. 開発ツール右上の歯車アイコンをクリックする。 

5. 「ブラウザとアドオンのデバッガを有効」と「リモートデバッガを有効」にチェックを入れる。 

6. パネルメニューの「開発ツール」→「ブラウザツールボックス」でブラウザツールボックスを開く。途中、リモートデバッグの接続許可を求められるので「OK」をクリックする。 

7. ブラウザツールボックスで「ネットワーク」を選択する。 

8. ブラウザツールボックス内の「再読み込み」ボタンをクリックする。 

9. そのまま10分放置する。 

    - 確認項目 

        1. 一切のネットワーク通信が記録されない。(Security-5-2)(Security-6-2)(Security-15-2)(Privacy-33-3) 

### 4.10.4 後始末

1. 以下のアドオンを有効化する。 

    1. globalChrome.css 

    2. UI Text Overrider 

## 4.11 外部リソースへのアクセスの制限

### 4.11.1 確認する項目

- Security-18-2 

- Security-19-2 

- Privacy-28-2 

### 4.11.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. globalChrome.css 

    2. UI Text Overrider 

### 4.11.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニューからツールバーのカスタマイズ画面を開く。 

    - 確認項目 

        1. 「テーマ」内の「その他のテーマを入手」をクリックしても何も起こらない。(Security-18-2)(Privacy-28-2) 

        2. 「テーマ」内の「おすすめ」に何も項目が表示されない。(Security-19-2)(Privacy-28-2) 

3. パネルメニューの「開発ツール」→「WebIDE」でWebIDEを開く。 

4. メニューの「プロジェクト」→「追加のコンポーネントを管理」を開く。 

    - 確認項目 

        1. ツールアダプタアドオンが準備中になっている。(Privacy-28-2) 

5. ロケーションバーに「about:config」と入力し、詳細設定一覧を開いて、各設定値を確認する。 

    - 確認項目 

        1. 「browser.trackingprotection.gethashURL」の値が空文字である。(Privacy-28-2) 

        2. 「browser.trackingprotection.updateURL」の値が空文字である。(Privacy-28-2) 

        3. 「privacy.trackingprotection.introURL」の値が空文字である。(Privacy-28-2) 

        4. 「services.push.serverURL」の値が空文字である。(Privacy-28-2) 

### 4.11.4 後始末

2. 以下のアドオンを有効化する。 

    1. globalChrome.css 

    2. UI Text Overrider 

## 4.12 パーミッション設定の制限

### 4.12.1 確認する項目

- Security-20-2 

### 4.12.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 4.12.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「 https://addons.mozilla.org/ 」と入力し、ページを開く。 

3. ページの読み込みが完了したら、ロケーションバー上の鍵アイコンの箇所をクリックする。 

    - 確認項目 

        1. パネル上に「サイト別設定」が表示されない。(Security-20-2) 

        2. パネル右の「\>」をクリックした先の画面で「詳細を表示」ボタンが表示されない。(Security-20-2) 

4. ページ上のコンテキストメニューから「ページの情報を表示」を選択する。 

    - 確認項目 

        1. 「サイト別設定」タブが表示されない。(Security-20-2) 

 

# 5 プライバシー情報に関わるカスタマイズ

## 5.1 プライバシー情報の利用制限

### 5.1.1 確認する項目

- Privacy-1-2/3 

- Privacy-2-2 

- Privacy-3-\* 

- Privacy-4-2 

- Privacy-5-2 

- Privacy-6-3 

- Privacy-7-\* 

- Privacy-8-2 

- Privacy-10-2 

- Privacy-12-\* 

- Privacy-15-2 

- Privacy-16-\* 

- Privacy-17-\* 

- Privacy-18-2 

- Privacy-19-2 

- Privacy-20-3/4 

- Privacy-21-2 

- Privacy-31-2 

- Privacy-33-2/3 

- Privacy-35-\* 

### 5.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable about:config 

    2. globalChrome.css 

    3. UI Text Overrider 

### 5.1.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。\
    Privacy-35-\*の検証を行う場合は、ショートカットから起動する代わりに以下の手順で起動する。 

    -   1. cmd.exeを起動し、コマンドプロンプトを開く。 

        2. 以下の3つのコマンド列を実行する。 

            1. set NSPR\_LOG\_MODULES=nsHttp:5 

            2. set NSPR\_LOG\_FILE=(ユーザのホームのフルパス)\\http.log 

            3. {{desktop_shortcut_path}}
                のリンク先と同じコマンド列を実行する。 

2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

3. オプション画面の「プライバシー」を開く。
     

    - 確認項目
         

        1. 「トラッキング」で「サイトにトラッキングしないよう要求する（トラッキングの拒否をサイトに通知する）」のチェックが外れている。 (Privacy-20-3/4) 

        2. 「履歴」で「Firefoxに履歴を記憶させる」が選択されているか、「記憶させる履歴を詳細設定」で「常にプライベートブラウジングモード」のチェックが外れていて選択不可になっている。(Privacy-1-2)\
            または、「Firefoxに履歴を一切記憶させない」が選択されているか「記憶させる履歴を詳細設定」で「常にプライベートブラウジングモード」のチェックが入っていて選択不可になっている。(Privacy-1-3) 

4. オプション画面の「詳細」→「ネットワーク」を開く。 

    - 確認項目 

        1. 「Webサイトがオフライン作業用のデータの保存を求めてきたときに知らせる」のチェックが外れていて選択不可になっている。(Privacy-6-3) 

5. オプション画面の「詳細」の「データの選択」を開く。 

    - 確認項目 

        1. 「Firefoxヘルスレポートを有効にする」のチェックが外れている。(Privacy-18-2) 

        2. 「追加データを共有する（パフォーマンス情報など）」のチェックが外れている。(Privacy-18-2) 

        3. 「クラッシュレポートの送信を有効にする」のチェックが外れている。(Privacy-21-2) 

6. テストケースの「password.html」を開く。 

7. ユーザID、パスワードを入力して送信する。 

    - 確認項目 

        1. パスワードの保存を尋ねられない。(Privacy-5-2) 

        2. ファイルを再読み込みしてもパスワードが自動入力されない。(Privacy-5-2) 

        3. ユーザID入力欄をダブルクリックしても入力履歴が表示されない。(Privacy-2-2) 

8. ファイルに名前を付けて保存し、Firefoxを再起動する。(Privacy-3-2) 

    - 確認項目 

        1. 「履歴」→「すべての履歴を表示」で「ダウンロード」の一覧に項目が存在する。(Privacy-3-1)\
            または、存在しない。(Privacy-3-2) 

9. ロケーションバーに「password」と入力する。(Privacy-4-2) 

    - 確認項目 

        1. ロケーションバーのオートコンプリートの項目が表示されない。(Privacy-4-2) 

10. ロケーションバーに「about:config」と入力し、詳細設定一覧を開く。 

11. 各設定値を確認する。 

    - 確認項目 

        1. 「places.history.expiration.max\_pages」の値が「{{history_expiration_max_pages}}」である。(Privacy-8-2) 

        2. 「dom.storage.enabled」の値が「true」である。(Privacy-12-1)\
            または、「false」である。(Privacy-12-2) 

        3. 「browser.search.geoip.url」の値が空文字である。(Privacy-15-2) 

        4. 「security.ssl.errorReporting.automatic」の値が「false」である。(Privacy-19-2) 

        5. 「security.ssl.errorReporting.enabled」の値が「false」である。(Privacy-19-2) 

        6. 「security.ssl.errorReporting.url」の値が空文字である。(Privacy-19-2) 

        7. 「browser.selfsupport.url」の値が空文字である。(Privacy-31-2) 

        8. 「privacy.trackingprotection.enabled」の値が「true」である。(Privacy-33-2)\
            または、「false」である。(Privacy-33-3) 

        9. 「privacy.trackingprotection.pbmode.enabled」の値が「true」である。(Privacy-33-2)\
            または、「false」である。(Privacy-33-3) 

1. .以下の設定を行う。既存の値がない場合は新規に作成する。 

    - 「network.dns.notifyResolution」（真偽型）を「true」に設定する。 

    - 「devtools.chrome.enabled」（真偽型）を「true」に設定する。 

1. .パネルメニューを開き、パネルメニュー内の「開発ツール」をクリックして、サブメニューの「ブラウザコンソール」をクリックする。
     

14. ブラウザコンソールを「ネットワーク」にチェックが入った状態にする。 

15. ブラウザコンソール下部の入力欄で以下のコードを実行する。 

    - Services.obs.addObserver(function(aSubject, aTopic, aData) { console.log(aTopic+': '+aData); }, 'dns-resolution-request', false); 

16. ブラウザウィンドウで「 http://www.clear-code.com/blog/2016/5/10.html 」を開く。 

    - 確認項目 

        1. 「GET http://www.clear-code.com/blog/2016/5/18.html 」というログがコンソールに出力される。(Privacy-7-1)\
            または、出力されない。(Privacy-7-2) 

17. ブラウザウィンドウでテストケースの「prefetching.html」を開く。 

    - 確認項目 

        1. 「dns-resolution-request:
            dns-prefetch.example.com」というログがブラウザコンソールに出力される。(Privacy-16-1)\
            または、出力されない。(Privacy-16-2) 

18. ブラウザコンソールを閉じる。 

19. ロケーションバーに「about:」と入力し、Alt-Enterでタブとして開く。 

20. 開かれたタブを閉じる。 

21. ロケーションバーに「about:」と入力し、Alt-Enterでタブとして開く。 

22. 開かれたタブをドラッグしてウィンドウ外にドロップし、ウィンドウとして開く。 

23. 開かれたウィンドウを閉じる。 

24. 「履歴」メニューを開く。 

    - 確認項目 

        1. 「最近閉じたタブ」が表示されない。(Privacy-10-2) 

        2. 「最近閉じたウィンドウ」が表示されない。(Privacy-10-2) 

25. ツールバー上の検索窓にフォーカスし「a」と入力する。 

    - 確認項目 

        1. 「a」の補完候補が表示される。(Privacy-17-1)\
            または、表示されない。(Privacy-17-2) 

26. ツールバー上の検索窓の虫眼鏡のアイコンをクリックし、ポップアップ表示されたパネルの最下部の「検索設定を変更」をクリックする。 

27. 開かれた設定画面の「既定の検索エンジン」欄を見る。 

    - 確認項目 

        1. 「検索候補を使用する」にチェックが入っていて選択不可になっている。(Privacy-17-1)\
            または、チェックが外れていて選択不可になっている。(Privacy-17-2) 

        2. 「ロケーションバーに検索候補を表示する」にチェックが入っていて選択不可になっている。(Privacy-17-1)\
            または、チェックが外れていて選択不可になっている。(Privacy-17-2) 

28. Firefoxを終了し、以下のアドオンを有効化する。 

    - globalChrome.css 

29. Firefoxを起動し、ツールバー上の検索窓の虫眼鏡のアイコンをクリックし、ポップアップ表示されたパネルの最下部の「検索設定を変更」をクリックする。 

30. 開かれた設定画面の「既定の検索エンジン」欄を見る。 

    - 確認項目 

        1. 「検索候補を使用する」が表示されていない。(Privacy-17-2) 

        2. 「ロケーションバーに検索候補を表示する」が表示されていない。(Privacy-17-2) 

31. 「プライバシー」ペインを選択する。 

    - 確認項目 

        1. 「常にプライベートブラウジングモード」が表示されていない。(Privacy-1-2) 

        2. 「プライベートウィンドウでサイトによるトラッキングをブロックする」が表示されていない。(Privacy-33-3) 

        3. 「検索エンジンの検索候補の設定を変更」が表示されていない。(Privacy-17-2) 

32. Firefoxを終了する。 

33. (ユーザのホームのフルパス)\\http.log
    の位置に出力されているログファイルを開く。 

    - 確認項目 

        1. ログ中に現れる「nsHttpConnectionMgr::OnMsgSpeculativeConnect」と「Transport
            not created due to existing connection count」の登場回数のうち、後者の方が顕著に多い。（Privacy-35-1）\
            または、両者の登場回数が等しい。（Privacy-35-2） 

### 5.1.4 後始末

1. about:configで以下の設定をリセットする。 

    1. 「network.dns.notifyResolution」（真偽型） 

    2. 「devtools.chrome.enabled」（真偽型） 

2. 以下のアドオンを有効化する。 

    1. Disable about:config 

    2. globalChrome.css 

    3. UI Text Overrider 

## 5.2 履歴の保存日数の制御

- 当日を含めず5日前までの履歴を保存するものとする。 

### 5.2.1 確認する項目

- Privacy-9-1 

### 5.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable
        Addons 

    2. Disable about:config 

3. 十分な日数分の履歴項目を以下の手順で用意する。 

    1. Windowsが仮想環境である場合、ホストマシンとの日付・時刻の同期を停止する。（例えば、VirtualBoxであればタスクマネージャを開いて「サービス」→「サービス」で「VirtualBox
        Guest Addition」を停止する。） 

    2. Windowsのタスクバーの時計を右クリックし、「日付と時刻の調整」を選択する。 

    3. 「日付と時刻」ダイアログが開かれるので、「インターネット時刻」タブで「設定の変更」ボタンをクリックし、「インターネット時刻サーバーと同期する」のチェックを外す。（※要：管理者権限） 

    4. 「日付と時刻」タブで「日付と時刻の変更」ボタンをクリックする。（※要：管理者権限） 

    5. 「日付と時刻の設定」ダイアログが開かれるので、カレンダー上で日付を5＋2日以上前の日付に変更し、「OK」をクリックしてダイアログを閉じる。 

    6. Firefox上で何らかのWebページを開き、リンクを辿ってページを遷移する。 

    7. 2から4の操作を、設定する日付を1日ずつ進めながら繰り返す。 

### 5.2.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニューを開き、「アドオン」をクリックする。
     

3. アドオンマネージャ内の「拡張機能」をクリックする。 

    1. 確認項目
         

        1. 拡張機能の一覧に「Flexible
            Expire History by Days」が表示されており、有効になっている。(Privacy-9-1) 

4. {{expire_history_by_days_version}}の設定画面を開く。 

    1. 確認項目 

        1. 「Expire
            visits older than these days」の値が「5」である。(Privacy-9-1) 

        2. 「Frequency of expiration」で「On the first
            idle time per a day」が選択されている。(Privacy-9-1) 

5. Firefoxのロケーションバーに「about:config」と入力し、ページを開く。 

6.  「検索」欄に「idle.lastDailyNotification」と入力し、Enterを押下する。  

7. 項目が見つかった場合、項目を右クリックしてメニューから「リセット」を選択する。 

8. Firefoxを終了する。 

9. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

10. メニューバーの「履歴」から「すべての履歴」を選択し、「履歴とブックマークの管理」ウィンドウを開く（すべての履歴項目を表示した状態にする）。 

11. 「履歴」配下の「7日以内」、「（前月）月」、または指定の履歴保存期間のしきい値となる日付が含まれる期間を選択する。 

12. 履歴一覧のカラム列を右クリックし、「最近表示した日時」にチェックを入れる。 

    1. 確認項目 

        1. 当日までの日付の履歴項目が並んでいる。 

13. マウスとキーボードから手を離し、4分以上、何も操作せずに放置する。 

    1. 確認項目 

        1. 前日を含めて過去5日間の履歴が残っており、それよりも古い履歴項目が残っていない。(Privacy-9-1) 

### 5.2.4 後始末

1. Windowsが仮想環境である場合、ホストマシンとの日付・時刻の同期を再開する。（例えば、VirtualBoxであればタスクマネージャを開いて「サービス」→「サービス」で「VirtualBox
    Guest Addition」を開始する。） 

2. Windowsのタスクバーの時計を右クリックし、「日付と時刻の調整」を選択する。 

3. 「日付と時刻」ダイアログが開かれるので、「インターネット時刻」タブで「設定の変更」ボタンをクリックし、「インターネット時刻サーバーと同期する」のチェックを入れる。（※要：管理者権限） 

4. 以下のアドオンを有効化する。 

    1. Disable Addons 

    2. Disable about:config 

## 5.3 位置情報の利用制限

### 5.3.1 確認する項目

- Privacy-14-3 

### 5.3.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 5.3.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「 https://developer.mozilla.org/ja/docs/WebAPI/Using\_geolocation 」と入力し、ページを開く。 

3. 「Geolocationのライブサンプル」欄の「Show
    my location」ボタンをクリックする。 

    - 確認項目 

        1. 何も表示されないか、「Geolocation is not supported by your
            browser」というエラーメッセージが表示される。(Privacy-14-3) 

## 5.4 Firefox Syncの利用制限

### 5.4.1 確認する項目

- Privacy-22-2 

### 5.4.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 5.4.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

    - 確認項目 

        1. 「Sync」の項目が存在しない。(Privacy-22-2) 

3. 「ツール」メニューを開く。 

    - 確認項目 

        1. 「Syncにログイン」が存在しない。(Privacy-22-2) 

4. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。 

    - 確認項目 

        1. 「Sync」が存在しない。(Privacy-22-2) 

        2. 「Syncにサインイン」が存在しない。(Privacy-22-2) 

5. 以下の各方法でabout:accountsへのアクセスを試みる。 

    - 確認項目
         

        1. ロケーションバーに「about:accounts」と入力し、Alt-Enterして、タブが開かれない（開かれてもすぐ閉じられる）。
            (Privacy-22-2) 

        2. ロケーションバーに「about:accounts」と入力し、Enterして、何も起こらない（ページが読み込まれない）。
             (Privacy-22-2) 

        3. ロケーションバーに「about:about」と入力しEnterして「about:」一覧を表示する。 

        4. 「about:accounts」
            のリンクを中クリックまたはCtrl-clickし、空白のページがタブで開かれるか、タブが開かれないか、タブが開かれてすぐに閉じられる。(Privacy-22-2) 

        5. 「about:accounts」
            のリンクを左クリックし、空白のページが読み込まれる。(Privacy-22-2) 

## 5.5 Firefox Accountsの利用制限

### 5.5.1 確認する項目

- Privacy-24-2 

### 5.5.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable
        Sync 

### 5.5.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「about:accounts」と入力し、ページを開く。 

3. 「始める」をクリックする。 

    - 確認項目
         

        1. 画面が空白になり、アカウント登録の画面に遷移しない。
            (Privacy-24-2) 

### 5.5.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable Sync 

## 5.6 プライバシーに関わる機能の利用制限

### 5.6.1 確認する項目

- Privacy-25-2 

- Privacy-26-2 

- Privacy-27-2 

### 5.6.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 5.6.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。 

    - 確認項目 

        1. 「Hello」が存在しない。(Privacy-25-2) 

        2. 「忘れる」が存在しない。(Privacy-26-2) 

        3. 「Pocket」が存在しない。(Privacy-27-2) 

3. メニューバーの「ツール」メニューを開く。 

    - 確認項目 

        1. 「通話を開始」が存在しない。(Privacy-25-2) 

## 5.7 アイドル状態での履歴・ブックマーク用データベースの自動最適化

### 5.7.1 確認する項目

- Privacy-29-2 

### 5.7.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable about:config 

    2. globalChrome.css 

    3. UI Text Overrider 

### 5.7.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. Firefoxのロケーションバーに「about:config」と入力し、ページを開く。 

3. リスト領域を右クリックしてメニューから「新規作成」→整数値を選択し、設定名「idle.lastDailyNotification」、値「0」で設定項目を登録する。 

4. リスト領域を右クリックしてメニューから「新規作成」→整数値を選択し、設定名「 places.database.lastMaintenance 」、値「0」で設定項目を登録する。 

5. Firefoxを終了する。 

6. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

7. パネルメニューを開き、パネルメニュー内の「開発ツール」をクリックして、サブメニューの「ブラウザコンソール」をクリックする。
     

8. キーボード、マウスから手を離し、4分以上待つ。 

9. ブラウザコンソールの内容を確認する。 

    - 確認項目
         

        1. 以下のメッセージがすべて出力される。(Privacy-29-2) 

            1. 「PlacesDBUtils.maintenanceOnIdle()
                is called and redirected to
                checkAndFixDatabase().」 

            2. 「PlacesDBUtils.checkAndFixDatabase()
                successfully finished.」 

            3. 「Array
                [ ... ]」 

        2. 「Array
            [ ... ]」と表示されたメッセージの中に、「\>
            Vacuum」という内容が含まれている。(Privacy-29-2) 

### 5.7.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable about:config 

    2. globalChrome.css 

    3. UI Text Overrider 

## 5.8 ディスクキャッシュのサイズ制限

- 制限する最大サイズは{{max_cache_size}}MBとする。 

### 5.8.1 確認する項目

- Privacy-30-2 

### 5.8.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 5.8.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

3. オプション画面の「詳細」→「ネットワーク」を開く。
     

    1. 確認項目
         

        1. 「キャッシュサイズを制限する」にチェックが入っていて、選択不可になっている。(Privacy-30-2) 

        2. 「ページキャッシュとして{{max_cache_size}}MBまで使用する」と表示されている。(Privacy-30-2) 

# 6 Webブラウズ機能に関するカスタマイズ

## 6.1 検索エンジンの制限

### 6.1.1 確認する項目

- Websearch-1-\* 

- Websearch-2-2 

### 6.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 6.1.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「 https://addons.mozilla.org/ 」と入力し、ページを開く。 

3. Web検索バーのアイコンをクリックする。 

    - 確認項目 

        1. Web検索バーのアイコンに「+」のバッジが表示される。(Websearch-1-1)\
            または、バッジが表示されない。(Websearch-1-2) 

        2. パネル上に「”Firefoxアドオン”を追加」という項目が表示される。(Websearch-1-1)\
            または、表示されない。(Websearch-1-2) 

        3. パネル上に、無効にした検索エンジンが表れていない。(Websearch-2-2) 

4. パネル下部の「検索設定を変更」をクリックする。(Websearch-2-2) 

    - 確認項目 

    -   1. 「既定の検索エンジン」のドロップダウンリストに、無効にした検索エンジンが表れていない。(Websearch-2-2) 

        2. 「ワンクリック検索エンジン」のリストに、無効にした検索エンジンが表れていない。(Websearch-2-2) 

## 6.2 ロケーションバーの表示の制御

### 6.2.1 確認する項目

- Location-1-\* 

### 6.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 6.2.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「 http://www.clear-code.com/ 」のように「 http:// 」で始まるURLを入力し、ページを開く。 

    - 確認項目 

        1. ロケーションバーのURL表記に「http://」が含まれている。(Location-1-2)\
            または、含まれていない。(Location-1-1) 

## 6.3 ダウンロードに関する機能の制御

### 6.3.1 確認する項目

- Download-1-\* 

- Download-2-\* 

- Download-3-\* 

### 6.3.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. Firefoxのユーザープロファイル（{{special_profile_path}}）を削除する。 

3. 既定のダウンロード先「{{download_dir}}」を用意しておく。用意できない場合は、Download-2−1の参照先を「C:\\」などの実在するパスに変更し、以下の説明も読み替える。 

### 6.3.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。 

    - 確認項目 

        1. 「ダウンロード」が存在する。(Download-1-1)\
            または、存在しない。(Download-1-2) 

3. ロケーションバーに「[http://www.clear-code.com/](http://www.clear-code.com/)」と入力し、ページを開く。 

4. Webページ中の任意のリンクを右クリックし、「名前を付けてリンク先を保存」を選択する。 

    - 確認項目 

        1. ダウンロード先として{{download_dir}}が選択された状態でファイル選択ダイアログが開かれる。(Download-2-1/2)\
            または、ホームディレクトリ内の「ダウンロード」が選択された状態でファイル選択ダイアログが開かれる。(Download-2-3) 

5. 「subfolder」という名前でフォルダを作成し、そのフォルダを選択してダウンロードを開始する。 

    - 確認項目 

        1. ダウンロードの進行状況を示すポップアップが表示される。(Download-1-1)\
            または、表示されない。(Download-1-2) 

6. ロケーションバーに「 http://www.mozilla.org/ 」と入力し、ページを開く。 

7. Webページ中の任意のリンクを右クリックし、「名前を付けてリンク先を保存」を選択する。 

    - 確認項目 

        1. ダウンロード先として{{download_dir}}内の「subfolder」が選択された状態でファイル選択ダイアログが開かれる。(Download-3-1)\
            または、{{download_dir}}が選択された状態でファイル選択ダイアログが開かれる。(Download-3-2) 

8. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

9. オプション画面の「一般」を開く。
     

    - 確認項目
         

        1. 「ダウンロード」は「次のフォルダに保存する」が選択されている。(Download-3-\*) 

        2. ダウンロード先として{{download_dir}}内の「subfolder」が表示されている。(Download-3-1)\
            または、{{download_dir}}が表示されている。(Download-3-2) 

## 6.4 タブの操作に関する機能の制御

### 6.4.1 確認する項目

- Tab-1-\* 

- Tab-2-\* 

- Tab-3-\* 

- Tab-5-\* 

- Tab-7-\* 

### 6.4.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. テストケース「links.html」を用意する。 

3. 以下のアドオンを無効化する。 

    1. Disable about:config 

### 6.4.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. 新しいウィンドウを開く。 

3. 新しいウィンドウ内で新しいタブを2つ以上開く。 

4. ウィンドウを閉じる操作を行う。 

    - 確認項目 

        1. 複数のタブを閉じてよいかどうか確認される。(Tab-1-1)\
            または、確認されない。(Tab-1-2/3) 

5. タブを1つ選択し、右クリックして「他のタブをすべて閉じる」を選択する。 

    - 確認項目 

        1. 複数のタブを閉じてよいかどうか確認される。(Tab-2-1)\
            または、確認されない。(Tab-2-2/3) 

6. テストケースの「links.html」を開く。リンクからタブを開き、15以上のタブが開かれた状態にする。 

7. タブの上で右クリックし、メニューから「すべてのタブをブックマーク」を選択する。 

8. フォルダ名を任意に指定し、ブックマークフォルダとして保存する。 

9. メニューバーの「ブックマーク」から前の操作で作成されたブックマークフォルダを選択し、最下部の「タブですべて開く」を選択する。 

    - 確認項目 

        1. 一度に複数のタブを開いてよいかどうか確認される。(Tab-3-1)\
            または、確認されない。(Tab-3-2/3) 

10. タブバー上の「+」ボタンをクリックして新しいタブを開く。またはパネルメニューを開き、パネルメニュー内の「新しいウィンドウ」をクリックする。 

    - 確認項目 

        1. 右上に歯車アイコンのある空白ページが表示される。(Tab-5-1)(Tab-7-2)\
            または、右上に歯車アイコンのない空白ページが表示される。(Tab-5-2)\
            または、タイルが表示される。(Tab-7-1/3/4/5) 

        2. タイルの中に未訪問のページが含まれる。(Tab-7-4)\
            または、既訪問のページのみが表示される。(Tab-7-3/5) 

11. 新しいタブ内の歯車ボタンをクリックする。 

    - 確認項目 

        1. 「よく見るサイトを表示」が表示されない。(Tab-7-2)\
            または、「空白ページを表示」が表示されない。(Tab-7-3/4) 

        2. 「おすすめサイトも表示」が表示される。(Tab-7-1/4)\
            または、表示されない。(Tab-7-2/3/5) 

12. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

13. オプション画面の「一般」を開く。
     

    - 確認項目
         

        1. 「タブグループ」配下に「同時に複数のタブを閉じるときは確認する」のチェックボックスがOFFの状態で表示されている。(Tab-1-3) 

        2. 「タブグループ」配下に「同時に複数のタブを開いて Firefox
            の動作が遅くなるときは確認する」のチェックボックスがOFFの状態で表示されている。(Tab-3-3) 

14. ロケーションバーに「about:config」と入力し、詳細設定一覧を開いて、各設定値を確認する。 

    - 確認項目 

        1. 「browser.tabs.warnOnCloseOtherTabs」の値がユーザー設定値の「false」である。(Tab-2-3) 

### 6.4.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable about:config 

## 6.5 内蔵PDFビューアの使用

### 6.5.1 確認する項目

- Ui-1-\* 

### 6.5.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. globalChrome.css 

### 6.5.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

3. オプション画面の「プログラム」を開く。
     

    - 確認項目 

        1. ファイルの種類「PDF文書（PDF）」（「Adobe Acrobat
            Document」）の取り扱い方法が「Firefoxでプレビュー表示」となっている。(Ui-1-1)\
            または、選択肢に「Firefoxでプレビュー表示」が存在しない。(Ui-1-2) 

### 6.5.4 後始末

1. 以下のアドオンを有効化する。 

    1. globalChrome.css 

## 6.6 タブの音声出力インジケータの使用

### 6.6.1 確認する項目

- Ui-3-\* 

### 6.6.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 6.6.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「 https://www.youtube.com 」と入力し、ページを開く。 

3. いずれか1つの動画を開く。
     

    - 確認項目 

        1. タブ内にスピーカーのアイコンが表示される。(Ui-3-1)\
            または、表示されない。(Ui-3-2) 

        2. タブを「ピン留め」した状態で、タブのアイコンにスピーカーのバッジが表示される。(Ui-3-1)\
            または、表示されない。(Ui-3-2) 

## 6.7 認証プロンプトの重複表示の抑止

### 6.7.1 確認する項目

- Ui-4-1 

### 6.7.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 外部の埋め込みリソースを2つ以上埋め込んだWebページ（例： http://www.clear-code.com/blog/ ）をホームページに設定する。ホームページを変更できない場合はスキップする。 

3. ユーザー名とパスワードによる認証が必要なHTTP
    Proxyを用意する。既存のProxyが無い場合は、以下に示す設定例に従い用意する。 

    1. 検証器が到達可能なネットワーク上に、Ubuntu
        14.04LTSがセットアップされたホストを用意する。仮に、IPアドレスは{{proxy_host}}であるとする。 

    2. 以下のコマンド列を順に実行し、Apacheをインストールする。 

        1. sudo
            apt-get install apache2 apache2-utils 

        2. sudo
            a2enmod proxy\_http 

        3. sudo
            a2enmod proxy\_connect 

    3. 以下のコマンド列を実行し、認証用のユーザー名（ここでは仮に「{{proxy_auth_user}}」とする）とパスワードを設定する。 

        1. sudo
            htpasswd -c /etc/apache2/.htpasswd {{proxy_auth_user}} 

    4. /etc/apache2/conf-enabled/forward\_proxy.confの位置に以下の内容でファイルを作成する。 

            ProxyRequests On
            ProxyVia On

            <Proxy *>
              AuthType Basic
              AuthName "Password Required"
              AuthUserFile /etc/apache2/.htpasswd
              Require user {{proxy_auth_user}}
            </Proxy>

    5. 以下のコマンド列を実行し、Apacheを再起動する。 

        1. sudo
            service apache2 restart 

4. Network-2-2の設定を使用し、認証が必要なHTTP
    Proxyを使用するよう設定する。上記の例に従い用意したProxyの場合、設定は以下のようになる。 

        lockPref("network.proxy.type", 1);
        lockPref("network.proxy.http", "{{proxy_host}}");
        lockPref("network.proxy.http\_port", 80);
        lockPref("network.proxy.share\_proxy\_settings", true);

### 6.7.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ホームページまたは外部の埋め込みリソースを2つ以上埋め込んだWebページ（例： http://www.clear-code.com/blog/ ）を訪問し、ファイルがキャッシュされた状態にする。 

3. Firefoxを終了し、もう一度起動する。 

    - 検証項目 

        1. HTTP
            Proxyの認証プロンプトが表示される。(Ui-4-1) 

        2. 1つの認証プロンプトで認証した後2つ目以降の認証プロンプトの入力を求められない。(Ui-4-1) 

### 6.7.4 後始末

1. Network-2-2の設定を元に戻す。 

2. 用意したHTTP
    Proxyを停止する。 

## 6.8 その他のWebアプリ向けAPIの使用制限

### 6.8.1 確認する項目

- Script-2-\* 

- Script-3-\* 

### 6.8.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable about:config 

### 6.8.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「 https://labs.othersight.jp/webpushtest/ 」と入力し、ページを開く。 

    - 確認項目 

        1. ページ内に「Service
            Worker not available」と表示されている。(Script-2-3) 

3. ロケーションバーに「about:config」と入力し、詳細設定一覧を開いて、各設定値を確認する。 

    - 確認項目 

        1. 「dom.push.enabled」の値が「true」である。(Script-2-1/2)\
            または、「false」である。(Script-2-3) 

        2. 「dom.serviceWorkers.enabled」の値が「true」である。(Script-2-1/2)\
            または、「false」である。(Script-2-3) 

        3. 「dom.gamepad.enabled」の値が「true」である。(Script-3-1)\
            または、「false」である。(Script-3-2) 

### 6.8.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable about:config 

## 6.9 ハードウェアアクセラレーションの使用

### 6.9.1 確認する項目

- Stability-1-\* 

### 6.9.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. globalChrome.css 

### 6.9.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

3. オプション画面の「詳細」→「一般」を開く。
     

    - 確認項目 

        1. 「ハードウェアアクセラレーション機能を使用する」にチェックが入っている。(Stability-1-1)\
            または、チェックが入っていない。(Stability-1-2) 

### 6.9.4 後始末

1. 以下のアドオンを有効化する。 

    1. globalChrome.css 

# 7 ネットワーク処理に関するカスタマイズ

## 7.1 プロキシの設定

### 7.1.1 確認する項目

- Network-2-\* 

### 7.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. globalChrome.css 

### 7.1.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

3. オプション画面の「詳細」→「ネットワーク」→「接続」→「接続設定」を開く。
     

    - 確認項目
         

        1. 「プロキシを使用しない」が選択されている。(Network-2-1)\
            または、「手動でプロキシを設定する」が選択されている。(Network-2-2)\
            または、「自動プロキシ設定スクリプトURL」が選択されている。(Network-2-3)\
            または、「このネットワークのプロキシ設定を自動検出する」が選択されている。(Network-2-4)\
            または、「システムのプロキシ設定を利用する」が選択されている。(Network-2-5) 

        2. 各プロキシが指定通りに設定されている。(Network-2-2) 

        3. 「自動プロキシ設定スクリプトURL」の欄に「{{home_page}}?/proxy.pac」と入力されている。(Network-2-3) 

### 7.1.4 後始末

1. 以下のアドオンを有効化する。 

    1. globalChrome.css 

## 7.2 その他のネットワーク関連設定

### 7.2.1 確認する項目

- Network-1-1 

- Network-4-1 

- Network-5-2 

- Network-6-\* 

- Network-7-\* 

### 7.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable about:config 

### 7.2.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「about:config」と入力し、詳細設定一覧を開いて、各設定値を確認する。 

    - 確認項目 

        1. 「general.useragent.extra.microsoftdotnet」が項目として存在しない、もしくは、値が未定義である。(Network-1-1) 

        2. 「network.automatic-ntlm-auth.trusted-uris」の値が「{{ntlm_single_signon_hosts}}」である。(Network-4-1) 

        3. 「network.http.max-connections」の値が6である。(Network-5-2) 

        4. 「network.http.max-persistent-connections-per-server」の値が2である。(Network-5-2) 

        5. 「network.http.max-persistent-connections-per-proxy」の値が2である。(Network-5-2) 

        6. 「network.http.spdy.enabled」の値が「true」である。(Network-6-1)\
            または、「false」である。(Network-6-2) 

        7. 「security.tls.insecure\_fallback\_hosts」の値が未設定または空文字である。(Network-7-1) 

            または、「{{ntlm_single_signon_hosts}}」である。(Network-7-2) 

### 7.2.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable about:config 

# 8 自動更新のカスタマイズ

## 8.1 Firefoxおよびアドオンの自動更新の制限

### 8.1.1 確認する項目

- Update-1-3 

- Update-2-2 

- Update-3-2 

### 8.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable about:config 

### 8.1.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2.  「ヘルプ」→「Firefoxについて」を開く。   

    1. 確認項目
         

        1. 「ソフトウェアの更新」が表示されない。(Update-1-3) 

3. ロケーションバーに「about:config」と入力し、詳細設定一覧を開いて、各設定値を確認する。 

    1. 確認項目 

        1. 「app.update.enabled」の値が「false」である。(Update-1-3) 

        2. 「app.update.mode」の値が「0」である。(Update-1-3) 

        3. 「extensions.update.enabled」の値が「false」である。(Update-2-2) 

        4. 「browser.search.update」の値が「false」である。(Update-3-2) 

### 8.1.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable about:config 

 

# 9 プラグインと外部アプリケーションのカスタマイズ

## 9.1 プラグインの制御

### 9.1.1 確認する項目

- Plugin-1-\* 

- Plugin-2-\* 

- Plugin-3-\* 

- Plugin-4-\* 

- Plugin-5-\* 

- Plugin-6-\* 

- Plugin-7-\* 

- Plugin-8-\* 

### 9.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 「 {{java_download_url}} 」からJavaプラグインのインストーラをダウンロードし、インストールしておく。(Plugin-1-\*) 

3. 「 {{flash_download_url}} 」からAdobe Flash
    プラグインのインストーラをダウンロードし、インストールしておく。(Plugin-2-\*) 

4. 「 {{acrobat__download_url}} 」からAdobe Acrobat Reader
    プラグインのインストーラをダウンロードし、インストールしておく。(Plugin-3-\*) 

5. 「 {{shockwave__download_url}} 」からAdobe Shockwave
    プラグインのインストーラをダウンロードし、インストールしておく。(Plugin-4-\*) 

6. 「[SilverlightDownloadUrl]({{silverlight_download_url}})」からSilverlight
    プラグインのインストーラをダウンロードし、インストールしておく。(Plugin-5-\*) 

7. 「 {{wmp__download_url}} 」からWindows
    Media Playerプラグインをダウンロードし、インストールしておく。(Plugin-6-\*) 

8. Cisco
    WebExプラグインを入手し、インストールしておく。（※メタインストーラにnpatgpc.dllを含めているときはスキップ）(Plugin-7-\*) 

9. 以下のアドオンを無効化する。 

    1. Disable
        Addons 

### 9.1.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. アドオンマネージャを開き、「プラグイン」を選択する。 

    - 確認項目 

        1. Javaプラグインの項目が表示されており、「無効化する」が選択されている。(Plugin-1-1)\
            または、「常に有効化する」が選択されている。(Plugin-1-2)\
            または、「実行時に確認する」が選択されている。(Plugin-1-3) 

        2. Adobe Flashプラグインの項目が表示されており、「無効化する」が選択されている。(Plugin-2-1)\
            または、「常に有効化する」が選択されている。(Plugin-2-2)\
            または、「実行時に確認する」が選択されている。(Plugin-2-3) 

        3. Adobe Readerプラグインの項目が表示されており、「無効化する」が選択されている。(Plugin-3-1)\
            または、「常に有効化する」が選択されている。(Plugin-3-2)\
            または、「実行時に確認する」が選択されている。(Plugin-3-3) 

        4. Adobe Shockwaveプラグインの項目が表示されており、「無効化する」が選択されている。(Plugin-4-1)\
            または、「常に有効化する」が選択されている。(Plugin-4-2)\
            または、「実行時に確認する」が選択されている。(Plugin-4-3) 

        5. Silverlightプラグインの項目が表示されており、「無効化する」が選択されている。(Plugin-5-1)\
            または、「常に有効化する」が選択されている。(Plugin-5-2)\
            または、「実行時に確認する」が選択されている。(Plugin-5-3) 

        6. Windows Media Playerプラグインの項目が表示されており、「無効化する」が選択されている。(Plugin-6-1)\
            または、「常に有効化する」が選択されている。(Plugin-6-2)\
            または、「実行時に確認する」が選択されている。(Plugin-6-3) 

        7. Cisco WebExプラグインの項目（ActiveTouch General Plugin Container）が表示されており、「無効化する」が選択されている。(Plugin-7-1)\
            または、「常に有効化する」が選択されている。(Plugin-7-2)\
            または、「実行時に確認する」が選択されている。(Plugin-7-3) 

        8. OpenH264のプラグインが表示される。(Plugin-8-1)\
            または、表示されない。(Plugin-8-2) 

        9. 「Primetime Content Decryption
            Module」が表示される。(Plugin-8-1)\
            または、表示されない。(Plugin-8-2) 

3. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

    - 確認項目 

        1. 「コンテンツ」配下に「DRMコンテンツ」グループがある。(Plugin-8-1)\
            または、無い。(Plugin-8-2) 

### 9.1.4 後始末

1. 以下のアドオンを有効化する。 

  Disable Addons

## 9.2 ファイルをダウンロードして外部アプリケーションで開く際の挙動の制御

### 9.2.1 確認する項目

- External-1-2 

### 9.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. エクスプローラを起動して、アドレスバーに「%temp%」と入力し、システムのテンポラリフォルダを開く。 

3. ファイルを更新日時順で並べ替えて、新しいファイルが出現したら分かるようにしておく。 

4. この検証手順書自体のファイルをWebサーバにアップロードするか、「odt
    sample」のようなキーワードでWebを検索するなどして、外部アプリケーションで開く必要があるファイルのダウンロード用リンクを用意しておく。 

### 9.2.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. 外部アプリケーションで開く必要があるファイルへのリンクをクリックする。 

3. 「次のファイルを開こうとしています」のダイアログが表示されたら、起動する外部アプリケーションを選択して「OK」をクリックする。 

4. 外部アプリケーションを終了し、テンポラリフォルダの内容を確認する。 

    - 確認項目 

        1. ダウンロードしたファイルがテンポラリフォルダに保存されている。(External-1-2) 

        2. テンポラリファイルのプロパティにおいて、「読み取り専用」にチェックが入っていない。(External-1-2) 

 

# 10 キーボードショートカット、メニュー項目のカスタマイズ

## 10.1 タブとウィンドウの操作

### 10.1.1 確認する項目

- MenuShortcut-1 

- MenuShortcut-2 

- MenuShortcut-3 

- MenuShortcut-4 

- MenuShortcut-5 

- MenuShortcut-62 

### 10.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 10.1.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「about:」と入力し、Alt-Enterでタブとして開く。 

3. 開かれたタブを閉じる。 

4. ロケーションバーに「about:」と入力し、Alt-Enterでタブとして開く。 

5. 開かれたタブをドラッグしてウィンドウ外にドロップし、ウィンドウとして開く。 

6. 開かれたウィンドウを閉じる。 

    - 確認項目 

        1. 「Ctrl-Shift-T」を押して、閉じたタブが復元されない。(MenuShortcut-1) 

        2. 「Ctrl-Shift-N」を押して、閉じたウィンドウが復元されない。(MenuShortcut-2) 

        3. 「Ctrl-Shift-P」を押して、新しいプライベートウィンドウが開かれない。(MenuShortcut-3) 

        4. 「Ctrl-T」を押して、新しいタブが開かれない。(MenuShortcut-62) 

7. 「ファイル」メニューを開く。 

    - 確認項目 

        1. 「新しいプライベートウィンドウを開く」が存在しない。(MenuShortcut-3) 

        2. 「ページのURLをメールで送信」が存在しない。(MenuShortcut-4) 

        3. 「オフライン作業」が存在しない。(MenuShortcut-5) 

        4. 「新しいタブ」が存在しない。(MenuShortcut-62) 

8. 「履歴」メニューを開く。 

    - 確認項目 

        1. 「最近閉じたタブ」が存在しない。(MenuShortcut-1) 

        2. 「最近閉じたウィンドウ」が存在しない。(MenuShortcut-2) 

9. タブの上で右クリックする。 

    - 確認項目 

        1. 「閉じたタブを開き直す」が存在しない。(MenuShortcut-1) 

10. タブバーの「+」ボタン上で右クリックする。 

    - 確認項目 

        1. 「閉じたタブを開き直す」が存在しない。(MenuShortcut-1) 

11. パネルメニューを開く。 

    - 確認項目 

        1. 「新しいプライベートウィンドウ」が存在しない。(MenuShortcut-3) 

12. パネルメニュー内の「履歴」をクリックする。
      

    - 確認項目 

        1. 「最近閉じたタブ」
            セクションが存在しない。(MenuShortcut-1) 

        2. 「最近閉じたウィンドウ」セクションが存在しない。(MenuShortcut-2) 

13. パネルメニュー内の「開発ツール」をクリックする。
      

    - 確認項目 

        1. 「オフライン作業」
            セクションが存在しない。(MenuShortcut-5) 

14. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。 

    - 確認項目 

        1. 「ページのURLをメールで送信」が存在しない。(MenuShortcut-4) 

## 10.2 ツール

### 10.2.1 確認する項目

- MenuShortcut-7 

- MenuShortcut-10 

- MenuShortcut-11 

- MenuShortcut-12 

- MenuShortcut-13 

- MenuShortcut-14 

- MenuShortcut-15 

- MenuShortcut-16 

- MenuShortcut-17 

- MenuShortcut-18 

- MenuShortcut-20 

- MenuShortcut-21 

- MenuShortcut-22 

- MenuShortcut-23 

- MenuShortcut-24 

- MenuShortcut-25 

- MenuShortcut-26 

- MenuShortcut-27 

- MenuShortcut-28 

- MenuShortcut-29 

### 10.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 10.2.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

    - 確認項目 

        1. 「Ctrl-J」を押して、ダウンロード済みファイル一覧が開かれない。(MenuShortcut-7) 

        2. 「Ctrl-Shift-I」を押して、開発ツールが開かれない。(MenuShortcut-11) 

        3. 「F12」を押して、開発ツールが開かれない。(MenuShortcut-11) 

        4. 「Ctrl-Shift-C」を押して、インスペクタが開かれない。(MenuShortcut-12) 

        5. 「Ctrl-Shift-K」を押して、Webコンソールが開かれない。(MenuShortcut-13) 

        6. 「Ctrl-Shift-S」を押して、デバッガが開かれない。(MenuShortcut-14) 

        7. 「Shift-F7」を押して、スタイルエディタが開かれない。(MenuShortcut-15) 

        8. 「Shift-F5」を押して、プロファイラが開かれない。(MenuShortcut-16) 

        9. 「Ctrl-Shift-Q」を押して、ネットワークモニターが開かれない。(MenuShortcut-17) 

        10. 「Shitf-F2」を押して、開発ツールバーが開かれない。(MenuShortcut-18) 

        11. 「Shift-F8」を押して、WebIDEが開かれない。(MenuShortcut-20) 

        12. 「Ctrl-Shift-Alt-I」を押して、ブラウザツールボックスが開かれない。(MenuShortcut-21) 

        13. 「Ctrl-Shift-J」を押して、ブラウザコンソールが開かれない。(MenuShortcut-22) 

        14. 「Ctrl-Shift-M」を押して、レスポンシブデザインビューが開かれない。(MenuShortcut-23) 

        15. 「Shift-F4」を押してスクラッチパッド、が開かれない。(MenuShortcut-25) 

        16. 「Ctrl-U」を押して、ページのソースが開かれない。(MenuShortcut-26) 

2. 「ツール」メニューを開く。 

    - 確認項目 

        1. 「ダウンロード」が存在しない。(MenuShortcut-7) 

        2. 「Web開発」が存在しない。(MenuShortcut-10) 

2. 「ツール」メニュー内の「Web開発」を開く。 

    - 確認項目 

        1. 「開発ツールを表示」が存在しない。(MenuShortcut-11) 

        2. 「インスペクタ」が存在しない。(MenuShortcut-12) 

        3. 「Webコンソール」が存在しない。(MenuShortcut-13) 

        4. 「デバッガ」が存在しない。(MenuShortcut-14) 

        5. 「スタイルエディタ」が存在しない。(MenuShortcut-15) 

        6. 「パフォーマンス」が存在しない。(MenuShortcut-16) 

        7. 「ネットワーク」が存在しない。(MenuShortcut-17) 

        8. 「開発ツールバー」が存在しない。(MenuShortcut-18) 

        9. 「WebIDE」が存在しない。(MenuShortcut-20) 

        10. 「ブラウザツールボックス」が存在しない。(MenuShortcut-21) 

        11. 「ブラウザコンソール」が存在しない。(MenuShortcut-22) 

        12. 「レスポンシブデザインビュー」が存在しない。(MenuShortcut-23) 

        13. 「スポイト」が存在しない。(MenuShortcut-24) 

        14. 「スクラッチパッド」が存在しない。(MenuShortcut-25) 

        15. 「ページのソース」が存在しない。(MenuShortcut-26) 

        16. 「エラーコンソール」が存在しない。(MenuShortcut-27) 

        17. 「接続」が存在しない。(MenuShortcut-28) 

        18. 「その他のツールを入手」が存在しない。(MenuShortcut-29) 

3. パネルメニューを開き、パネルメニュー内の「開発ツール」をクリックする。
      

    - 確認項目 

        1. 「開発ツールを表示」が存在しない。(MenuShortcut-11) 

        2. 「インスペクタ」が存在しない。(MenuShortcut-12) 

        3. 「Webコンソール」が存在しない。(MenuShortcut-13) 

        4. 「デバッガ」が存在しない。(MenuShortcut-14) 

        5. 「スタイルエディタ」が存在しない。(MenuShortcut-15) 

        6. 「パフォーマンス」が存在しない。(MenuShortcut-16) 

        7. 「ネットワーク」が存在しない。(MenuShortcut-17) 

        8. 「開発ツールバー」が存在しない。(MenuShortcut-18) 

        9. 「WebIDE」が存在しない。(MenuShortcut-20) 

        10. 「ブラウザツールボックス」が存在しない。(MenuShortcut-21) 

        11. 「ブラウザコンソール」が存在しない。(MenuShortcut-22) 

        12. 「レスポンシブデザインビュー」が存在しない。(MenuShortcut-23) 

        13. 「スポイト」が存在しない。(MenuShortcut-24) 

        14. 「スクラッチパッド」が存在しない。(MenuShortcut-25) 

        15. 「ページのソース」が存在しない。(MenuShortcut-26) 

        16. 「エラーコンソール」が存在しない。(MenuShortcut-27) 

        17. 「接続」が存在しない。(MenuShortcut-28) 

        18. 「その他のツールを入手」が存在しない。(MenuShortcut-29) 

4. パネルメニュー内の「カスタマイズ」をクリックしてツールバーのカスタマイズ画面を開く。 

    - 確認項目 

        1. 「ダウンロード」が存在しない。(MenuShortcut-7) 

        2. 「開発ツール」が存在しない。(MenuShortcut-10) 

## 10.3 ヘルプ

### 10.3.1 確認する項目

- MenuShortcut-30 

- MenuShortcut-31 

- MenuShortcut-32 

- MenuShortcut-33 

- MenuShortcut-35 

- MenuShortcut-36 

- MenuShortcut-37 

- MenuShortcut-38 

- MenuShortcut-39 

- MenuShortcut-40 

### 10.3.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 10.3.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. 「ヘルプ」メニューを開く。 

    - 確認項目 

        1. 「Firefoxヘルプ」が存在しない。(MenuShortcut-30) 

        2. 「Firefoxツアー」が存在しない。(MenuShortcut-31) 

        3. 「キーボードショートカット」が存在しない。(MenuShortcut-32) 

        4. 「Firefoxヘルスレポート」が存在しない。(MenuShortcut-33) 

        5. 「トラブルシューティング情報」が存在しない。(MenuShortcut-35) 

        6. 「フィードバックを送信」が存在しない。(MenuShortcut-36) 

        7. 「アドオンを無効にして再起動」が存在しない。(MenuShortcut-37) 

        8. 「偽装サイトを報告」が存在しない。(MenuShortcut-38) 

        9. 「誤警告を報告」が存在しない。(MenuShortcut-39) 

        10. 「Firefoxについて」の前にセパレータが存在しない。(MenuShortcut-40) 

3. パネルメニューを開き、パネルメニュー内の「？」をクリックする。
      

    - 確認項目 

        1. 「Firefoxヘルプ」が存在しない。(MenuShortcut-30) 

        2. 「Firefoxツアー」が存在しない。(MenuShortcut-31) 

        3. 「キーボードショートカット」が存在しない。(MenuShortcut-32) 

        4. 「Firefoxヘルスレポート」が存在しない。(MenuShortcut-33) 

        5. 「トラブルシューティング情報」が存在しない。(MenuShortcut-35) 

        6. 「フィードバックを送信」が存在しない。(MenuShortcut-36) 

        7. 「アドオンを無効にして再起動」が存在しない。(MenuShortcut-37) 

        8. 「偽装サイトを報告」が存在しない。(MenuShortcut-38) 

        9. 「誤警告を報告」が存在しない。(MenuShortcut-39) 

        10. 「Firefoxについて」の前にセパレータが存在しない。(MenuShortcut-40) 

## 10.4 書字方向の切り替えの制御

### 10.4.1 確認する項目

- MenuShortcut-41 

- MenuShortcut-42 

### 10.4.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable about:config 

### 10.4.3 検証

1. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. ロケーションバーに「about:config」と入力し、詳細設定一覧を開いて、「bidi.browser.ui」の値を「true」に設定する。 

3. Firefoxを終了する。 

4. {{desktop_shortcut_path}}
    がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。  

5. 「 https://addons.mozilla.org/ 」など、テキスト入力欄があるWebページを開く。 

6. テキスト入力欄をクリックしてフォーカスした状態にする。 

    - 確認項目 

        1. 「Ctrl-Shift-X」を押して、テキスト入力欄の書字方向が切り替わらない(MenuShortcut-41) 

7. 「編集」メニューを開く。 

    - 確認項目 

        1. 「テキストの記述方向を切り替える」が存在しない。(MenuShortcut-41) 

8. 「表示」メニューを開く。 

    - 確認項目 

        1. 「ページの記述方向を切り替える」が存在しない。(MenuShortcut-42) 

### 10.4.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable about:config 

## 10.5 履歴とブックマーク

### 10.5.1 確認する項目

- MenuShortcut-43 

- MenuShortcut-44 

### 10.5.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 10.5.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. 「履歴」メニューを開く。 

    - 確認項目 

        1. メニュー内に、セパレータが単独で2連続表示されている箇所がない。(MenuShortcut-43) 

3. 「ブックマーク」メニューを開く。 

    - 確認項目 

        1. 「ブックマークツールバー」が存在しない。(MenuShortcut-44) 

        2. メニュー内に、セパレータが単独で2連続表示されている箇所がない。(MenuShortcut-44) 

2. ツールバー上のブックマークボタンをクリックし、ブックマーク一覧を開く。 

    - 確認項目 

        1. 「ブックマークツールバー」が存在しない。(MenuShortcut-44) 

        2. メニュー内に、セパレータが単独で2連続表示されている箇所がない。(MenuShortcut-44) 

4. ツールバー上のブックマークボタンの上で右クリックし、「メニューに移動」を選択する。 

5. パネルメニューを開き、パネルメニュー内の「ブックマーク」をクリックする。
      

    - 確認項目 

        1. 「ブックマークツールバー」が存在しない。(MenuShortcut-44) 

        2. メニュー内に、セパレータが単独で2連続表示されている箇所がない。(MenuShortcut-44) 

## 10.6 コンテンツ領域のコンテキストメニュー

### 10.6.1 確認する項目

- MenuShortcut-45 

- MenuShortcut-46 

- MenuShortcut-47 

- MenuShortcut-48 

- MenuShortcut-49 

- MenuShortcut-50 

- MenuShortcut-51 

- MenuShortcut-52 

- MenuShortcut-53 

- MenuShortcut-54 

- MenuShortcut-55 

- MenuShortcut-57 

- MenuShortcut-63 

### 10.6.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 10.6.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. 「 https://addons.mozilla.org 」を開き、何もない所で右クリックする。 

    - 確認項目 

        1. 「このページを共有」が存在しない。(MenuShortcut-52) 

        2. 「ページを保存する」が存在しない。(MenuShortcut-53) 

        3. 「要素を調査」が存在しない。(MenuShortcut-57) 

3. ページ内の文字列を選択して右クリックする。 

    - 確認項目 

        1. 「選択範囲を共有」が存在しない。(MenuShortcut-54) 

4. ページ内のリンクの上で右クリックする。 

    - 確認項目 

        1. 「リンクを保存する」が存在しない。(MenuShortcut-45) 

        2. 「このリンクを共有」が存在しない。(MenuShortcut-46) 

        3. 「新しいタブで開く」が存在しない。(MenuShortcut-63) 

5. ページ内に埋め込まれた画像の上で右クリックする。 

    - 確認項目 

        1. 「画像のURLをメールで送信」が存在しない。(MenuShortcut-47) 

        2. 「この画像を共有」が存在しない。(MenuShortcut-48) 

        3. 「デスクトップの背景に設定」が存在しない。(MenuShortcut-55) 

6. 「 http://www.w3schools.com/html/html5\_video.asp 」を開き、ページ内に埋め込まれた動画の上で右クリックする。 

    - 確認項目 

        1. 「動画のURLをメールで送信」が存在しない。(MenuShortcut-49) 

        2. 「この動画を共有」が存在しない。(MenuShortcut-50) 

2. 「 http://www.w3schools.com/html/tryit.asp?filename=tryhtml5\_audio\_all 」を開き、ページ内に埋め込まれたオーディオコントロールの上で右クリックする。 

    - 確認項目 

        1. 「オーディオのURLをメールで送信」が存在しない。(MenuShortcut-51) 

## 10.7 ポップアップブロック

### 10.7.1 確認する項目

- MenuShortcut-58 

- MenuShortcut-59 

### 10.7.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のカスタマイズを無効化する。 

    1. Security-4-2/3/4 

### 10.7.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

2. テストケースの「popupblock.html」を開く。 

    - 確認項目 

        1. 「1個のポップアップがブロックされました」と表示される。(MenuShortcut-58/59) 

3. 「設定」ボタンをクリックする。 

    - 確認項目 

        1. 「このサイトによるポップアップを許可する」が存在しない。(MenuShortcut-58) 

        2. 「ポップアップブロック設定を変更」が存在しない。(MenuShortcut-59) 

### 10.7.4 後始末

1. 以下のカスタマイズを有効化する。 

    1. Security-4-2/3/4 

# 11 その他のUIの非表示化

## 11.1 設定UIの非表示化

### 11.1.1 確認する項目

- Hide-1 

- Hide-2 

- Hide-3 

- Hide-6 

- Hide-7 

- Hide-9 

### 11.1.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 11.1.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

    - 確認項目
         

        1. タブバー上に「+」ボタン（新しいタブを開くボタン）が表示されない。(Hide-6) 

2. パネルメニューを開き、パネルメニュー内の「オプション」をクリックする。
     

    - 確認項目
         

        1. 「セキュリティ」が表示されない。(Hide-1) 

        2. 「Sync」が表示されない。（Hide-2） 

        3. 「？」ボタン（ヘルプボタン）が表示されない。(Hide-3) 

3. 「一般」を選択する。
     

    - 確認項目
         

        1. 「タブグループ」以下に「新しいウィンドウではなく新しいタブで開く」が表示されない。(Hide-7) 

        2. 「ダウンロード」グループが表示されない。(Hide-9) 

## 11.2 パーミッション設定UIの非表示化

### 11.2.1 確認する項目

- Hide-4 

### 11.2.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

2. 以下のアドオンを無効化する。 

    1. Disable
        Addons 

3. 以下のカスタマイズを無効化する。 

    1. Security-4-3（ポップアップブロックを有効化する）：{{mcd_local_file}}/autoconfig.jscから項目を削除 

    2. Privacy-6-3（オフラインキャッシュの設定UIを有効化する）：globalChrome.cssと{{mcd_local_file}}/autoconfig.jscから項目を削除 

    3. Hide-1（「セキュリティ」ペインを有効化する）：globalChrome.cssから項目を削除 

### 11.2.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

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

### 11.2.4 後始末

1. 以下のアドオンを有効化する。 

    1. Disable
        Addons 

2. 以下のカスタマイズを有効化する。 

    1. Security-4-3 

    2. Privacy-6-3 

    3. Hide-1 

## 11.3 Webブラウズ用UIの非表示化

### 11.3.1 確認する項目

- Hide-6 

- Hide-8 

### 11.3.2 準備

1. 前項に引き続き検証するか、または以下の状態を整えておく。 

    1. カスタマイズ済みFirefoxのインストールが完了した状態にする。 

### 11.3.3 検証

1. {{desktop_shortcut_path}}がある場合はそれを、なければfirefox.exeをダブルクリックしてFirefoxを起動する。
     

    - 確認項目
         

        1. タブバー上に「+」が表示されていない。(Hide-6) 

2. ロケーションバーに「about:」と入力し、ページを開く。 

3. 画像の上で右クリックしてコンテキストメニューを開く。 

    - 確認項目 

        1. 「デスクトップの背景に設定」が表示されない。（Hide-8） 

