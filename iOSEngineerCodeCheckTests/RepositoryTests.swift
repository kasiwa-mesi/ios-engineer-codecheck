//
//  RepositoryTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kasiwa on 2022/12/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import XCTest
@testable import iOSEngineerCodeCheck

class RepositoryTests: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = RepositoryModel.exampleJSON.data(using: .utf8)!
        do {
            let repository = try jsonDecoder.decode(RepositoryModel.self, from: data)
            XCTAssertEqual(repository.id, 44838949)
            XCTAssertEqual(repository.name, "swift")
            XCTAssertEqual(repository.fullName, "apple/swift")
            XCTAssertEqual(repository.starsCount, 61449)
            XCTAssertEqual(repository.watchersCount, 61449)
            XCTAssertEqual(repository.forksCount, 9888)
            XCTAssertEqual(repository.openIssuesCount, 6313)
            XCTAssertEqual(repository.language, "C++")
            XCTAssertEqual(repository.owner.imageURL, "https://avatars.githubusercontent.com/u/10639145?v=4")
        } catch let error {
            print("ParseError: \(error)")
        }
    }
}
