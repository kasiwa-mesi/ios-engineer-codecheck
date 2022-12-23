//
//  SearchRepositoryViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var repositories: [[String: Any]]=[]
    var task: URLSessionTask?
    var word: String!
    var url: String!
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
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
    func searchRepository(word: String) {
        if word.count != 0 {
            url = "https://api.github.com/search/repositories?q=\(word)"
            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                if let object = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let items = object["items"] as? [[String: Any]] {
                        self.repositories = items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task?.resume()
        }
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
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
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
        word = searchBar.text!
        searchRepository(word: word)
    }
}
