//
//  VisitorTableViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/28.
//

import UIKit

class VisitorTableViewController: UITableViewController {
    
    var visitorView: VisitorView?
    
    private var userLogin = UserAccountViewModel.shared.userLogin
    
    override func loadView() {
        userLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupVisitorView() {
        visitorView = VisitorView()
        view = visitorView
        view.backgroundColor = BackColor
        
        visitorView?.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(visitorViewRegister))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(visitorViewLogin))
    }
}

extension VisitorTableViewController: VisitorViewDelegate {
    
    @objc func visitorViewRegister() {
        print("VisitorTableViewController + 注册")
    }
    
    @objc func visitorViewLogin() {
        print("VisitorTableViewController + 登录")
        let oauth = OAuthViewController()
        let nav = UINavigationController(rootViewController: oauth)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
}
