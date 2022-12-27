//
//  DetailRepositoryViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

protocol DetailRepositoryViewModelOutput {
    var repository: RepositoryModel { get }
    var updateImageDataObservable: Observable<Data> { get }
}

final class DetailRepositoryViewModel: DetailRepositoryViewModelOutput {
    private var _repository: RepositoryModel
    var repository: RepositoryModel {
        get {
            return _repository
        }
    }
    
    private let _updateImageData: PublishRelay<Data> = .init()
    lazy var updateImageDataObservable: Observable<Data> = _updateImageData.asObservable()
    
    init(repository: RepositoryModel) {
        self._repository = repository
    }
    
    func getImage(){
        API.shared.getImage(repository: repository) { data, error in
            self._updateImageData.accept(data)
        }
    }
}
