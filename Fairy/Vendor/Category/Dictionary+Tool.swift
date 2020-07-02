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
        let data = self.jsonData()
        guard let result = String(data: data, encoding: String.Encoding.utf8) else {
            return ""
        }
        return result
    }
    
    func jsonData() -> Data {
        if JSONSerialization.isValidJSONObject(self) {
            guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else {
                return Data()
            }
            return data
        }
//        print("Not ValidJSONObject")
        return Data()
    }
}
