//
//  UIImage+Tool.swift
//  Icncde
//
//  Created by dssj on 2020/5/14.
//  Copyright © 2020 dssj. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func imageWithColor(_ color:UIColor) -> UIImage? {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
}

