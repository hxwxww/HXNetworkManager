//
//  ViewController.swift
//  HXNetworkManager
//
//  Created by HongXiangWen on 2018/12/29.
//  Copyright © 2018年 WHX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /// model为String
        HXNetworkManager<String>().request(target: SimpleApi.simple) { (result) in
            guard let data = result.data  else {
                /// error
                print(result.message ?? "")
                return
            }
            /// success
            print(data)
        }
        
        /// model为SimpleModel
        HXNetworkManager<SimpleModel>().request(target: SimpleApi.simple) { (result) in
            guard let data = result.data  else {
                /// error
                print(result.message ?? "")
                return
            }
            /// success
            print(data)
        }
        
        /// model为SimpleModel的数组
        HXNetworkManager<[SimpleModel]>().request(target: SimpleApi.simple) { (result) in
            guard let data = result.data  else {
                /// error
                print(result.message ?? "")
                return
            }
            /// success
            print(data)
        }
        
    }


}

