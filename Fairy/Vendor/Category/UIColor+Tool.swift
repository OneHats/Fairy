//
//  UIColor+Tool.swift
//  Icncde
//
//  Created by dssj on 2020/5/14.
//  Copyright © 2020 dssj. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func colorWithHex(_ hex:String) -> UIColor {
        var hexString = hex.uppercased()
        
        if hexString.count < 6 {
            return UIColor.white
        }
        
        if hexString.hasPrefix("#") {
            hexString = String(hexString.dropFirst(1))
            
        } else if hexString.hasPrefix("0X") {
            hexString = String(hexString.dropFirst(2))
        }
        
        if hexString.count != 6 {
            return UIColor.white
        }
        
        var rgb: UInt32 = 0
        guard Scanner(string: hexString).scanHexInt32(&rgb) else {
            return UIColor.white
        }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
