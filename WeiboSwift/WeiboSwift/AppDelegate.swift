//
//  AppDelegate.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        window?.rootViewController = MainTabBarController()
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

