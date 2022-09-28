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
}
