# 設定シート解説

設定シートを生成する上で必要な設定ファイルについて説明する。

## 設定シートの生成

設定シートを生成するためには[README.md](./README.md)で述べたようにmake configurations-sheetを実行するとよい。
実際の生成は`build-xlsx`なるプログラムにより行われる。

`build-xlsx`には次のオプションがある。

* -o
  * 出力先のxlsxファイルを指定する
* -x
  * 除外するワークシートをカンマ区切りで指定する
* -p
  * 移行元のバージョンを指定する
* -c
  * 移行先のバージョンを指定する
* -d
  * 設定ファイルを指定する。通常移行前のバージョンと、移行先のバージョンの2つをラベルつきで次のように指定する。`-d ESR91:esr91.txt -d ESR102:esr102.txt` 移行先のバリエーション(PC用とVDI環境用など複数バージョン)がある場合、追加で-dオプションを指定する。
  * -dは複数回指定してよいが、先に古いバージョンから指定する。
* -t
  * テンプレートと反映した設定値を比較する。新しい設定方法であったり、変更された設定値に追従できていない項目を検出するのに用いる。
  * 追従できていない場合、セルに雛形要確認(変更あり)と出力される。提供用のxlsxには指定しないこと。
* -b
  * ベースとなるESRの設定項目のファイルが存在するディレクトリを指定する。既定ではfirefox-support-commonのトップディレクトリ。テストのために一時的に変更するために用いる。

引数として、検証対象と章番号の対応を記したverify-targets-to-chapters.csvを渡して実行する。
実行例は次のとおりである。

```
./build-xlsx -o config.xlsx -d ESR91:esr91.conf -d ESR102:esr102.conf verify-targets-to-chapters.csv
```

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

## 設定項目の書式(v2)

v2では設定項目の書式が2種類ある。

* 基底となる設定ファイル
* 実際に適用する設定ファイル

前者は、設定可能な項目を網羅したもので、esrNNNディレクトリ配下のファイルが該当する。
依存関係や相反している項目のメタ情報を付与する。
後者は、カスタマイズで実際に適用する内容のみの記述したファイルである。-dオプションで指定される。

### 基底となる設定ファイルの書式

基底となる設定ファイルの書式ではメタ情報を付与することを推奨する。

```
Admin-1: 管理者による設定の制御

    :1: ローカルのファイルで設定する

    cfg_or_jsc: |
      ...

    :2: リモートのファイルで設定する

    cfg_or_jsc: |
      ...

    policies_json: |
      ...

    GPO: |
      ...

    :3: 設定しない（既定）

    -
```

最初に`カテゴリ-N`でカテゴリのN番目の設定項目をしめす。項目の題は`:`のあとに記述する。

項目に対応する選択肢は複数記述でき、`:N:`というスタイルでN番目の選択肢であることを示す。
次の:N:がくるまでが適用された選択肢の値となる。

適用された選択肢の値には、MCDでの設定例、ポリシーでの設定例、GPOでの設定例を記述する。

なお、既定の選択肢には`(既定)`を明記し、その適用する値には`-`を記述し、実際の設定ファイルには反映しない。

基底となる設定ファイルで指定可能なメタ情報は次のとおり。

* `GPO`: GPOでの設定方法を記述する
* `browserselector_ini`: BrowserSelector.iniに記述すべき内容を記述する
* `cfg_or_jsc`: MCDに設定すべき内容を記述する
* `combined`: MCDおよびpolicies.jsonの双方を設定しないといけない場合にtrueを指定する
* `config_nsh`: config.nshに設定すべき内容を記述する
* `comment`: 選択肢に関する挙動など、技術的詳細を記述する。設定シートにはセルのコメントとして反映され、既定で非表示となる
* `conflict_with`: 他の選択肢と競合する場合に競合する選択肢を指定する
* `default_permissions`: defaults/default.permissionsに設定すべき内容を記述する
* `default`: 既定の選択肢にtrueを指定する。従来の書式の「-」相当
* `defaults_pref_js`: defaults/pref/*.jsに設定すべき内容を記述する
* `deprecated`: 廃止されたり、非推奨の選択肢にtrueを指定する
* `fainstall_ini`: fainstall.iniに設定すべき内容を記述する
* `firefox_setup_ini`: Firefox-setup.iniに設定すべき内容を記述する
* `forced_by`: 他の項目の選択により、自動的に項目が選択される場合、該当する派生元の項目を指定する
* `menu_command_reg`: menu-command.regに設定すべき内容を記述する
* `policies.json`: policies.jsonに設定すべき内容を記述する。意図しないパース結果となるため、反映する設定にタブ文字を含んではならない
* `usercontent_css`: defaults/chrome/userContent.cssに設定すべき内容を記述する

### 実際に適用する設定ファイルの書式

実際に適用する設定ファイルの書式は基底となる設定ファイルの書式に準じる。

実際に適用する設定ファイル特有のメタ情報は次のとおり。

* `-`: 既定の選択肢に記述する。`comment`や`note`と併用したい場合は、`default: true`を記述する
* `autoconfig_js`: defaluts/pref/autoconfig.jsに設定すべき内容を記述する
* `cfg`: autoconfig.cfgに設定すべき内容を記述する
* `jsc`: defaults/pref/*.jsに設定すべき内容を記述する
* `note`: 選択肢に関して、補足事項を記述する。設定シートの反映した値の先頭に備考として反映される。特定の要件のために選択した項目のために使う
* `policies.json`: policies.jsonに設定すべき内容を記述する。意図しないパース結果となるため、反映する設定にタブ文字を含んではならない

## 設定項目の書式(v1)

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

# FAQ

## 検証手順書対応番号が省略になっている場合

設定ファイルを更新して、設定シートを生成しなおしたが検証手順書対応番号が「省略」となっていて
期待通りに番号が振られない場合には、対象項目と章番号をひもづけるverify-targets-to-chapters.csvが古いせいの場合がある。

その場合、CSVを削除し再度生成しなおすと解消する。

## MCDからポリシーのPreferencesに移行したが反映されない

従来autoconfig.cfgで設定を反映していたものをPreferencesポリシーに移行する際、
設定が反映されないということがある。

記述の誤り等がない場合、あるいはabout:policiesのエラーに何も表示されていない場合には、Preferencesに指定可能な
ものかを確認するとよい。

Preferencesポリシーでは設定可能な項目が制限されているためである。

* [Preferencesポリシーに指定可能なもの(mozilla-central)](https://searchfox.org/mozilla-central/source/browser/components/enterprisepolicies/Policies.sys.mjs#1682-1727)
* [ESR102の場合のPreferencesポリシーに指定可能なもの](https://searchfox.org/mozilla-esr102/source/browser/components/enterprisepolicies/Policies.jsm#1675-1721)

なお、Policies.jsmだったのはESR102までで、最近のバージョンではjsmはsys.mjsに変更されている。



