//
//  BaseService.swift
//  Icncde
//
//  Created by dssj on 2020/5/18.
//  Copyright © 2020 dssj. All rights reserved.
//

import Foundation
import Moya

enum BaseService {
    case BaseSystemVersion(version: Int)
    case BaseBannerList(bannerType: Int)
    case BaseInstrumentList
    case BaseCommodityIcons
}

extension BaseService : TargetType {
    
    var baseURL: URL {
        return URL(string: BaseHttpUrl+"api/")!
    }
    
    var path: String {
        switch self {
        case .BaseSystemVersion(_):
            return "base/sys/version/get"
        case .BaseBannerList(_):
            return "base/banner/list"
        case .BaseInstrumentList:
            return "base/instrument/list"
        case .BaseCommodityIcons:
            return "base/commodity/icons"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .BaseSystemVersion(_),.BaseBannerList(_),.BaseInstrumentList,.BaseCommodityIcons:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .BaseSystemVersion(version):
            return .requestParameters(parameters: ["currentVersion": version], encoding: URLEncoding.default)
        case let .BaseBannerList(bannerType):
            return .requestParameters(parameters: ["type": bannerType], encoding: URLEncoding.default)
        case .BaseInstrumentList,.BaseCommodityIcons:
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
