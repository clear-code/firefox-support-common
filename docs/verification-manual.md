# 検証手順書解説

検証手順書を生成する上で必要な設定ファイルについて説明する。

## 検証手順書の生成

検証手順書を生成するためには[README.md](./README.md)で述べたようにmake verification-manualを実行するとよい。
実際の生成は`cat-verify`なるプログラムにより行われ、pandocを経由してdocxに変換される。

cat-verifyには次のオプションがある。

* -c
  * 設定ファイルを指定する
* -a
  * 変数の定義ファイルを指定する
* -i
  * 選択した検証項目と検証手順書の項番号の対応を示すverify-targets-to-chapters.csvを生成する。
* -l
  * 見出し番号、検証対象項目、検証結果のチェックリストverify-$(DATE)-checklist.csvを生成する。
* --sort-about-config={pref,option}
  * 「about:configを使用した検証」の検証項目の並びを制御する。既定値はprefでプリファレンス名でソート(昇順)する。
  optionを指定した場合、オプションIDの順(設定シートのカテゴリ出現順)にソート(昇順)する。

## 設定ファイルと定義ファイル

検証手順書を生成する際には、設定シートを生成するのに使った設定ファイルおよび、
カスタマイズ先の内容に合わせるための定義ファイルを用いる。

定義ファイルには、カスタマイズの要件によって変化しうる内容をあらかじめ設定します。

たとえば、次のように定義することで、バージョンのみ変更があっても容易に対応できます。

```
firefox_version:                102.4.0 ESR
windows_version:                Windows 10
configuration_sheet_name:       configs.xlsx
```

ここで定義した内容は、検証手順書に`{{ firefox_version }}`として埋め込むことができます。

## 検証手順書の様式


検証手順書は、設定シート同様にカテゴリごとに[verify](../verify)ディレクトリ配下に記述します。


```
Admin-0: 管理用設定の検証

   :1: 事前準備

    - 前項に引き続いて検証するか、{%if use_meta_installer %}次の手順でFirefoxをセットアップしておく。
        - 検証用ユーザーとして `{{meta_installer_file_name}}*.exe` を実行する。
        - 管理者権限を要求された場合は、`管理者`ユーザーで認証する。
    {% else %}再ログオン、インストーラの手動実行など、所定の手順でFirefoxのインストール及びカスタマイズを反映済みの状態とする。{% endif %}

```

設定シートと同様に、`カテゴリ-N: 項目名`のようにして記述します。

選択肢を:1:などとするのも同様です。

検証手順書特有なのは、変数の埋め込みや、条件式を記述できることです。

`{%if ... %}`を使って条件に応じた検証手順を記述できます。なお`{%if %} {% else %} {% endif %}`は使えますが、`elif` `elsif`などは使えません。

### 特定の項目を選択している場合

選択した項目は、`カテゴリ名_番号_選択肢の番号`というように変数が定義されるため、
`{%if Security_3_3 %}`などとして、選択されたときのみ有効な検証手順を記述することができます。

### 検証手順を独立した章にまとめる場合

通常検証手順はカテゴリごとにまとめられますが、次の独立した章にまとめることもできます。

* 設定画面を使用した検証
* about:configを使用した検証
* about:policiesを使用した検証

いずれも挙動を確認することが難しい場合など、設定が反映されていることを画面もしくは設定値の表示が期待するものになっていることで確認します。
設定画面を使用した検証の章に検証手順を反映するには、次のような書式で検証手順を記載します。

```
OPTIONS

- オプション画面の設定による確認を行いたい場合に記載
```

about:configを使用した検証

```
ABOUT_CONFIG

- about:configを使って設定値による確認を行いたい場合に記載
```

about:policiesを使用した検証

```
ABOUT_POLICIES

- about:policiesを使って設定値による確認を行いたい場合に記載
```

## FAQ

### 特定の条件を満たす変数を定義する方法

設定項目の組み合わせによっては、検証手順の記述側ではなく、検証手順を生成するプログラム側で条件を定義したほうがすっきり書ける場合があります。

その場合には、[cat-verify](../cat-verify)の`def create_template`あたりに`vars`定義を追加します。

例えば、Homeボタンを表示するかどうかは、起動時のホームページ設定がなされているか、`ShowHomeButton`ポリシーを有効にしていれば表示しますが、
`ShowHomeButton`が明示的に無効にされていれば表示しません。

```
vars['show_home_button'] = (vars['Startup_2_4'] or vars['Startup_2_5']) or vars['Appearance_12_1']
    if vars['Appearance_12_2']:
        vars['show_home_button'] = False
```

そこで上記のように`show_home_button`を定義しておけば、検証手順を記述するときに`{%if show_home_button %}`とすっきり記述できます。

### 検証環境を構築する方法

カスタマイズしたメタインストーラーの検証は`terraform`を用いて検証環境を構築する。
[verify/terraform](../verify/terraform)配下に各種バージョンごとの雛形が用意されている。

あらかじめ次の値を設定しておけば、makeを実行するだけでインスタンスを立ち上げることができる。

```
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""
export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
```

上記を取得するのに必要な情報は、サブスクリプションIDをもとに、AzureのCloud Shellでコマンドを実行することにより取得できる。

```
export SUBSCRIPTION_ID=""
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
```

なお、検証対象となる環境に変更があったときなど、Windows 10のどのSKUを指定できるかは次のコマンドで調べられる。

```
az vm image list-skus --location japaneast --publisher MicrosoftWindowsDesktop --offer Windows-10
```

対象がWindows Serverの場合は次のコマンドで調べられる。

```
az vm image list-skus --location japaneast --publisher MicrosoftWindowsServer --offer WindowsServer
```

