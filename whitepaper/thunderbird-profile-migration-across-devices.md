---
CJKmainfont: Noto Sans CJK JP
CJKoptions:
  - BoldFont=Noto Sans CJK JP Bold
title: |
  PC更改に際しての  
  Thunderbirdのデータ移行手順
subject: PC更改に際してのThunderbirdのデータ移行手順
date: 2025/11/14
author: 株式会社クリアコード
titlepage: true
toc-title: 目次
toc-own-page: true
---

# 概要

本手順書は、Thunderbirdのデータ（ユーザープロファイル）を、含まれる情報を極力維持したまま、あるWindows PCから別のWindows PCへ移行する手順を説明するものです。


# 事前準備

データ移行作業の実施にあたっては、事前に以下の条件を整えてください。

* 移行先のPCには、移行元のPCで使用していたものと同じか、より新しいバージョンのThunderbirdをインストールしてください。
  * 移行先のPCのThunderbirdのバージョンが古いと、データ損失が発生する恐れがあります。
* 移行先のPCのThunderbirdのインストール先パスは、移行元のPCと同じ位置に揃えてください。
  初期状態でのインストール先は `C:\Program Files\Mozilla Thunderbird` となります。
* ログオンユーザーのホームディレクトリー名（一般的には `C:\Users\(ログオンユーザー名)` のログオンユーザー名部分）は、移行元のPCと同じ名前に揃えてください。
  * ログオンユーザーのホームディレクトリー名が移行元のPCと移行先のPCとで異なっている場合でも、データの移行は可能ですが、移行先の初回起動時にメールの読み込み・表示に不具合が生じる可能性があります。
* 両方のPCにおいて、Thunderbirdが完全に終了した状態で作業を行ってください。
  * メニューパネル内のコマンド「終了」を実行してください。  
    ![スクリーンショット：ThunderbirdのUIのうち、メニューパネルが開かれており、最下部の「終了」コマンドがハイライト表示された状態。](./thunderbird-profile-migration-across-devices/quit-command.png){ width=500 }
  * Ctrl-Shift-ESCでタスクマネージャーを起動して、「詳細」表示に切り替え、「名前」列をクリックしてプロセスを名前順に並べ替えて、 `thunderbird.exe` のプロセスが残留していないことを確認してください。  
    もしThunderbirdの終了後も `thunderbird.exe` のプロセスが10分以上残留している場合は、項目を右クリックして「プロセス ツリーの終了」で強制終了してください。  
    ![スクリーンショット：タスクマネージャーの「詳細」表示で「thunderbird.exe」のプロセスが存在しているときに、右クリックメニューから「プロセス ツリーの終了」を選択して強制終了を試みる様子。](./thunderbird-profile-migration-across-devices/task-manager.png){ width=500 }


# データの移行

移行元のPCと移行先のPCの両環境において、前述の準備が終わっているものとします。

## 移行元PCでの作業

1. PCにおいて、エクスプローラーを開き、アドレスバーに `%AppData%` と入力してEnterキーを押してフォルダーを開きます。  
   ![スクリーンショット：移行元PCのエクスプローラーのアドレスバーに「%AppData%」と入力している様子。](./thunderbird-profile-migration-across-devices/explorer-input-appdata.png){ width=500 }
2. 開かれたフォルダー（通常は `C:\Users\(ログオンユーザー名)\AppData\Roaming`）内にある `Thunderbird` フォルダーを右クリックし、「コピー」を選択します。  
   ![スクリーンショット：移行元PCの「Thunderbird」フォルダーをコピーしようとしている様子。](./thunderbird-profile-migration-across-devices/explorer-copy-thunderbird-profile.png){ width=500 }
3. 移行元のPCと移行先のPCで共通してアクセス可能なファイル共有サーバー上の共有フォルダーか、USBメモリーなどの持ち運び可能なストレージ領域などを開き、フォルダーの余白部分を右クリックして「張り付け」を選択します。  
   ![スクリーンショット：コピーした「Thunderbird」フォルダーを共有ストレージ領域に張り付けようとしている様子。](./thunderbird-profile-migration-across-devices/explorer-paste-thunderbird-profile-to-shared-storage.png){ width=500 }

