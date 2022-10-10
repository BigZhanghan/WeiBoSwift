//
//  UILabel+Extension.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/29.
//

import UIKit

extension UILabel {
    convenience init(_ title: String, _ fontSize: CGFloat = 14.0, _ color: UIColor = .gray) {
        self.init()
        text = title
        font = UIFont.systemFont(ofSize: fontSize)
        textColor = color
        numberOfLines = 0
        textAlignment = .center
    }
}
