//
//  UIImageView+Extension.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/29.
//

import UIKit

extension UIImageView {
    convenience init(_ imageName: String) {
        self.init()
        
        image = UIImage(named: imageName)
    }
}
