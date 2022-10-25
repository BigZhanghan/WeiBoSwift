//
//  StatusListModel.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/13.
//

import Foundation
import HandyJSON

class StatusListModel: BaseModel {
    
    var itemId: String?
    var text: String?
    var createdAt: String?
    var source: String?
    var user: ListUserModel?
    var picUrls: [PictureItem]?
    
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
            itemId <-- "id"
        
        mapper <<<
            createdAt <-- "created_at"
        
        mapper <<<
            picUrls <-- "pic_urls"
    }
}

class ListUserModel: BaseModel {
    var userId: String?
    var profileImageUrl: String?
    var screenName: String?
    /// -1:没有认证；0:认证用户；2、3、5:企业认证；220:达人
    var verifiedType: Int = 0
    /// 会员等级0-6
    var mbrank: Int = 0
    
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
            userId <-- "id"
        
        mapper <<<
            profileImageUrl <-- "profile_image_url"
        
        mapper <<<
            screenName <-- "screen_name"
        
        mapper <<<
            verifiedType <-- "verified_type"
    }
}

class PictureItem: BaseModel {
    var thumbnailPic: String?
    
    override func mapping(mapper: HelpingMapper) {
        
        mapper <<<
            thumbnailPic <-- "thumbnail_pic"
    }
}
