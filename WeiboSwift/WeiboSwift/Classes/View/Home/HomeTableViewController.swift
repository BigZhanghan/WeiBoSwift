//
//  HomeTableViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/27.
//

import UIKit

class HomeTableViewController: VisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupInfo(nil, "关注一些人，回这里看看有什么惊喜")
    }
}
