//
//  UIButton+Extension.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/28.
//

import UIKit

// MARK: - UIButton扩展
extension UIButton {

    convenience init(_ imageName: String, _ backImageName: String) {
        self.init()
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: backImageName), for: .normal)
        setBackgroundImage(UIImage(named: backImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
    
    convenience init(title: String, color: UIColor, backImage: String) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setBackgroundImage(UIImage(named: backImage), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        sizeToFit()
    }
    
    convenience init(title: String, color: UIColor, image: String) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        setImage(UIImage(named: image), for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 12)

        sizeToFit()
    }
}
