//
//  SearchRepositoryViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxCocoa
import RxOptional
import RxSwift
import UIKit

final class SearchRepositoryViewController: UIViewController {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        }
    }
    
    private let didSelectRelay: PublishRelay<Int> = .init()
    
    private var viewModel: SearchRepositoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = String.searchBarText
        searchBar.delegate = self
        
        setupViewModel()
    }
    
    static func makeFromStoryboard() -> SearchRepositoryViewController {
        guard let vc = UIStoryboard.init(name: "SearchRepository", bundle: nil).instantiateInitialViewController() as? SearchRepositoryViewController else {
            fatalError()
        }
        return vc
    }
}

private extension SearchRepositoryViewController {
    func setupViewModel() {
        viewModel = SearchRepositoryViewModel(input: self)
        
        viewModel.updateRepositoryModelsObservable
            .bind(to: Binder(self) { vc, _ in
                vc.indicator.isHidden = true
                vc.tableView.isHidden = false
                vc.tableView.dataSource = self
                vc.tableView.delegate = self
                vc.tableView.reloadData()
            }).disposed(by: rx.disposeBag)
        
        viewModel.selectRepositoryModelObservable
            .bind(to: Binder(self) { vc, repository in
                Router.shared.showDetailRepository(from: vc, repository: repository)
            }).disposed(by: rx.disposeBag)
        
        viewModel.loadingObservable
            .bind(to: Binder(self) { vc, loading in
                vc.tableView.isHidden = loading
                vc.indicator.isHidden = !loading
                vc.indicator.startAnimating()
            }).disposed(by: rx.disposeBag)
    }
}

extension SearchRepositoryViewController: SearchRepositoryViewModelInput {
    var didSelectObservable: Observable<Int> {
        didSelectRelay.asObservable()
    }
    
    func show(validationMessage: String) {
        let gotItAction = UIAlertAction(title: String.ok, style: .default)
        self.showAlert(title: validationMessage, message: "", actions: [gotItAction])
    }
}

extension SearchRepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRelay.accept(indexPath.item)
    }
}

extension SearchRepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let repository = viewModel.repositories[indexPath.item]
        cell.configure(repository: repository)
        return cell
    }
}

extension SearchRepositoryViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.word = searchBar.text ?? ""
        viewModel.fetchRepositories(word: viewModel.word)
    }
}
