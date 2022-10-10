//
//  OAuthViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/8.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
    
    private lazy var webView = WKWebView()
    
    override func loadView() {
        view = webView
        
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(auotFill))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        webView.navigationDelegate = self
        webView.load(URLRequest(url: NetwokAPI.oauthURL))
    }
    
    /// 关闭授权页面
    @objc private func close() {
        dismiss(animated: true)
    }
    
    /// 自动填充账号密码
    @objc private func auotFill() {
        let js = "document.getElementById('loginName').value = '17749552181';" +
        "document.getElementById('loginPassword').value = 'jnr#0710';"
        webView.evaluateJavaScript(js)
    }
}

// MARK: - WKNavigationDelegate
extension OAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url, url.host == "www.baidu.com" else {
            decisionHandler(.allow)
            return
        }
        
        guard let query = url.query, query.hasPrefix("code=") else {
            print("取消授权")
            decisionHandler(.cancel)
            dismiss(animated: true)
            return
        }
                
        let code = String(query["code=".endIndex...])
        print(code)
        
        NetwokAPI.loadAccessToken(code) { res in
            print(res)
        }
        
        decisionHandler(.cancel)
    }
}


