---
CJKmainfont: Noto Sans CJK JP
CJKoptions:
  - BoldFont=Noto Sans CJK JP Bold
title: Thunderbirdの更新手順
subject: Thunderbirdの更新手順
date: 2026/4/10
author: 株式会社クリアコード
titlepage-logo: thunderbird/clear-code.png
logo-width: 6.5cm
titlepage: true
colorlinks: true
toc-title: 目次
toc-own-page: true
---

# 概要

本手順書は、Thunderbirdを自動更新機能を用いて更新する手順を説明するものです。


# 事前準備

Thunderbirdの更新にあたっては、事前に以下の条件を整えてください。

* PCがインターネットに接続されており、任意のアプリケーションで以下のURLへアクセス可能であること。
  （プロキシーなどでアクセス可能なURLを制限している場合、以下のURLのパターンへのアクセスを許可してください。）
  - https://aus.thunderbird.net/*
  - https://aus5.mozilla.org/*
  - https://download.mozilla.org/*
  - https://download-installer.cdn.mozilla.net/*

# 自動更新の実施

Thunderbirdの更新作業を行う環境において、前述の準備が終わっているものとします。

## 自動更新の有効化

1. Thunderbirdを起動します。
2. メインウィンドウ右上の「≡」のボタンをクリックしてメニューパネルを開き、「設定」を選択します。  
    ![スクリーンショット：ThunderbirdのUIのうち、メニューパネルが開かれており、「設定」コマンドがハイライト表示された状態。](./thunderbird-esr-manual-update/options-from-appmenu.png){ width=300 }  
   または、メインウィンドウのメニューバー（非表示になっている場合はAltキーで表示できます）の「ツール」→「設定」を選択します。  
    ![スクリーンショット：ThunderbirdのUIのうち、メニューバー配下の「ツール」メニューが開かれており、「設定」コマンドがハイライト表示された状態。](./thunderbird-esr-manual-update/options-from-menubar.png){ width=300 }
3. Thunderbirdの設定画面が開かれたら、左ペインで「一般」を選択し、右ペインを下までスクロールして「更新」という見出しを探します。  
    ![スクリーンショット：Thunderbirdの設定画面のUI。](./thunderbird-esr-manual-update/options.png){ width=500 }  
   「Thunderbirdの更新動作」で「更新を自動的にインストールする」を選択し、「更新のインストールにバックグラウンドサービスを使用する」にチェックを入れます。
   * 「更新のインストールにバックグラウンドサービスを使用する」がグレーアウトして無効化されている場合、Thunderbirdのインストール時に必要なサービスがインストールされていません。その場合、Thunderbirdのインストーラーを実行し、ウィザードで「Mozilla Maintenance Service」のインストールを有効にしてThunderbirdのインストールを完了させてください。

以上でThunderbirdの自動更新機能の有効化は完了です。

## 更新の実施

1. Thunderbirdを起動します。
2. メインウィンドウ右上の「≡」のボタンをクリックしてメニューパネルを開き、「ヘルプ」→「Thunderbirdについて」を選択します。  
    ![スクリーンショット：ThunderbirdのUIのうち、メニューパネルが開かれており、「ヘルプ」がハイライト表示された状態。](./thunderbird-esr-manual-update/about-from-appmenu.png){ width=600 }  
   または、メインウィンドウのメニューバー（非表示になっている場合はAltキーで表示できます）の「ヘルプ」→「Thunderbirdについて」を選択します。  
    ![スクリーンショット：ThunderbirdのUIのうち、メニューバー配下の「ヘルプ」メニューが開かれており、「Thunderbirdについて」コマンドがハイライト表示された状態。](./thunderbird-esr-manual-update/about-from-menubar.png){ width=300 }
3. 「（新しいバージョンの番号）に更新」ボタンが表示されている場合は、それをクリックします。  
    ![スクリーンショット：Thunderbirdのバージョン情報の画面に「140.9.1esrに更新」というボタンが表示された状態。](./thunderbird-esr-manual-update/about-update-button.png){ width=500 }
4. 更新のダウンロードが完了するまで待ちます。（自動更新によってバックグラウンドでダウンロードが完了していた場合、この画面は表示されません。）  
    ![スクリーンショット：Thunderbirdのバージョン情報の画面に更新のダウンロード状況が表示された状態。](./thunderbird-esr-manual-update/about-updating.png){ width=500 }
5. 更新のダウンロードが完了して「再起動してThunderbirdを更新」ボタンが表示されたら、それをクリックします。  
    ![スクリーンショット：Thunderbirdのバージョン情報の画面に「再起動してThunderbirdを更新」というボタンが表示された状態。](./thunderbird-esr-manual-update/about-updated.png){ width=500 }
6. Thunderbirdが自動的に再起動します。再起動が完了したら、メインウィンドウ右上の「≡」のボタンをクリックしてメニューパネルを開き、「ヘルプ」→「Thunderbirdについて」を選択するか、または、メインウィンドウのメニューバー（非表示になっている場合はAltキーで表示できます）の「ヘルプ」→「Thunderbirdについて」を選択します。
7. バージョン番号が更新後のバージョンになっていて、「Thunderbirdは最新バージョンです」と表示されていることを確認します。  
    ![スクリーンショット：Thunderbirdのバージョン情報の画面に「Thunderbirdは最新バージョンです」というメッセージが表示された状態。](./thunderbird-esr-manual-update/about-updated-completely.png){ width=500 }

以上でThunderbirdの更新は完了です。
