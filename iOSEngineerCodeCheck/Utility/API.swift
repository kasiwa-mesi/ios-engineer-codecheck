//
//  API.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/26.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

final class API {
    static let shared = API()
    private init() {}
    
    func fetchRepositories(word: String, completion: @escaping ([RepositoryModel]?, NSError?) -> Void) {
        print(word)
        if word.count != 0 {
            let url = "https://api.github.com/search/repositories?q=\(word)"
            print(url)
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                if let data = data {
                    print("Data: \(data)")
                    do {
                        let githubResponse = try JSONDecoder().decode(GithubResponse.self, from: data)
                        let models = githubResponse.items
                        print("GithubResponse: \(githubResponse)")
                        print("Models: \(models)")
                        completion(models, nil)
                    } catch let error {
                        print(error)
                        completion(nil, nil)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getImage(repository: RepositoryModel, completion: @escaping (Data, NSError?) -> Void) {
        if let owner = repository.owner as? OwnerModel {
            if let imageURL = owner.imageURL as? String {
                URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, res, err) in
                    let error = err as? NSError
                    completion(data ?? Data(), error)
                }.resume()
            }
        }
    }
}
