//
//  Validator.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

enum Validator {
    case isEmptyWord
    
    init?(word: String?) {
        if let word {
            guard !word.isEmpty else {
                self = .isEmptyWord
                return
            }
        }
        
        return nil
    }
    
    var alertMessage: String {
        switch self {
        case .isEmptyWord:
            return "検索バーに文字が入力されていません"
        }
    }
}
