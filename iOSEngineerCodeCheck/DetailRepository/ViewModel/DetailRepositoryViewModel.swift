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

protocol DetailRepositoryViewModelInput {
    func show(validationMessage: String)
    func showErrorAlert(code: String, message: String)
}

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
    
    private var input: DetailRepositoryViewModelInput!
    init(repository: RepositoryModel, input: DetailRepositoryViewModelInput) {
        self._repository = repository
        self.input = input
    }
    
    func getImage() {
        API.shared.getImage(imageURL: repository.owner.imageURL) { [weak self] data, error, res, invalidImageURL in
            if let error {
                self?.input.showErrorAlert(code: error.code.description, message: error.localizedDescription)
                return
            }
            
            if let res {
                self?.input.showErrorAlert(code: res.status.description, message: res.message)
                return
            }
            
            if let invalidImageURL {
                self?.input.show(validationMessage: invalidImageURL)
                return
            }
            
            self?._updateImageData.accept(data ?? Data())
        }
    }
}
