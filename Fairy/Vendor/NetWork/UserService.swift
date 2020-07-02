//
//  AppService.swift
//  Icncde
//
//  Created by dssj on 2020/5/18.
//  Copyright © 2020 dssj. All rights reserved.
//

import Foundation

enum UserService {
    case UserRegister
    case UserLoginMobile(mobile:String,pwd:String)
    case UserLoginEmail(email:String,pwd:String)
    case UserHomePageInfo(loginType:Int)
}

extension UserService : TargetType {
    var baseURL: URL {
        return URL(string: BaseHttpUrl+"api/")!
    }
    
    var path: String {
        switch self {
        case .UserRegister:
            return "user/register/standard"
        case .UserLoginMobile(_):
            return "user/login/mobile"
        case .UserLoginEmail:
            return "user/login/email"
        case .UserHomePageInfo(_):
            return "user/home/page/info"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .UserRegister, .UserLoginMobile(_), .UserLoginEmail:
            return .post
        case .UserHomePageInfo(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .UserLoginEmail(email, pwd):
            let parameter = ["loginName": email,
                             "password":pwd]
            
            return .requestParameters(parameters: parameter,
                                      encoding: JSONEncoding.default)
            
        case let .UserLoginMobile(mobile, pwd):
            let parameter = ["loginName": mobile,
                             "password":pwd,
                             "sysVersion":"1000",
                             "deviceId":"1",
                             "deviceName":"1",
                             "resolution":"1",
                             "softwareVersion":"1",
                             "deviceVersion":"1"]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
            
        case let .UserHomePageInfo(loginType):
            return .requestParameters(parameters: ["type":loginType], encoding: URLEncoding.default)
            
        case .UserRegister: // Send no parameters
            return .requestPlain
            
        }
    }
    
    var headers: [String : String]? {
        var header = [
            "Source-Site": "ios.jys",
            "Content-Language": "zh-cn"]
        header["Authorization"] = UserManager.share.token
        return header
        
//        return [
////            "Content-type": "application/json",
//            "Source-Site": "ios.jys",
//            "Content-Language": "zh-cn"
//        ]
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
