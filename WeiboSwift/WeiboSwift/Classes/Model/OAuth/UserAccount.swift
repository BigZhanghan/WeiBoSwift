//
//  UserAccount.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/10.
//

import Foundation
import HandyJSON

class UserAccount: BaseModel, NSCoding, NSSecureCoding {
    
    var accessToken: String?
    var expiresIn: TimeInterval = 0
    var expiresDate: Date?
    var uid: String?
    var screenName: String?
    var avaterLarge: String?
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    required init() {
        super.init()
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(accessToken, forKey: "accessToken")
        coder.encode(expiresDate, forKey: "expiresDate")
        coder.encode(uid, forKey: "uid")
        coder.encode(screenName, forKey: "screenName")
        coder.encode(avaterLarge, forKey: "avaterLarge")
    }
    
    required init?(coder: NSCoder) {
        accessToken = coder.decodeObject(of: NSString.self, forKey: "accessToken") as? String
        expiresDate = coder.decodeObject(of: NSDate.self, forKey: "expiresDate") as? Date
        uid = coder.decodeObject(of: NSString.self, forKey: "uid") as? String
        screenName = coder.decodeObject(of: NSString.self, forKey: "screenName") as? String
        avaterLarge = coder.decodeObject(of: NSString.self, forKey: "avaterLarge") as? String
    }
    
    override func mapping(mapper: HelpingMapper) {
        mapper <<<
            accessToken <-- "access_token"
        
        mapper <<<
            expiresIn <-- "expires_in"
    }
    
}
