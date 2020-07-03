//
//  ADModel.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/7.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit

class ADModel: NSObject {
    
    var contents:String = ""
    var title:String = ""
    var link:String = ""
    var imageUrl:String = ""
    
    convenience init(json:JSON) {
        self.init()
        title = json["title"].stringValue
        contents = json["contents"].stringValue
        link = json["link"].stringValue
        imageUrl = json["imageUrl"].stringValue
    }
    
    class func arrayWithJson(json: JSON) -> [ADModel] {
        guard let array = json["data"].array else {
            return []
        }
        
        var list = [ADModel]()
        for temp in array {
            let model = ADModel.init(json: temp)
            list.append(model)
        }
        return list
    }
    
}
