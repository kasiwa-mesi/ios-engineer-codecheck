//
//  Router.swift
//  iOSEngineerCodeCheck
//
//  Created by kasiwa on 2022/12/22.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class Router {
    static let shared: Router = .init()
    private init() {}
    
    private var window: UIWindow?
    
    func showRoot(window: UIWindow?) {
        let vc = SearchRepositoryViewController.makeFromStoryboard()
        self.pushNavigate(vc: vc, window: window)
    }
    
    //    func showOffline(window: UIWindow?) {
    //        let vc = OfflineViewController.makeFromStoryboard()
    //        self.pushNavigate(vc: vc, window: window)
    //    }
}

private extension Router {
    func show(from: UIViewController, next: UIViewController, animated: Bool = true) {
        if let nav = from.navigationController {
            nav.pushViewController(next, animated: animated)
        } else {
            from.present(next, animated: animated, completion: nil)
        }
    }
    
    func pushNavigate(vc: UIViewController, window: UIWindow?) {
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        self.window = window
    }
}
