//
//  WelcomeViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/12.
//

import UIKit
import SnapKit
import Kingfisher

class WelcomeViewController: UIViewController {
    
    private lazy var bgImageView = UIImageView("ad_background")
    
    private lazy var headImageView: UIImageView = {
        let avatar = UIImageView("avatar_default")
        avatar.layer.cornerRadius = 45
        avatar.layer.masksToBounds = true
        return avatar
    }()
    
    private lazy var welcomeLabel: UILabel = UILabel(title: "欢迎回来", fontSize: 18)
    
    override func loadView() {
        view = bgImageView
        
        setupUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headImageView.kf.setImage(with: UserAccountViewModel.shared.avatarUrl, placeholder: UIImage(named: "avatar_default"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        headImageView.snp.updateConstraints { make in
            make.bottom.equalTo(view).offset(-view.bounds.height + 200)
        }
        
        welcomeLabel.alpha = 0
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10) {
            self.view.layoutIfNeeded()
        } completion: { Void in
            UIView.animate(withDuration: 0.3) {
                self.welcomeLabel.alpha = 1.0
            } completion: { (_) in
                print("欢迎回来")
                NotificationCenter.default.post(name: Notification.Name(SwitchRootViewControllerNotification), object: nil)
            }
        }
    }
}

extension WelcomeViewController {
    private func setupUI() {
        view.addSubview(headImageView)
        view.addSubview(welcomeLabel)
        
        headImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(view).offset(-200)
            make.size.equalTo(90)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(headImageView)
            make.top.equalTo(headImageView.snp.bottom).offset(16)
        }
    }
}
