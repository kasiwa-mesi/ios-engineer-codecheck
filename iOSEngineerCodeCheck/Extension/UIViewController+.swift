//
//  UIViewController+.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}
