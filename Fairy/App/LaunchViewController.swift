//
//  LaunchViewController.swift
//  Icncde
//
//  Created by dssj on 2020/5/14.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    typealias LaunchFinish = () -> Void
    var launchFinish : LaunchFinish?
    
    private let LaunchCount = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAllCommodity()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let info = AppDelegate.checkInfo
//        info.checking = true
//
//        let path = "https://icnapp.oss-ap-southeast-1.aliyuncs.com/show.json";
//        let url = URL.init(string: path)!
//
//        let data = try? Data.init(contentsOf: url)
//        if data == nil {
//            return
//        }
//
//        let json = try? JSON(data: data! as Data)
//        info.v = json!["v"].intValue
//        if LaunchCount >= info.v {
//            info.checking = true
//        }
//
//        info.checking = false
        launchFinish?()
    }
    
    //MARK:
    private func loadAllCommodity() {
        var instrumentList : JSON?
        var commodityIcons : JSON?

        let group = DispatchGroup()
        let queue = DispatchQueue.global()
//        let queue = DispatchQueue(label: "111", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)

        group.enter()
        queue.async(group: group, qos: DispatchQoS.default, flags: DispatchWorkItemFlags.assignCurrentContext) {
            let target = MultiTarget(BaseService.BaseInstrumentList)
            NetWorkManager.request(target, success: { json in
                instrumentList = json
                group.leave()

            }) { _ in
            }
        }

        group.enter()
        queue.async(group: group, qos: DispatchQoS.default, flags: DispatchWorkItemFlags.assignCurrentContext) {
            let target = MultiTarget(BaseService.BaseCommodityIcons)
            NetWorkManager.request(target, success: { json in
                commodityIcons = json
                group.leave()

            }) { _ in
            }
        }

        group.notify(queue: queue) {
            guard let contracts = instrumentList?["data"].array,let icons = commodityIcons?["data"] else {
                return
            }
            
            var array = [JSON]()
            for contract in contracts {
                if var dict = contract.dictionaryObject {
                    let commodity = contract["commodity"].stringValue
                    let imageStr = icons[commodity].stringValue
                    dict["icon"] = imageStr
                    
                    array.append(JSON(dict))
                }
            }
            
//            DataBase.share.updateContract(datas: array)
        }
        
//        let target = MultiTarget(BaseService.BaseInstrumentList)
//        NetWorkManager.request(target, success: { json in
//            contracts = json
//            DataBase.share.updateContract(datas: contracts!)
//        }) { _ in
//        }
        
    }

}
