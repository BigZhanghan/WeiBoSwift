//
//  ProfileTableViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/27.
//

import UIKit

class ProfileTableViewController: VisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupInfo("visitordiscover_image_profile", "登录后，你的微博、相册、个人资料会显示在这里，展示给别人")
    }

}
