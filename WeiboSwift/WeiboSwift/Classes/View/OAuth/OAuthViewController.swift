//
//  OAuthViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/8.
//

import UIKit
import WebKit
import Toast_Swift

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
    
    deinit {
        print("deinit")
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
        
        UserAccountViewModel.shared.loadAccesToken(code) { isSuccess in
            print(Thread.current)
            if !isSuccess {
                self.webView.makeToast("授权失败")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: {
                    print(Thread.current)
                    self.dismiss(animated: true)
                })
                return
            }
            
            print("授权成功")
            
            self.dismiss(animated: false) {
                NotificationCenter.default.post(name: Notification.Name(SwitchRootViewControllerNotification), object: "welcome")
            }
        }
        
        decisionHandler(.cancel)
    }
    
    // MARK: - 页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.webView.makeToastActivity(.center)
    }
    
    // MARK: - 页面加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.hideToastActivity()
    }
    
    // MARK: - 页面加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.webView.hideToastActivity()
    }
}


