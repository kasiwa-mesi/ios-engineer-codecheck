//
//  DetailRepositoryViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol DetailRepositoryViewModelOutput {
    var repository: RepositoryModel { get }
}

final class DetailRepositoryViewModel: DetailRepositoryViewModelOutput {
    private var _repository: RepositoryModel
    var repository: RepositoryModel {
        get {
            return _repository
        }
    }
    
    init(repository: RepositoryModel) {
        self._repository = repository
    }
}
