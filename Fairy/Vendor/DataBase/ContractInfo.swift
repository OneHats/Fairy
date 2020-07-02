//
//  ContractInfo.swift
//  Icncde
//
//  Created by dssj on 2020/5/19.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

class ContractInfo: NSObject {
    
    var code : String = ""
    
    var name : String = ""
    
    var currency : String = ""
    
    var commodity : String = ""
    
    var country : String = ""
    
    var type : String = ""
    
    var exType : String = ""
    
    var tag : String = ""
    
    var symbol : String = ""
    
    var circulation : String = ""
    
    
    var icon : String = ""
    
    var iconValue : String {
        get {
            guard let last = self.icon.split(separator: ",").last else {
                return ""
            }
            
            return String(last)
        }
    }
    
    convenience init(json:JSON) {
        self.init()
        name = json["name"].stringValue
        code = json["code"].stringValue
        commodity = json["commodity"].stringValue
        circulation = json["circulation"].stringValue
        icon = json["icon"].stringValue
        
//        country = json["country"].stringValue
    }
    
    static func arrayWith(json:JSON) -> Array<ContractInfo> {
        if json.arrayValue.count == 0 {
            return []
        }
        
        var arr = [ContractInfo]()
        for dict in json.arrayValue {
            let obj = ContractInfo.init(json: dict)
            arr.append(obj)
        }
        return arr
    }
    
}
