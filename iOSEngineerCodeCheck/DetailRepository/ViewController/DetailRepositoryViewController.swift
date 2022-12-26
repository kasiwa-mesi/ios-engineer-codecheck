//
//  DetailRepositoryViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController {
    @IBOutlet private weak var ImageView: UIImageView!

    @IBOutlet private weak var TitleLabel: UILabel!
    
    @IBOutlet private weak var LanguageLabel: UILabel!

    @IBOutlet private weak var StarsCountLabel: UILabel!
    @IBOutlet private weak var WatchersCountLabel: UILabel!
    @IBOutlet private weak var ForksCountLabel: UILabel!
    @IBOutlet private weak var OpenIssuesCountLabel: UILabel!
    
    var vc: SearchRepositoryViewController!
    
    private var viewModel: DetailRepositoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        LanguageLabel.text = "Written in \(viewModel.repository.language)"
        StarsCountLabel.text = "\(viewModel.repository.starsCount) stars"
        WatchersCountLabel.text = "\(viewModel.repository.watchersCount) watchers"
        ForksCountLabel.text = "\(viewModel.repository.forksCount) forks"
        OpenIssuesCountLabel.text = "\(viewModel.repository.openIssuesCount) open issues"
        getImage()
        
    }
    
    static func makeFromStoryboard(repository: RepositoryModel) -> DetailRepositoryViewController {
        guard let vc = UIStoryboard.init(name: "DetailRepository", bundle: nil).instantiateInitialViewController() as? DetailRepositoryViewController else {
            fatalError()
        }
        vc.setupViewModel(repository: repository)
        return vc
    }
    
    func setupViewModel(repository: RepositoryModel) {
        viewModel = DetailRepositoryViewModel(repository: repository)
    }
    
    func getImage(){
        TitleLabel.text = viewModel.repository.fullName
        
        if let owner = viewModel.repository.owner as? OwnerModel {
            if let imageURL = owner.imageURL as? String {
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
