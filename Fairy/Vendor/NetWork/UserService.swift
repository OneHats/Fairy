//
//  AppService.swift
//  Icncde
//
//  Created by dssj on 2020/5/18.
//  Copyright © 2020 dssj. All rights reserved.
//

import Foundation
import Moya

enum UserService {
    case UserRegister
    case UserLoginMobile
    case UserLoginEmail(email:String,pwd:String)
}

extension UserService : TargetType {
    var baseURL: URL {
        return URL(string: BaseHttpUrl+"api/")!
    }
    
    var path: String {
        switch self {
        case .UserRegister:
            return "user/register/standard"
        case .UserLoginMobile:
            return "user/login/mobile"
        case .UserLoginEmail:
            return "user/login/email"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .UserRegister, .UserLoginMobile, .UserLoginEmail:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .UserLoginEmail(email, pwd):
            let parameter = ["loginName": email,
                             "password":pwd.MD5(),
            ]
            
            return .requestParameters(parameters: parameter,
                                      encoding: JSONEncoding.default)
        case .UserRegister,.UserLoginMobile: // Send no parameters
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
            "Source-Site": "ios.jys",
            "Content-Language": "zh-cn"
        ]
    }
}

//// MARK: - Helpers
//private extension String {
//    var urlEscaped: String {
//        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
//    }
//
//    var utf8Encoded: Data {
//        return data(using: .utf8)!
//    }
//}
