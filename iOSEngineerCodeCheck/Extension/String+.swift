//
//  String+.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension String {
    static var ok: String { "了解しました" }
    static var errorTitle: String { "エラーコード: " }
    static var searchBarText: String { "GitHubのリポジトリを検索できるよー" }
    static var invalidURL: String { "他のキーワードを入力してください。半角英数字のみご利用いただけます。" }
    static var invalidImageURL: String { "リポジトリの画像がうまく読み込めませんでした。" }
    static var isEmptyWord: String { "検索バーに文字が入力されていません" }
    static var notSetLanguageLabel: String { "Not Set Language" }
    static var languageLabel: String { "Written in" }
    static var starsCountLabel: String { "stars" }
    static var watchesCountLabel: String { "watches" }
    static var forksCountLabel: String { "forks" }
    static var openIssuesCountLabel: String { "open issues" }
}
