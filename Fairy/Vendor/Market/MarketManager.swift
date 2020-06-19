//
//  MarketManager.swift
//  Icncde
//
//  Created by dssj on 2020/5/22.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

class MarketManager: NSObject {
    static let share = MarketManager()
    
    var ticketInfo : [String:MarketTicker] = [:]
    var plineInfo : [String:[String]] = [:]
    
    override init() {
        
    }
    
}
