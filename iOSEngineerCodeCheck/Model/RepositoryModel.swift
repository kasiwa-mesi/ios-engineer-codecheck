//
//  RepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/24.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GithubResponse: Codable {
    let items: [RepositoryModel]?
}

struct RepositoryModel: Codable {
    let id: Int
    let name: String
    let fullName: String
    var urlStr: String { "https://github.com/\(fullName)" }
    let language: String
    let starsCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: OwnerModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case language
        case starsCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case owner
    }
}

struct OwnerModel: Codable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "avatar_url"
    }
}
