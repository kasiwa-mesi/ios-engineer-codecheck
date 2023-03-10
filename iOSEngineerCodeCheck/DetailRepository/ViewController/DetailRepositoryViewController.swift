//
//  DetailRepositoryViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift

final class DetailRepositoryViewController: UIViewController {
    @IBOutlet private weak var ImageView: UIImageView!
    
    @IBOutlet private weak var TitleLabel: UILabel!
    
    @IBOutlet private weak var LanguageLabel: UILabel!
    
    @IBOutlet private weak var StarsCountLabel: UILabel!
    @IBOutlet private weak var WatchersCountLabel: UILabel!
    @IBOutlet private weak var ForksCountLabel: UILabel!
    @IBOutlet private weak var OpenIssuesCountLabel: UILabel!
    
    private var viewModel: DetailRepositoryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LanguageLabel.text = "\(String.languageLabel) \(viewModel.repository.language ?? "")"
        StarsCountLabel.text = "\(viewModel.repository.starsCount) \(String.starsCountLabel)"
        WatchersCountLabel.text = "\(viewModel.repository.watchersCount) \(String.watchesCountLabel)"
        ForksCountLabel.text = "\(viewModel.repository.forksCount) \(String.forksCountLabel)"
        OpenIssuesCountLabel.text = "\(viewModel.repository.openIssuesCount) \(String.openIssuesCountLabel)"
        TitleLabel.text = viewModel.repository.fullName
        
        viewModel.getImage()
        viewModel.watchLanguageLabel()
    }
    
    static func makeFromStoryboard(repository: RepositoryModel) -> DetailRepositoryViewController {
        guard let vc = UIStoryboard.init(name: "DetailRepository", bundle: nil).instantiateInitialViewController() as? DetailRepositoryViewController else {
            fatalError()
        }
        vc.setupViewModel(repository: repository)
        return vc
    }
    
    func setupViewModel(repository: RepositoryModel) {
        viewModel = DetailRepositoryViewModel(repository: repository, input: self)
        
        viewModel.updateImageDataObservable
            .bind(to: Binder(self) { vc, data in
                let image = UIImage(data: data)
                self.ImageView.image = image
            }).disposed(by: rx.disposeBag)
        
        viewModel.updateLanguageLabelObservable
            .bind(to: Binder(self) { vc, languageLabel in
                self.LanguageLabel.text = languageLabel
            }).disposed(by: rx.disposeBag)
    }
}

extension DetailRepositoryViewController: DetailRepositoryViewModelInput {
    func show(validationMessage: String) {
        let gotItAction = UIAlertAction(title: String.ok, style: .default)
        self.showAlert(title: validationMessage, message: "", actions: [gotItAction])
    }
    
    func showErrorAlert(code: String, message: String) {
        let gotItAction = UIAlertAction(title: String.ok, style: .default)
        DispatchQueue.main.async {
            self.showAlert(title: String.errorTitle + code, message: message, actions: [gotItAction])
        }
    }
}
