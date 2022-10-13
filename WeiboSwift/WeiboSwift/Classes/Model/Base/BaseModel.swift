//
//  BaseModel.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/10.
//

import Foundation
import HandyJSON

class BaseModel:NSObject, HandyJSON {
    
    required override init() {}
    
    func mapping(mapper: HelpingMapper) {}
}
