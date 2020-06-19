//
//  UIView+Tool.swift
//  Icncde
//
//  Created by dssj on 2020/6/4.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

extension UIView {
    
    static func loadNibView(nibname:String?) -> Self {
        let loadName = (nibname == nil ? "\(self)" : nibname!)
        let arr = Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)
        if let assetView = arr?.first as? Self {
            return assetView
        }
        return self.init()
    }
    
}
