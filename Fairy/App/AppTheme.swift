//
//  AppTheme.swift
//  Icncde
//
//  Created by dssj on 2020/5/14.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

@_exported import SwiftyJSON
@_exported import Moya
@_exported import PKHUD

let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let StatusBarH = UIApplication.shared.statusBarFrame.height
let BarH = CGFloat(44)
let TabBarH = CGFloat(49)
let NavigationBarH = (StatusBarH + BarH)
let IX = (ScreenHeight/ScreenWidth > 2.0)
let BottomH = (IX ? CGFloat(34) : CGFloat(0))

let ThemeColorBlue = UIColor(red: 21/255.0, green: 166/255.0, blue: 246/255.0, alpha: 1.0)
let ThemeColorBackground = UIColor.colorWithHex("#0F0F0F")
let ThemeColorGray = UIColor.systemGray
let ThemeColorRed = UIColor.colorWithHex("#F13D3C")
let ThemeColorGreen = UIColor.colorWithHex("#00A93F")
let ThemeColorBlack = UIColor.colorWithHex("#333333")

//let BaseHttpUrl = "https://ios.icncde.com/"
//let BaseSocketUrl = "ws://mobile.icncde.com/ws"

let BaseHttpUrl = "http://test.mobile.icctoro.com:7007/"
//let BaseSocketUrl = "ws://test.mobile.icctoro.com:7007/ws"
let BaseSocketUrl = "ws://test.www.icncde.com:7039/ws"

let hudDuration = 1.5


