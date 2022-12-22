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
        
        let repo = vc.repo[vc.idx]
        
        LanguageLabel.text = "Written in \(repo["language"] as? String ?? "")"
        StarsCountLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WatchersCountLabel.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        ForksCountLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        OpenIssuesCountLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let repo = vc.repo[vc.idx]
        
        TitleLabel.text = repo["full_name"] as? String
        
        if let owner = repo["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ImageView.image = img
                    }
                }.resume()
            }
        }
        
    }
}