## 移行先PCでの作業

1. 前節でプロファイルを張り付けた共有フォルダーまたは持ち運び可能なストレージ領域などを開き `Thunderbird` フォルダーを右クリックして「コピー」を選択します。  
   ![スクリーンショット：共有ストレージ領域の「Thunderbird」フォルダーをコピーしようとしている様子。](./thunderbird-profile-migration-across-devices/explorer-copy-thunderbird-profile-from-shared-storage.png){ width=500 }
2. エクスプローラーを開き、アドレスバーに `%AppData%` と入力してEnterキーを押してフォルダーを開きます。  
   ![スクリーンショット：移行先PCのエクスプローラーのアドレスバーに「%AppData%」と入力している様子。](./thunderbird-profile-migration-across-devices/explorer-input-appdata.png){ width=500 }
3. 開かれたフォルダー（通常は `C:\Users\(ログオンユーザー名)\AppData\Roaming`）内にある `Thunderbird` フォルダーを右クリックし、「削除」を選択します。  
   ![スクリーンショット：移行先PCの「Thunderbird」フォルダーを削除しようとしている様子。](./thunderbird-profile-migration-across-devices/explorer-delete-thunderbird-profile.png){ width=500 }
4. 前項で開かれたフォルダーの余白部分を右クリックして「張り付け」を選択します。  
   ![スクリーンショット：コピーした「Thunderbird」フォルダーを移行先PCに張り付けようとしている様子。](./thunderbird-profile-migration-across-devices/explorer-paste-thunderbird-profile-to-destination.png){ width=500 }
5. 貼り付け後の `Thunderbird` フォルダーを開き、`Profiles` フォルダーに含まれるフォルダーのプロパティを確認して、最もサイズが大きいフォルダーを特定します。  
   ![スクリーンショット：「Thunderbird」内の「Profiles」フォルダー配下にあるフォルダーのサイズをプロパティで比較している様子。](./thunderbird-profile-migration-across-devices/explorer-find-largiest-profile-folder.png){ width=500 }
6. 前項で特定した最もサイズが大きいフォルダーを開きます。  
   ![スクリーンショット：前項で最もサイズが大きかったフォルダーの内容を一覧表示している様子。](./thunderbird-profile-migration-across-devices/explorer-open-largiest-profile.png){ width=500 }
7. 前項で開いたフォルダー内で、以下のフォルダーおよびファイルのうち存在するものすべてを、右クリックして「削除」を選択し削除します。
   * `chrome_debugger_profile`（フォルダー）
   * `crashes`（フォルダー）
   * `datareporting`（フォルダー）
   * `minidumps`（フォルダー）
   * `saved-telemetry-pings`（フォルダー）
   * `shader-cache`（フォルダー）
   * `addonStartup.json.lz4`（ファイル）
   * `compatibility.ini`（ファイル）
   ![スクリーンショット：プロファイルフォルダー内の一部のファイルとフォルダーを削除しようとしている様子。](./thunderbird-profile-migration-across-devices/explorer-delete-files-in-profile.png){ width=500 }
8. エクスプローラーを開き、アドレスバーに `%LocalAppData%` と入力してEnterキーを押してフォルダーを開きます。  
   ![スクリーンショット：移行先PCのエクスプローラーのアドレスバーに「%LocalAppData%」と入力している様子。](./thunderbird-profile-migration-across-devices/explorer-input-localappdata.png){ width=500 }
9. 開かれたフォルダー（通常は `C:\Users\(ログオンユーザー名)\AppData\Local`）内にある `Thunderbird` フォルダーを削除します。  
   ![スクリーンショット：移行先PCの「%LocalAppdata%」ないにある「Thunderbird」フォルダーを削除しようとしている様子。](./thunderbird-profile-migration-across-devices/explorer-delete-thunderbird-cache.png){ width=500 }
10. Thunderbirdを起動し、移行元環境と同様の状態になっていることを確認します。  
   ![スクリーンショット：移行先PCで移行したユーザープロファイルを用いてThunderbirdを起動した様子。](./thunderbird-profile-migration-across-devices/thunderbird-with-migrated-profile.png){ width=500 }

以上でデータの移行は完了です。
