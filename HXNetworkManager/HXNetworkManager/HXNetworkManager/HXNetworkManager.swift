//
//  HXNetworkManager.swift
//  HXNetworkManager
//
//  Created by HongXiangWen on 2018/12/29.
//  Copyright © 2018年 WHX. All rights reserved.
//

import Moya

// MARK: - 网络控制器，使用非常简单
struct HXNetworkManager<Model: Codable> {
    
    /// 返回的数据结果封装，如果HXNetworkResult不符合你的要求，你可以自定义Result，只需要遵守HXNetworkResultType协议就行了
    /// 你可以将 HXNetworkResult<Model> 替换为 YourNetworkResult<Model>
    typealias HXRespneseResult = HXNetworkResult<Model>
    /// 请求完成的回调
    typealias HXNetworkCompletionClosure = (_ result: HXRespneseResult) -> ()
    /// progress的回调
    typealias HXNetworkProgressClosure = (_ progress: CGFloat) -> ()

    /// 请求数据
    ///
    /// - Parameters:
    ///   - target: TargetType
    ///   - progress: progress回调
    ///   - completion: 完成的回调
    func request<T: TargetType>(target: T, progress: HXNetworkProgressClosure? = nil, completion: @escaping HXNetworkCompletionClosure) {
        /// 设置请求超时时间
        let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<T>.RequestResultClosure) in
            guard var request = try? endpoint.urlRequest() else { return }
            // 设置请求超时时间30s
            request.timeoutInterval = 30
            done(.success(request))
        }
        let provider = MoyaProvider<T>(requestClosure: requestClosure)
        /// 开始请求数据
        provider.request(target, callbackQueue: DispatchQueue.main, progress: { (progressResponse) in
            progress?(CGFloat(progressResponse.progress))
        }) { (result) in
            switch result {
            case let .success(moyaResponse):
                do {
                    guard let json = try moyaResponse.mapJSON() as? [String: Any] else {
                        /// 不是json数据
                        completion(HXRespneseResult(errorMsg: "服务器返回的不是json数据"))
                        return
                    }
                    /// 成功
                    completion(HXRespneseResult(json: json))
                } catch {
                    /// 解析出错
                    completion(HXRespneseResult(errorMsg: error.localizedDescription))
                }
            case let .failure(error):
                /// 请求出错
                completion(HXRespneseResult(errorMsg: error.errorDescription))
            }
        }
    }
    
}
