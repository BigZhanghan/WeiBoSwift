//
//  HomeItemViewModel.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/13.
//

import UIKit

class HomeItemViewModel {
    var status: StatusListModel
    
    lazy var rowHeight: CGFloat = {
        let cell = HomeStatusCell(style: .default, reuseIdentifier: listCellId)
        print("行高：\(cell.rowHeight(vm: self))")
        return cell.rowHeight(vm: self)
    }()
    
    var profileUrl: URL {
        return URL(string: status.user?.profileImageUrl ?? "")!
    }
    
    var defaultImage: UIImage {
        return UIImage(named: "avatar_default")!
    }
    
    var memberImage: UIImage? {
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return nil
    }
    
    var vipImage: UIImage? {
        switch status.user?.verifiedType ?? -1 {
        case 0:
            return UIImage(named: "avatar_vip")
        case 2,3,5:
            return UIImage(named: "avatar_enterprise_vip")
        case 220:
            return UIImage(named: "avatar_grassroot")
        default:
            return nil
        }
    }
    
    var thumbnailUrls: [URL]?
    
    init(status: StatusListModel) {
        self.status = status
        
        
        // 根据模型生成缩略图数组
        guard let count = status.picUrls?.count else {
            return
        }
        
        if count > 0 {
            
            thumbnailUrls = [URL]()
            
            for item in status.picUrls! {
                let url = URL(string: item.thumbnailPic!)
                thumbnailUrls?.append(url!)
            }
        }
    }
}
