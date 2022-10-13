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
    func get(_ path: String, headers: HTTPHeaders? = nil, _ params: Parameters?, _ completion: @escaping (_ result: Any, _ err: Error? ) -> ()) {
        Alamofire.AF.request(path, parameters: params, headers: headers, requestModifier: {$0.timeoutInterval = 15}).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print("response = \(object)")
                    completion(object, nil)
                } catch {
                    print("JSONSerialization-error:\(error)")
                    completion({}, error)
                }
            case let .failure(e):
                print("response-error:\(e)")
                completion({}, self.handleError(e))
            }
        }
    }
    
    func post(_ path: String, headers: HTTPHeaders? = nil, _ params: Parameters?, _ completion: @escaping (_ result: Any, _ err: Error?) -> ()) {
        Alamofire.AF.request(path, method: .post, parameters: params, encoding: JSONEncoding.prettyPrinted, headers: headers, requestModifier: {$0.timeoutInterval = 15}).responseData { response in
            switch response.result {
            case let .success(data):
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    print("response = \(object)")
                    completion(object, nil)
                } catch {
                    print("JSONSerialization-error:\(error)")
                    completion({}, error)
                }
            case let .failure(e):
                print("response-error:\(e)")
                completion({}, self.handleError(e))
            }
        }
    }
    
    private func handleError(_ error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if  code == NSURLErrorNotConnectedToInternet ||
                    code == NSURLErrorTimedOut ||
                    code == NSURLErrorInternationalRoamingOff ||
                    code == NSURLErrorDataNotAllowed ||
                    code == NSURLErrorCannotFindHost ||
                    code == NSURLErrorCannotConnectToHost ||
                    code == NSURLErrorNetworkConnectionLost {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "网络连接有问题～"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo) as Error
                return currentError
            }
        }
        return NSError(domain: error.url?.absoluteString ?? "", code: error.responseCode ?? 9999, userInfo: nil) as Error
    }
}
