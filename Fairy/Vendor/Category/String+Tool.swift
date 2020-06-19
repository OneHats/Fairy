//
//  String+Tool.swift
//  Icncde
//
//  Created by dssj on 2020/5/18.
//  Copyright © 2020 dssj. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    func MD5() -> String {
        let str = cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    }
    
    func jsonObject() -> [String:Any] {
        let data = self.data(using: String.Encoding.utf8)
        let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
        
        if dict != nil {
            return dict as! [String : Any]
        }
        return [:]
    }
    
    func decimalWith(decimal:Int) -> String {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        formatter.roundingMode = .down
        formatter.maximumFractionDigits = decimal
        formatter.minimumFractionDigits = decimal
        
        let original = NSDecimalNumber(string: self)
        
        let result = formatter.string(from: original)
        return result!

    }
    
    func unWrapBase64() -> String? {
        guard let data = Data.init(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        guard let result = String.init(data: data, encoding: String.Encoding.utf8) else {
            return nil
        }
        return result
    }
    
}
