//
//  RootViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import Alamofire

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        let homeNVC = UINavigationController(rootViewController: homeVC)
        homeNVC.view.backgroundColor = UIColor.white
        
        let userVC = UserViewController()
        let userNVC = UINavigationController(rootViewController: userVC)
        userNVC.view.backgroundColor = UIColor.white
        
        self.viewControllers = [homeNVC,userNVC]
        
        let titles = ["Home","User"]
        for i in 0 ..< (tabBar.items?.count)! {
            let barItem = tabBar.items?[i]
            barItem?.title = titles[i]
        }
        
        networkMonitor()
    }
    
    private func networkMonitor()  {
        let networkManager = NetworkReachabilityManager(host: "www.baidu.com")
        networkManager?.listener = { status in
            
            switch status {
            case .notReachable:
                ProgressHUD.showError(text: "网络已断开")
            case .reachable(.wwan):
                ProgressHUD.showSuccess(text: "正在使用手机网络")
            default: break
            }
        }
        networkManager?.startListening()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
