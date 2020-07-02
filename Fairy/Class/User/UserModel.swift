//
//  UserModel.swift
//  Fairy
//
//  Created by dssj on 2020/6/24.
//  Copyright © 2020 丁鹏飞. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    
    var userName = ""
    var realName = ""
    var nickName = ""
    var headImg = ""
    
//    let inviteCode = ""
//    let logonMode = ""
    
    var email = ""
    var mobile = ""
    
    override init() {
        super.init()
    }
    
    init(json:JSON) {
        userName = json["userName"].stringValue
        realName = json["realName"].stringValue
        nickName = json["nickName"].stringValue
        headImg = json["headImg"].stringValue
        
        email = json["email"].stringValue
        mobile = json["mobile"].stringValue
        
    }
    
}
