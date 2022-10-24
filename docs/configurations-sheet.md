# 設定シート解説

設定シートを生成する上で必要な設定ファイルについて説明する。

## カテゴリについて

firefox-support-commonでは設定可能な項目の分類として次を採用している。

* Addon-Acrobat
* Addon-FireIE
* Addon-IEView
* Addon-Skysea
* Admin
* Appearance
* Application
* Download
* External
* Install
* Location
* MenuShortcut
* Network
* Performance
* Plugin
* Privacy
* Script
* Security
* Stability
* Startup
* Tab
* Ui
* Update
* Websearch

なお、本分類はプロジェクト独自のものである。

## 設定項目の書式

各設定項目は次の様式で記述する。

```
Admin-1: 管理者による設定の制御

    :1: ローカルのファイルで設定する

    defaults\pref\*.js:
    ...

    :2: リモートのファイルで設定する

    defaults\pref\*.js:
    ...

    :3: 設定しない（既定）

    -
```

最初に`カテゴリ-N`でカテゴリのN番目の設定項目をしめす。項目の題は`:`のあとに記述する。

項目に対応する選択肢は複数記述でき、`:N:`というスタイルでN番目の選択肢であることを示す。
次の:N:がくるまでが適用された選択肢の値となる。

適用された選択肢の値には、MCDでの設定例、ポリシーでの設定例、GPOでの設定例を記述する。

なお、既定の選択肢には`(既定)`を明記し、その適用する値には`-`を記述し、実際の設定ファイルには反映しない。
