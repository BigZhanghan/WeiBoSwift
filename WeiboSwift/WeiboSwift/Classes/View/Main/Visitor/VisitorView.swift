//
//  VisitorView.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/28.
//

import UIKit

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
    
    private lazy var messageLabel: UILabel = UILabel("关注一些人，回这里看看有什么惊喜")
    
    private lazy var registerBtn: UIButton = UIButton("注册", .orange, "common_button_white_disable")
    
    private lazy var loginBtn: UIButton = UIButton("登录", .darkGray, "common_button_white_disable")
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
        
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[mask]-0-|", metrics: nil, views: ["mask": maskIconView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[mask]-(registerHeight)-[registerBtn]", metrics: ["registerHeight": -36], views: ["mask": maskIconView, "registerBtn": registerBtn]))
        
        addConstraint(NSLayoutConstraint(item: homeView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: 16))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 230))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 36))
        
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .left, relatedBy: .equal, toItem: messageLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registerBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40))
        
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .right, relatedBy: .equal, toItem: messageLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .top, relatedBy: .equal, toItem: messageLabel, attribute: .bottom, multiplier: 1.0, constant: 20))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginBtn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40))
        
        registerBtn.addTarget(self, action: #selector(clickRegister), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(clickLogin), for: .touchUpInside)
    }
}
