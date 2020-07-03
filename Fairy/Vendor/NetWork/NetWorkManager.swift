//
//  NetWorkManager.swift
//  Icncde
//
//  Created by dssj on 2020/5/18.
//  Copyright © 2020 dssj. All rights reserved.
//

import Foundation

struct NetWorkManager {
    static let defaultProvider = MoyaProvider<MultiTarget>()
    ///成功
    typealias SuccessClosure = (_ result: JSON) -> Void
    typealias FailClosure = (_ errorMsg: String) -> Void
    
    static func request(_ target:MultiTarget, success: @escaping SuccessClosure,failure:@escaping FailClosure) {
        defaultProvider.request(target) { result in
            switch result {
            case .success(let reponse):
//                reponse.mapJSON()
                
                let json = JSON(reponse.data)
                if json["code"].intValue == 200 || json["code"].intValue == 100 {
                    success(json)
                    
                } else {
                    let errorMsg = json["msg"].stringValue
                    failure(errorMsg)
                    print(target.path,errorMsg)
                }
                    
            case .failure(let error):
                print(target.path,error.errorDescription!)
                failure("Error")
            }
        }
        
    }
    
        
}

