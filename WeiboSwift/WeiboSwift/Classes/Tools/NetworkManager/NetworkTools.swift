//
//  NetworkTools.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/29.
//

import Foundation
import Alamofire

enum HttpRequestMethod {
    case get
    case post
}

class NetworkTools {
    
    private let baseURL = "http://localhost:8080/"    
    
    static let shared = NetworkTools()
    private init() {}
    
    
    // TODO: get与post合并封装
    func get(_ path: String, headers: HTTPHeaders? = nil, _ params: Parameters?, _ completion: @escaping (_ result: Any) -> ()) {
        Alamofire.AF.request(path, parameters: params, headers: headers, requestModifier: {$0.timeoutInterval = 15}).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print("response = \(object)")
                    completion(object)
                } catch {
                    print("JSONSerialization-error:\(error)")
                }
            case let .failure(err):
                print("response-error:\(err)")
            }
        }
    }
    
    func post(_ path: String, headers: HTTPHeaders? = nil, _ params: Parameters?, _ completion: @escaping (_ result: Any) -> ()) {
        Alamofire.AF.request(path, method: .post, parameters: params, encoding: JSONEncoding.prettyPrinted, headers: headers, requestModifier: {$0.timeoutInterval = 15}).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print("response = \(object)")
                    completion(object)
                } catch {
                    print("JSONSerialization-error:\(error)")
                }
            case let .failure(error):
                print("response-error:\(error)")
            }
        }
    }
}
