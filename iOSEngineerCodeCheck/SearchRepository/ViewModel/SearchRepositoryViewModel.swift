//
//  SearchRepositoryViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/23.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

protocol SearchRepositoryViewModelInput {
    var didSelectObservable: Observable<Int> { get }
}

protocol SearchRepositoryViewModelOutput {
    var loadingObservable: Observable<Bool> { get }
    var selectRepositoryModelObservable: Observable<RepositoryModel> { get }
    var updateRepositoryModelsObservable: Observable<[RepositoryModel]> { get }
    var repositories: [RepositoryModel] { get }
    var word: String { get }
    var url: String { get }
    var index: Int { get }
}

final class SearchRepositoryViewModel: SearchRepositoryViewModelOutput, HasDisposeBag {
    private let _loading: PublishRelay<Bool> = .init()
    lazy var loadingObservable: Observable<Bool> = _loading.asObservable()
    private let _selectRepositoryModel: PublishRelay<RepositoryModel> = .init()
    lazy var selectRepositoryModelObservable: Observable<RepositoryModel> = _selectRepositoryModel.asObservable()
    private let _updateRepositoryModels: PublishRelay<[RepositoryModel]> = .init()
    lazy var updateRepositoryModelsObservable: Observable<[RepositoryModel]> = _updateRepositoryModels.asObservable()

    private var _repositories: [RepositoryModel] = []
    var repositories: [RepositoryModel] {
        get {
            return _repositories
        }
    }

    private var _word: String = ""
    var word: String {
        get {
            return _word
        }
    }

    private var _url: String = ""
    var url: String {
        get {
            return _url
        }
    }

    private var _index: Int = 0
    var index: Int {
        get {
            return _index
        }
    }

    private var input: SearchRepositoryViewModelInput!
    init(input: SearchRepositoryViewModelInput) {
        self.input = input
        
        input.didSelectObservable
            .filter { $0 < self.repositories.count }
            .map { self.repositories[$0] }
            .bind(to: _selectRepositoryModel).disposed(by: disposeBag)
    }
    
    func fetchRepositories(word: String) {
        if word.count != 0 {
            let url = "https://api.github.com/search/repositories?q=\(word)"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                if let data = data {
                    print("Data: \(data)")
                    let githubResponse = try? JSONDecoder().decode(GithubResponse.self, from: data)
                    print("GithubResponse: \(githubResponse)")
                    let models = githubResponse?.items
                    print("Models: \(models)")
                    self._repositories = models ?? []
                    self._updateRepositoryModels.accept(self.repositories)
                }
            }
            task.resume()
        }
    }
}