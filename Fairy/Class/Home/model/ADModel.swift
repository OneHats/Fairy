//
//  ADModel.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/7.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit

class ADModel: NSObject {
//    @objc var contents:String?
//    @objc var title:String?
//    @objc var link:String?
//    @objc var imageUrl:String?
    
    var contents:String?
    var title:String?
    var link:String?
    var imageUrl:String?
    
//    class func arrayWithJson(json: JSON) -> [ADModel] {
//        var list = [ADModel]()
//        guard let array = json["data"].array else { return list }
//
//        for temp in array {
//            let model = ADModel.init()
//            model.setValuesForKeys(temp.dictionaryObject!)
//            list.append(model)
//        }
//
//        return list
//    }
    
//    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//    }
    
    class func arrayWithJson(json: JSON) -> [ADModel] {
        var list = [ADModel]()
        guard let array = json["data"].array else {
            return list
        }

        for temp in array {
            let model = ADModel.init()
            model.title = temp["title"].stringValue
            model.contents = temp["contents"].stringValue
            model.link = temp["link"].stringValue
            model.imageUrl = temp["imageUrl"].stringValue
            list.append(model)
        }

        return list
    }
    
}
