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
        let url = "https://api.github.com/search/repositories?q=\(word)"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            if let responseError = err as NSError? {
                completion(nil, responseError)
                return
            }
            
            let fixedData = data ?? Data()
            do {
                let githubResponse = try JSONDecoder().decode(GithubResponse.self, from: fixedData)
                let models = githubResponse.items
                completion(models, nil)
            } catch let parseError as NSError? {
                completion(nil, parseError)
            }
        }.resume()
    }
    
    func getImage(repository: RepositoryModel, completion: @escaping (Data, NSError?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: repository.owner.imageURL)!) { (data, res, err) in
            let error = err as? NSError
            completion(data ?? Data(), error)
        }.resume()
    }
}
