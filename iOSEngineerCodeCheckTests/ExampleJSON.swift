//
//  ExampleJSON.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kasiwa on 2022/12/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

extension RepositoryModel {
    static var exampleJSON: String {
        return """
    {
      "id": 44838949,
      "name": "swift",
      "full_name": "apple/swift",
      "owner": {
        "avatar_url": "https://avatars.githubusercontent.com/u/10639145?v=4"
      },
      "stargazers_count": 61449,
      "watchers_count": 61449,
      "forks_count": 9888,
      "open_issues_count": 6313,
    }
    """
    }
}
