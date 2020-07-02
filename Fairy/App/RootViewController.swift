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

        //首页（行情）
        let homeVC = HomeViewController()
        let homeNVC = UINavigationController.init(rootViewController: homeVC)
        
        //
        let CFDVC = CFDViewController()
        let CFDNVC = UINavigationController.init(rootViewController: CFDVC)
        
        //
        let userVC = UserViewController()
        let userNVC = UINavigationController.init(rootViewController: userVC)
        
        tabBar.backgroundImage = UIImage.imageWithColor(ThemeColorBackground)
        tabBar.tintColor = ThemeColorBlue
        tabBar.unselectedItemTintColor = ThemeColorGray
        
        var images = [""]
        let titles = ["000","111","222",]
        
        viewControllers = [homeNVC,CFDNVC,userNVC]
        images = ["TabHome","TabContract","TabAsset"]
        
        for k in 0...images.count-1 {
            let item = tabBar.items?[k]
            item?.title = titles[k]
            
            let imageName = images[k] + "Normal"
            let imageNameSelect = images[k] + "Select"
            
            item?.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
            item?.selectedImage = UIImage.init(named: imageNameSelect)?.withRenderingMode(.alwaysOriginal)
        }
        
//        let homeVC = HomeViewController()
//        let homeNVC = UINavigationController(rootViewController: homeVC)
//        homeNVC.view.backgroundColor = UIColor.white
//
//        let userVC = UserViewController()
//        let userNVC = UINavigationController(rootViewController: userVC)
//        userNVC.view.backgroundColor = UIColor.white
//
//        self.viewControllers = [homeNVC,userNVC]
//
//        let titles = ["Home","User"]
//        for i in 0 ..< (tabBar.items?.count)! {
//            let barItem = tabBar.items?[i]
//            barItem?.title = titles[i]
//        }
        
        networkMonitor()
    }
    
    private func networkMonitor()  {
        let networkManager = NetworkReachabilityManager(host: "www.baidu.com")
        networkManager?.startListening(onUpdatePerforming: { status in
            switch status {
            case .notReachable:
                print("网络已断开")
//                ProgressHUD.showError(text: "网络已断开")
            case .reachable(.cellular):
                print("正在使用手机网络")
//                ProgressHUD.showSuccess(text: "正在使用手机网络")
            default: break
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
