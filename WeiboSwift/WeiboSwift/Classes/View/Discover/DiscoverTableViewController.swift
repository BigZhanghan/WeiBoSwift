//
//  DiscoverTableViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/27.
//

import UIKit

class DiscoverTableViewController: VisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupInfo("visitordiscover_image_message", "登录后，最新最热微博尽在掌握，不再会与事实潮流擦肩而过")
    }

}
