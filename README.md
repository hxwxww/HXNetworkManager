# HXNetworkManager
Alamofire+Moya+Codable实现最简单的网络请求

### 使用超级简单，Model遵守Codable协议就行了
- Model为String
```
HXNetworkManager<String>().request(target: SimpleApi.simple) { (result) in
    guard let data = result.data  else {
        /// error
        print(result.message ?? "")
        return  
    }
    /// success
    print(data)
}
```
- Model为SimpleModel
```
HXNetworkManager<SimpleModel>().request(target: SimpleApi.simple) { (result) in
    guard let data = result.data  else {
        /// error
        print(result.message ?? "")
        return
    }
    /// success
    print(data)
}
```
- Model为SimpleModel的数组
```
HXNetworkManager<[SimpleModel]>().request(target: SimpleApi.simple) { (result) in
    guard let data = result.data  else {
        /// error
        print(result.message ?? "")
        return
    }
    /// success
    print(data)
}
```

