//
//  JsonUtil.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/10.
//

import Foundation
import HandyJSON

class JsonUtil: NSObject {
    /// 字典转对象
    static func dictionaryToModel(_ dictionStr: [String: Any], _ modelType: HandyJSON.Type) -> BaseModel {
        if dictionStr.count == 0 {
            return BaseModel()
        }
        return modelType.deserialize(from: dictionStr) as! BaseModel
    }
    
    /// 对象转字典
    static func modelToDictionary(_ model: BaseModel?) -> [String: Any] {
        if model == nil {
            return [:]
        }
        return (model?.toJSON())!
    }
    
    /// json转对象
    static func jsonToModel(_ jsonStr: String, _ modelType: HandyJSON.Type) -> BaseModel {
        if jsonStr == "" || jsonStr.count == 0 {
            return BaseModel()
        }
        return modelType.deserialize(from: jsonStr)  as! BaseModel
    }
    
    /// 对象转json
    static func modelToJson(_ model: BaseModel?) -> String {
        if model == nil {
            return ""
        }
        return (model?.toJSONString())!
    }
    
    
    /// json转数组
    static func jsonArrayToModel(_ jsonArrayStr: String, _ modelType: HandyJSON.Type) -> [BaseModel] {
        if jsonArrayStr == "" || jsonArrayStr.count == 0 {
            return []
        }
        var modelArray:[BaseModel] = []
        let data = jsonArrayStr.data(using: String.Encoding.utf8)
        let peoplesArray = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? [AnyObject]
        for people in peoplesArray! {
            modelArray.append(dictionaryToModel(people as! [String : Any], modelType))
        }
        return modelArray
    }
}
