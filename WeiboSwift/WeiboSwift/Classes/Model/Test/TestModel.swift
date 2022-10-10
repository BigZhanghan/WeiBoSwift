//
//  TestModel.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/9.
//

import Foundation

struct TestModel: Codable {
    var args: Args?
    var headers: Headers
    var origin: String
    var url: String
}

struct Args: Codable {
    
}

struct Headers: Codable {
    var accept: String
    var acceptEncoding: String
    var userAgent: String
    var host: String
    var requests: String
    var acceptLanguage: String
    var traceId: String
    
    private enum CodingKeys: String, CodingKey {
        case accept = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case userAgent = "User-Agent"
        case host = "Host"
        case requests = "Upgrade-Insecure-Requests"
        case acceptLanguage = "Accept-Language"
        case traceId = "X-Amzn-Trace-Id"
    }
}




