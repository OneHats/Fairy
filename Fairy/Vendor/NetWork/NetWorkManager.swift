//
//  NetWorkManager.swift
//  Icncde
//
//  Created by dssj on 2020/5/18.
//  Copyright © 2020 dssj. All rights reserved.
//

import Foundation
import SwiftyJSON
import Moya

struct NetWorkManager {
    static let defaultProvider = MoyaProvider<MultiTarget>()
    
    ///成功
    typealias SuccessClosure = (_ result: JSON) -> Void
    typealias FailClosure = (_ errorMsg: String) -> Void
    
    static func request(_ target:MultiTarget, success: @escaping SuccessClosure,failure:@escaping FailClosure) {
        defaultProvider.request(target) { result in
            switch result {
            case .success(let reponse):
                let json = JSON(reponse.data)
                if json["code"].intValue == 200 || json["code"].intValue == 100{
                    success(json)
                    
                } else {
                    failure(json["msg"].stringValue)
                }
                    
            case .failure(let error):
                print(target.path,error)
                failure("net error")
            }
        }
            
    }
    
        
}

//class NetWorkManager: NSObject {
//
//}
