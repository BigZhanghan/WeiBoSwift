//
//  UILabel+Extension.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/29.
//

import UIKit

extension UILabel {
    convenience init(title: String, fontSize: CGFloat = 14.0, color: UIColor = .gray, align: NSTextAlignment = .center, screenInset: CGFloat = 0) {
        self.init()
        text = title
        font = UIFont.systemFont(ofSize: fontSize)
        textColor = color
        numberOfLines = 0
        textAlignment = align
        if screenInset != 0 {
            preferredMaxLayoutWidth = UIScreen.main.bounds.width - 2 * screenInset
        }
    }
}
