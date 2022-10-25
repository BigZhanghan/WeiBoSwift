//
//  VisitorView.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/28.
//

import UIKit
import SnapKit

protocol VisitorViewDelegate: NSObjectProtocol {
    func visitorViewRegister()
    func visitorViewLogin()
}

class VisitorView: UIView {
    
    weak var delegate: VisitorViewDelegate?
    
    @objc private func clickRegister() {
        delegate?.visitorViewRegister()
    }
    
    @objc private func clickLogin() {
        delegate?.visitorViewLogin()
    }
    
    func setupInfo(_ imageName: String?, _ title: String) {
        messageLabel.text = title
        guard let imgName = imageName else {
            startAnimation()
            return
        }
        iconView.image = UIImage(named: imgName)
        homeView.isHidden = true
        sendSubviewToBack(maskIconView)
    }
    
    private func startAnimation() {
        let an = CABasicAnimation(keyPath: "transform.rotation")
        an.toValue = 2 * Double.pi
        an.repeatCount = MAXFLOAT
        an.duration = 20
        an.isRemovedOnCompletion = false
        iconView.layer.add(an, forKey: nil)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private lazy var iconView = UIImageView("visitordiscover_feed_image_smallicon")
    
    private lazy var maskIconView = UIImageView("visitordiscover_feed_mask_smallicon")
    
    private lazy var homeView = UIImageView("visitordiscover_feed_image_house")
    
    private lazy var messageLabel: UILabel = UILabel(title: "关注一些人，回这里看看有什么惊喜")
    
    private lazy var registerBtn: UIButton = UIButton(title: "注册", color: .orange, backImage: "common_button_white_disable")
    
    private lazy var loginBtn: UIButton = UIButton(title: "登录", color: .darkGray, backImage: "common_button_white_disable")
}

extension VisitorView {
    private func setupUI() {
        backgroundColor = UIColor(white: 237 / 255.0, alpha: 1.0)
        
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(homeView)
        addSubview(messageLabel)
        addSubview(registerBtn)
        addSubview(loginBtn)
        
        iconView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-60)
        }
        
        homeView.snp.makeConstraints { make in
            make.center.equalTo(iconView)
        }

        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(iconView)
            make.top.equalTo(iconView.snp.bottom).offset(16)
            make.width.equalTo(230)
            make.height.equalTo(36)
        }

        registerBtn.snp.makeConstraints { make in
            make.left.equalTo(messageLabel)
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }

        loginBtn.snp.makeConstraints { make in
            make.right.equalTo(messageLabel)
            make.top.equalTo(messageLabel.snp.bottom).offset(20)
            make.size.equalTo(registerBtn)
        }
        
        maskIconView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(registerBtn).offset(-36)
        }
        
        registerBtn.addTarget(self, action: #selector(clickRegister), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(clickLogin), for: .touchUpInside)
    }
}
