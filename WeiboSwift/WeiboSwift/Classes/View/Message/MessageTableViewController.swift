//
//  MessageTableViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/27.
//

import UIKit

class MessageTableViewController: VisitorTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView?.setupInfo("visitordiscover_image_message", "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知")
    }

}
