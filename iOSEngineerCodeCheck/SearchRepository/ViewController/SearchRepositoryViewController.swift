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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var repositories: [RepositoryModel] = []
    private var task: URLSessionTask?
    private var word: String = ""
    private var url: String = ""
    var index: Int = 0
    
    private let didSelectRelay: PublishRelay<Int> = .init()
    
    private var viewModel: SearchRepositoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
        print("起動")
        
        setupViewModel()
    }
    
    static func makeFromStoryboard() -> SearchRepositoryViewController {
        guard let vc = UIStoryboard.init(name: "SearchRepository", bundle: nil).instantiateInitialViewController() as? SearchRepositoryViewController else {
            fatalError()
        }
        return vc
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let vc = segue.destination as! DetailRepositoryViewController
            //dtl.vc1 = self
        }
    }
}

private extension SearchRepositoryViewController {
    func setupViewModel() {
        viewModel = SearchRepositoryViewModel(input: self)
        
        viewModel.updateRepositoryModelsObservable
            .bind(to: Binder(self) { vc, _ in
                print("メモを更新")
                vc.tableView.isHidden = false
                vc.tableView.dataSource = self
                vc.tableView.delegate = self
                vc.tableView.reloadData()
            }).disposed(by: rx.disposeBag)
        
        viewModel.selectRepositoryModelObservable
            .bind(to: Binder(self) { vc, memo in
                print("Cellをクリック")
            }).disposed(by: rx.disposeBag)
    }
}

extension SearchRepositoryViewController: SearchRepositoryViewModelInput {
    var didSelectObservable: Observable<Int> {
        didSelectRelay.asObservable()
    }
}

extension SearchRepositoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}

extension SearchRepositoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Cell更新")
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        print("Repository: \(repository)")
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row
        return cell
    }
}

extension SearchRepositoryViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        word = searchBar.text ?? ""
        viewModel.fetchRepositories(word: word)
    }
}
