//
//  BannerObject.swift
//  Icncde
//
//  Created by dssj on 2020/5/18.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

class BannerObject: NSObject {
    
    var linkPath : String = ""
    var title : String = ""
    var imgPath : String = ""
    
    convenience init(json:JSON) {
        self.init()
        linkPath = json["linkPath"].stringValue
        title = json["title"].stringValue
        imgPath = json["imgPath"].stringValue
    }
    
    static func arrayWith(json:JSON) -> Array<BannerObject> {
        if json.arrayValue.count == 0 {
            return []
        }
        
        var arr = [BannerObject]()
        for dict in json.arrayValue {
            let obj = BannerObject.init(json: dict)
            arr.append(obj)
        }
        return arr
    }
    
}
