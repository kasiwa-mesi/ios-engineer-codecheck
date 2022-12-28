//
//  AppDelegate.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import Network

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.kasiwa")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                DispatchQueue.main.async {
                    Router.shared.showRoot(window: UIWindow(frame: UIScreen.main.bounds))
                }
            } else {
                DispatchQueue.main.async {
                    Router.shared.showOffline(window: UIWindow(frame: UIScreen.main.bounds))
                }
            }
        }
        
        monitor.start(queue: queue)
        
        return true
    }
}

