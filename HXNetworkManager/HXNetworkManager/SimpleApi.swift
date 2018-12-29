//
//  SimpleApi.swift
//  HXNetworkManager
//
//  Created by HongXiangWen on 2018/12/29.
//  Copyright © 2018年 WHX. All rights reserved.
//

import Moya

enum SimpleApi {
    case simple
}

extension SimpleApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://simple.com")!
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/x-www-form-urlencoded;charset=utf-8"]
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var path: String {
        switch self {
        case .simple:
            return "/simple"
        }
    }
    
    var task: Task {
        switch self {
        case .simple:
            return .requestPlain
        }
    }
    
}
