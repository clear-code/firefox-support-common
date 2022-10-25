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
* -t
  * テンプレートと反映した設定値を比較する。新しい設定方法であったり、変更された設定値に追従できていない項目を検出するのに用いる。
  * 追従できていない場合、セルに雛形要確認(変更あり)と出力される。提供用のxlsxには指定しないこと。

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



