//
//  PrefixHeader.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit

let KBaseBlueColor = UIColor(red: 21/255.0, green: 166/255.0, blue: 246/255.0, alpha: 1.0)
let KBackgroundColor = UIColor.groupTableViewBackground

let Screen_W = UIScreen.main.bounds.size.width
let Screen_H = UIScreen.main.bounds.size.height

let Iphone_x = Screen_H / Screen_W  > 2.0 ? true : false

let StatusBar_H = UIApplication.shared.statusBarFrame.height
let Nav_H = CGFloat(44)
let Bottom_H = Iphone_x ? CGFloat(34) : CGFloat(0)

//let Nav_H = Iphone_x ? CGFloat(64) : CGFloat(44)

