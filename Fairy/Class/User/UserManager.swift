//
//  UserManager.swift
//  Fairy
//
//  Created by dssj on 2020/6/24.
//  Copyright © 2020 丁鹏飞. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    private let tokenCacheKey = "tokenCacheKey"
    private let userInfoCacheKey = "userInfoCacheKey"
    
    static let share = UserManager.init()
    
    var token = "" {
        didSet {
            UserDefaults.standard.set(token, forKey: tokenCacheKey)
        }
    }
    
    var login = false
    var userInfo = UserModel()
    
    override init() {
        super.init()
        
        if let token = UserDefaults.standard.string(forKey: tokenCacheKey) {
            self.token = token
            login = true
        }
        
        if let model = UserDefaults.standard.object(forKey: userInfoCacheKey) {
            let json = JSON(model)
            userInfo = UserModel.init(json: json)
        }
        
    }
    
    
    func saveUserInfo(json:JSON) {
        userInfo = UserModel.init(json: json)
        UserDefaults.standard.set(json.dictionaryObject, forKey: userInfoCacheKey)
    }
    
    func logout() {
        login = false
        UserDefaults.standard.removeObject(forKey: tokenCacheKey)
    }
    
}
