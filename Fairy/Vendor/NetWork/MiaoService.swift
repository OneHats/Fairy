//
//  MiaoService.swift
//  Fairy
//
//  Created by dssj on 2020/6/17.
//  Copyright © 2020 丁鹏飞. All rights reserved.
//

import Foundation

enum MiaoService {
    case GetAD
    case GetHotLive(page:Int)
}

extension MiaoService : TargetType {
    var baseURL: URL {
        return URL(string: "https://live.9158.com/")!
    }
    
    var path: String {
        switch self {
        case .GetAD:
            return "Living/GetAD"
        case .GetHotLive:
            return "Fans/GetHotLive"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .GetAD:
            return .requestPlain
        case let .GetHotLive(page):
            return .requestParameters(parameters: ["page":page], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
//         return ["Content-type": "application/json"]
        return [:]
    }
    
}

