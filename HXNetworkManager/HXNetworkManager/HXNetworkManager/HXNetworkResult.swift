//
//  HXNetworkResult.swift
//  HXNetworkManager
//
//  Created by HongXiangWen on 2018/12/29.
//  Copyright © 2018年 WHX. All rights reserved.
//

import Foundation

protocol HXNetworkResultType {
    
    associatedtype T: Codable
    /// 数据
    var data: T? { get set }
    /// 是否请求成功的标记
    var success: Bool { get }
    /// 请求结果说明
    var message: String? { get }
    /// 通过json数据初始化
    init(json: [String: Any])
    /// 通过错误信息初始化
    init(errorMsg: String?)
}

extension HXNetworkResultType {
    
    /// 数据解析
    mutating func parseData(obj: Any?) {
        /// 如果dataObj是T，直接赋值
        if let dataObj = obj as? T {
            data = dataObj
            return
        }
        /// 验证obj是否为nil
        guard let dataObj = obj, !(dataObj as AnyObject).isEqual(NSNull()) else { return }
        /// 转模型
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dataObj, options: .prettyPrinted),
            let model = try? JSONDecoder().decode(T.self, from: jsonData) else { return }
        data = model
    }
    
}

// MARK: - 请求返回结果模型，可根据实际需要自定义，只需要遵守HXNetworkResultType协议就行了
struct HXNetworkResult<Model: Codable>: HXNetworkResultType {
 
    typealias T = Model
    var data: Model?
    var success: Bool
    var message: String?
    
    init(json: [String: Any]) {
        success = json["success"] as? Bool ?? false
        message = json["msg"] as? String
        parseData(obj: json["data"])
    }
    
    init(errorMsg: String?) {
        success = false
        message = errorMsg
    }
    
}
