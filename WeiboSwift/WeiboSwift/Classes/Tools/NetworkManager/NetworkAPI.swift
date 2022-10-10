//
//  NetworkTools.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/29.
//

import Foundation

class NetwokAPI {
    
    private static let appKey = "161276545"
    private static let appSecret = "78963ed930e43112715691013d4dc182"
    private static let redirectUrl = "http://www.baidu.com"
}

// MARK: - TestAPI
extension NetwokAPI {
    /// test get method
    static func testAPIGet(_ completion: @escaping (Any) -> ()) {
        NetworkTools.shared.get("http://httpbin.org/get", nil) { result in
            completion(result)
        }
    }
    
    /// test post method
    static func testAPIPost(_ completion: @escaping (Any) -> ()) {
        let params = [
            "name": "zhanghan",
            "age": "18",
            "grade": "A",
        ]
        NetworkTools.shared.post("http://httpbin.org/post", params) { result in
            completion(result)
        }
    }
}

// MARK: - OAuth
extension NetwokAPI {
    static var oauthURL: URL {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&redirect_uri=\(redirectUrl)"
        return URL(string: urlString)!
    }
    
    /// OAuth 获取accessToken
    /// - see: [https://open.weibo.com/wiki/Oauth2/access_token](https://open.weibo.com/wiki/Oauth2/access_token)
    static func loadAccessToken(_ code: String, _ completion: @escaping (Any) -> ()) {
        let query = "client_id=\(appKey)&client_secret=\(appSecret)&grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectUrl)"
        let url = "https://api.weibo.com/oauth2/access_token?" + query
        
        NetworkTools.shared.post(url, nil) { result in
            completion(result)
        }
    }
    
}
