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
    
    func fetchRepositories(word: String, completion: @escaping ([RepositoryModel]?, NSError?, (message: String, status: Int)?, String?) -> Void) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(word)") else {
            completion(nil, nil, nil, String.invalidURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let responseError = err as NSError? {
                completion(nil, responseError, nil, nil)
                return
            }
            
            let response = res as? HTTPURLResponse
            let status = response?.statusCode ?? 0
            let message = HTTPURLResponse.localizedString(forStatusCode: status)
            guard status >= 200 && status <= 299 else {
                completion(nil, nil, (message, status), nil)
                return
            }
            
            let fixedData = data ?? Data()
            do {
                let githubResponse = try JSONDecoder().decode(GithubResponse.self, from: fixedData)
                let models = githubResponse.items
                completion(models, nil, nil, nil)
            } catch let parseError as NSError? {
                completion(nil, parseError, nil, nil)
            }
        }.resume()
    }
    
    func getImage(imageURL: String, completion: @escaping (Data?, NSError?, (message: String, status: Int)?, String?) -> Void) {
        guard let url = URL(string: imageURL) else {
            completion(nil, nil, nil, String.invalidImageURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            if let error = err as NSError? {
                completion(nil, error, nil, nil)
                return
            }
            
            let response = res as? HTTPURLResponse
            let status = response?.statusCode ?? 0
            let message = HTTPURLResponse.localizedString(forStatusCode: status)
            guard status >= 200 && status <= 299 else {
                completion(nil, nil, (message, status), nil)
                return
            }
            
            completion(data, nil, nil, nil)
        }.resume()
    }
}
