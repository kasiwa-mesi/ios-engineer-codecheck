# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 目次

- [Swiftの勉強期間](https://github.com/kasiwa-mesi/ios-engineer-codecheck#Swiftの勉強期間)
- [使用したライブラリ](https://github.com/kasiwa-mesi/ios-engineer-codecheck#使用したライブラリ)
  - [CocoaPods](https://github.com/kasiwa-mesi/ios-engineer-codecheck#CocoaPods)
- [注意して取り組んだ所](https://github.com/kasiwa-mesi/ios-engineer-codecheck#注意して取り組んだ所)
  - [MVVMのアーキテクチャを意識](https://github.com/kasiwa-mesi/ios-engineer-codecheck#MVVMのアーキテクチャを意識)
  - [エラーの抜け目が無いように意識](https://github.com/kasiwa-mesi/ios-engineer-codecheck#エラーの抜け目が無いように意識)
  - [ネストを深くしない](https://github.com/kasiwa-mesi/ios-engineer-codecheck#ネストを深くしない)
  - [ハードコーディングを避ける](https://github.com/kasiwa-mesi/ios-engineer-codecheck#ハードコーディングを避ける)
- [追加した機能](https://github.com/kasiwa-mesi/ios-engineer-codecheck#追加した機能)
  - [AppDelegateでオンライン・オフラインを監視](https://github.com/kasiwa-mesi/ios-engineer-codecheck#AppDelegateでオンライン・オフラインを監視)
- [時間に余裕があれば何をするか](https://github.com/kasiwa-mesi/ios-engineer-codecheck#時間に余裕があれば何をするか)
  - [テストの追加](https://github.com/kasiwa-mesi/ios-engineer-codecheck#テストの追加)
  - [UIのブラッシュアップ](https://github.com/kasiwa-mesi/ios-engineer-codecheck#UIのブラッシュアップ)


## 概要

本プロジェクトは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する方に出す課題のベースプロジェクトです。本課題が与えられた方は、下記の概要を詳しく読んだ上で課題を取り組んでください。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要更新時点では Xcode 14.1）
- Swift：基本最新の安定版（本概要更新時点では Swift 5.7）
- 開発ターゲット：基本最新の安定版（本概要更新時点では iOS 16.1）
- サードパーティーライブラリーの利用：オープンソースのものに限り制限しない

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 課題取り組み方法

Issues を確認した上、本プロジェクトを [**Duplicate** してください](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository)（Fork しないようにしてください。必要ならプライベートリポジトリーにしても大丈夫です）。今後のコミットは全てご自身のリポジトリーで行ってください。

コードチェックの課題 Issue は全て [`課題`](https://github.com/yumemi/ios-engineer-codecheck/milestone/1) Milestone がついており、難易度に応じて Label が [`初級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A初級+milestone%3A課題)、[`中級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A中級+milestone%3A課題+) と [`ボーナス`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3Aボーナス+milestone%3A課題+) に分けられています。課題の必須／選択は下記の表とします：

|   | 初級 | 中級 | ボーナス
|--:|:--:|:--:|:--:|
| 新卒／未経験者 | 必須 | 選択 | 選択 |
| 中途／経験者 | 必須 | 必須 | 選択 |


課題 Issueをご自身のリポジトリーにコピーするGitHub Actionsをご用意しております。  
[こちらのWorkflow](./.github/workflows/copy-issues.yml)を[手動でトリガーする](https://docs.github.com/ja/actions/managing-workflow-runs/manually-running-a-workflow)ことでコピーできますのでご活用下さい。

課題が完成したら、リポジトリーのアドレスを教えてください。

## 参考記事

提出された課題の評価ポイントに関しては、[こちらの記事](https://qiita.com/lovee/items/d76c68341ec3e7beb611)に詳しく書かれてありますので、ぜひご覧ください。
ライブラリの利用に関しては [こちらの記事](https://qiita.com/ykws/items/b951a2e24ca85013e722)も参照ください。

## Swiftの勉強期間
2022年9月:
- Swiftを独学で勉強開始。
2022年10月 - 12月
- Firebase(Auth, Firestore, Storage), MVVMのアーキテクチャでメモアプリをリリース
- URL: https://github.com/kasiwa-mesi/SampleEmailLogin
- 上記のGithubリポジトリに関して、知り合いのiOSエンジニアにコードレビューを依頼して、指摘していただいた内容を修正。

## 使用したライブラリ
### CocoaPods
Swiftでリアクティブプログラミングをするために以下のライブラリを導入
[RxSwift, RxCocoa](https://github.com/ReactiveX/RxSwift)
[NSObject+Rx](https://github.com/RxSwiftCommunity/NSObject-Rx)
[RxOptional](https://github.com/RxSwiftCommunity/RxOptional)

## 注意して取り組んだ所
### MVVMのアーキテクチャを意識
既存のコードをMVVM(Model - View - ViewModel)の構成にリファクタリング。
MVVMに基づいて、以下の点を注意した
- ViewControllerにUIKitのパーツ以外のデータ(プロパティ)を持たない
- ViewControllerにロジックを書かない(ex. if文)

### エラーの抜け目が無いように意識
GithubAPIを叩くときに「サーバーからエラーレスポンスをもらう場合」、「HTTPレスポンスコードが200番台出なかった場合」のエラーハンドリングを実装

さらに、エラーが発生した場合、ユーザーにAlertを用いてエラー内容を伝えるように実装

![](https://gyazo.com/6c6ac95f388051cf84f098514514284b/raw)

### ネストを深くしない
以下のように不正な入力があれば、早期returnするように改善した。また、できる限りメソッドがやるべき実装を最後に記述した。
```
func hoge(input: String?) {
 if 不正な入力か判定 {
   return
 }
 if 不正な入力か判定 {
   return
 }
 if 不正な入力か判定 {
   return
 }

 本来このメソッドがやるべき処理
}
```

### ハードコーディングを避ける
各ファイルで使い回すダイアログの「"了解しました"」という文字列に関しては、修正するとき手間がかかる。

以下のようにextensionでまとめた。
```
extension String {
  static var ok: String { "了解しました" }
}
```

## 追加した機能
### AppDelegateでオンライン・オフラインを監視
NSPathMonitorを利用してオンライン・オフラインを監視する機能を実装した。

理由としては、検索バーで文字を入力する前に通信状況をユーザーに伝える方がユーザー体験が良いからである。

![](https://gyazo.com/e4f73e1057ef56b7bf19d4d50332d240/raw)

## 時間に余裕があれば何をするか
### テストの追加
RepositoryModel型がJSONを正しくdecodeできるか判断するテストしか存在していない。

通信を代用するスタブを用いて、「成功した場合」, 「通信に失敗した場合」, 「レスポンスのデコードに失敗した場合」, 「エラーレスポンスを受け取った場合」の通信結果の処理に対するテストを作る

### UIのブラッシュアップ
現在のアプリはシンプルなデザインである。

利便性を上げるために、以下の機能を追加したい。
- 検索して表示するTableViewのCellに画像、リポジトリ名、プロジェクト言語を表示するように変更したい。
- また、検索したリポジトリ一覧を更新日で並び替える機能を実装したい