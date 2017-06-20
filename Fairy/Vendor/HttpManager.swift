//
//  HttpManager.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HttpManager: NSObject {
    static let shareManage = HttpManager()
    private override init() {
    }
    
    func getADList(complete:@escaping (Error?,[JSON]?) -> Swift.Void) {
        
        Alamofire.request("https://live.9158.com/Living/GetAD").responseJSON { response in
            switch response.result {
            case .success(let value):
                if let json = JSON(value)["data"].array {
                    complete(nil, json)
                } else {
                    complete(JSON(value)["data"].error, nil)
                }
                
            case .failure(let error):
                complete(error, nil)
            }
            
//            let json = JSON(data:response.data!)
//            if let data = json["data"].array {
//                complete(nil,data)
//            } else {
//                complete(response.error,nil)
//            }
        }
    }
    
    func test() {
        Alamofire.request("").validate().responseData { (dataResponse) in
        }
    }
    
}
