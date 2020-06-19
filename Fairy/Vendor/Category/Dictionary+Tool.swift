//
//  Dictionary+Tool.swift
//  Icncde
//
//  Created by dssj on 2020/5/21.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

extension Dictionary {
    func jsonString() -> String {
        if JSONSerialization.isValidJSONObject(self) {
            let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.fragmentsAllowed)
            
            guard let jsonData = data else { return "" }
            
            let result = String(data: jsonData, encoding: String.Encoding.utf8)!
            return result
        }
        print("not ValidJSONObject")
        return ""
        
        
    }
}
