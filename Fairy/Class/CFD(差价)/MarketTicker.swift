//
//  MarketTicker.swift
//  Icncde
//
//  Created by dssj on 2020/5/22.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

class MarketTicker: NSObject {
    var code = ""
    var period = ""
    var timestamp = ""
    var bid = ""
    var ask = ""
    var open = ""
    var high = ""
    var low = ""
    var price = ""
    
    static func modelWithJsonData(json:JSON) -> MarketTicker {
        let ticker = MarketTicker()
        let array = json.arrayValue
        
        for k in 0...array.count-1 {
            let temp = array[k]
            
            if k == 0 {
                ticker.code = temp.stringValue
                
            } else if k == 1 {
                ticker.period = temp.stringValue
            } else if k == 2 {
                ticker.timestamp = temp.stringValue
            } else if k == 3 {
                ticker.bid = temp.stringValue
            } else if k == 4 {
                ticker.ask = temp.stringValue
            } else if k == 5 {
                ticker.open = temp.stringValue
            } else if k == 6 {
                ticker.high = temp.stringValue
            } else if k == 7 {
                ticker.low = temp.stringValue
            } else if k == 8 {
                ticker.price = temp.stringValue
            }
            
        }
        
        return ticker
    }
    
//    static func modelWithArray(array:[Any]) -> MarketTicker {
//        let ticker = MarketTicker()
//
//        for k in 0...array.count-1 {
//            let temp = array[k]
//
//            if k == 0 {
//                if temp is String {
//                    ticker.code = temp as! String
//                }
//
//            } else if k == 1 {
//                if temp is String {
//                    ticker.timestamp = temp as! String
//                } else if temp is NSNumber {
//                    ticker.timestamp = (temp as! NSNumber).stringValue
//                }
//
//            } else if k == 2 {
//                if temp is String {
//                    ticker.bid = temp as! String
//                } else if temp is NSNumber {
//                    ticker.bid = (temp as! NSNumber).stringValue
//                }
//            } else if k == 3 {
//                if temp is String {
//                    ticker.ask = temp as! String
//                } else if temp is NSNumber {
//                    ticker.ask = (temp as! NSNumber).stringValue
//                }
//
//            } else if k == 4 {
//                if temp is String {
//                    ticker.open = temp as! String
//                } else if temp is NSNumber {
//                    ticker.open = (temp as! NSNumber).stringValue
//                }
//
//            } else if k == 5 {
//                if temp is String {
//                    ticker.high = temp as! String
//                } else if temp is NSNumber {
//                    ticker.high = (temp as! NSNumber).stringValue
//                }
//            } else if k == 6 {
//                if temp is String {
//                    ticker.low = temp as! String
//                } else if temp is NSNumber {
//                    ticker.low = (temp as! NSNumber).stringValue
//                }
//            } else if k == 7 {
//                if temp is String {
//                    ticker.price = temp as! String
//                } else if temp is NSNumber {
//                    ticker.price = (temp as! NSNumber).stringValue
//                }
//            } else if k == 8 {
//                if temp is String {
//                    ticker.refPrice = temp as! String
//                } else if temp is NSNumber {
//                    ticker.refPrice = (temp as! NSNumber).stringValue
//                }
//            }
//
//        }
//        
//        return ticker
//    }
}
