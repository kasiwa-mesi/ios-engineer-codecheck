//
//  OfflineViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/28.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class OfflineViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func makeFromStoryboard() -> OfflineViewController {
        guard let vc = UIStoryboard.init(name: "Offline", bundle: nil).instantiateInitialViewController() as? OfflineViewController else {
            fatalError()
        }
        return vc
    }
}
