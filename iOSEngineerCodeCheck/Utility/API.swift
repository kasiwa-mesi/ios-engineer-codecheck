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
    
    func fetchRepositories(word: String, completion: @escaping ([RepositoryModel]?, NSError?, (message: String, status: Int)?) -> Void) {
        let url = "https://api.github.com/search/repositories?q=\(word)"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
            if let responseError = err as NSError? {
                completion(nil, responseError, nil)
                return
            }
            
            let response = res as? HTTPURLResponse
            let status = response?.statusCode ?? 0
            let message = HTTPURLResponse.localizedString(forStatusCode: status)
            guard status >= 200 && status <= 299 else {
                completion(nil, nil, (message, status))
                return
            }
            
            let fixedData = data ?? Data()
            do {
                let githubResponse = try JSONDecoder().decode(GithubResponse.self, from: fixedData)
                let models = githubResponse.items
                completion(models, nil, nil)
            } catch let parseError as NSError? {
                completion(nil, parseError, nil)
            }
        }.resume()
    }
    
    func getImage(repository: RepositoryModel, completion: @escaping (Data?, NSError?, (message: String, status: Int)?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: repository.owner.imageURL)!) { (data, res, err) in
            if let error = err as NSError? {
                completion(nil, error, nil)
                return
            }
            
            let response = res as? HTTPURLResponse
            let status = response?.statusCode ?? 0
            let message = HTTPURLResponse.localizedString(forStatusCode: status)
            guard status >= 200 && status <= 299 else {
                completion(nil, nil, (message, status))
                return
            }
            
            completion(data, nil, nil)
        }.resume()
    }
}
