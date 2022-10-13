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
        
        window?.rootViewController = rootViewController
        
        setupAppearence()
        
        window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(SwitchRootViewControllerNotification),
            object: nil,
            queue: nil
        ) { (notification) in
            
            let vc = notification.object != nil ? WelcomeViewController() : MainTabBarController()
            self.window?.rootViewController = vc
        }
                
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(SwitchRootViewControllerNotification), object: nil)
    }
    
    private func setupAppearence() {
        UITabBar.appearance().tintColor = MainAppearance
        UINavigationBar.appearance().tintColor = MainAppearance
    }
}

extension AppDelegate {
    private var rootViewController: UIViewController {
        if UserAccountViewModel.shared.userLogin {
            return isNewVersion ? NewFeatureCollectionViewController() : WelcomeViewController()
        }
        return MainTabBarController()
    }
    
    private var isNewVersion: Bool {
        
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let version = Double(currentVersion)!
        
        let sandboxVersion = "sandboxVersion"
        let newVersion = UserDefaults.standard.double(forKey: sandboxVersion)
        
        UserDefaults.standard.set(version, forKey: sandboxVersion)
        
        return version > newVersion
    }
}
