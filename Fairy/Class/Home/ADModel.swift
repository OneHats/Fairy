//
//  ADModel.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/7.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON

class ADModel: NSObject {
    @objc var contents:String?
    @objc var title:String?
    
    @objc var link:String?
    @objc var imageUrl:String?
    
    class func getModelListWith(array: [JSON]) -> [ADModel] {
        var list = [ADModel]()
        
        for json in array {
            let model = ADModel.init()
            model.setValuesForKeys(json.dictionaryObject!)
            list.append(model)
        }
        
        return list
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
