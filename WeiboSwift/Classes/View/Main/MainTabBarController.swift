//
//  MainTabBarController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/27.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private lazy var composeBtn: UIButton = {
        let btn = UIButton("tabbar_compose_icon_add", "tabbar_compose_button")
        btn.addTarget(self, action: #selector(clickComposeBtn), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        setupComposeBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.bringSubviewToFront(composeBtn)
    }
    
    /// 点击事件
    @objc private func clickComposeBtn() {
        print("点我了")
    }
}

extension MainTabBarController {
    
    private func setupComposeBtn() {
        tabBar.addSubview(composeBtn)
        
        let width = tabBar.bounds.width / CGFloat(children.count) - 1
        composeBtn.frame = CGRectInset(tabBar.bounds, width * 2, 0)
        
    }

    private func addChildViewControllers() {
        addChildViewController(HomeTableViewController(), "首页", "tabbar_home")
        addChildViewController(MessageTableViewController(), "消息", "tabbar_message")
        addChild(UIViewController())
        addChildViewController(DiscoverTableViewController(), "发现", "tabbar_discover")
        addChildViewController(ProfileTableViewController(), "我的", "tabbar_profile")
        
        tabBar.tintColor = .orange
    }
    
    private func addChildViewController(_ vc: UIViewController, _ title: String, _ imageName: String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        let nav = UINavigationController(rootViewController: vc)
        addChild(nav)
    }
}
