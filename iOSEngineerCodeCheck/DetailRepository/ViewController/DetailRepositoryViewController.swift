//
//  DetailRepositoryViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController {
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var LanguageLabel: UILabel!

    @IBOutlet weak var StarsCountLabel: UILabel!
    @IBOutlet weak var WatchersCountLabel: UILabel!
    @IBOutlet weak var ForksCountLabel: UILabel!
    @IBOutlet weak var OpenIssuesCountLabel: UILabel!
    
    var vc: SearchRepositoryViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repository = vc.repositories[vc.index]
        
        LanguageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        StarsCountLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        WatchersCountLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        ForksCountLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        OpenIssuesCountLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let repository = vc.repositories[vc.index]
        
        TitleLabel.text = repository["full_name"] as? String
        
        if let owner = repository["owner"] as? [String: Any] {
            if let imageURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, res, err) in
                    let image = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ImageView.image = image
                    }
                }.resume()
            }
        }
        
    }
}
