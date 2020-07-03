//
//  HomeViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    private let ADCacheKey = "ADCacheKey"
    private var bannerView:BannerScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        rightItem(systemItem: .add)
        
        setSubView()
        
        if let adCache = UserDefaults.standard.object(forKey: ADCacheKey) {
            let json = JSON(adCache)
            self.bannerView?.dataArray = ADModel.arrayWithJson(json: json)
        }
        
        let target = MultiTarget(MiaoService.GetAD)
        NetWorkManager.request(target, success: { json in
            UserDefaults.standard.set(json.dictionaryObject, forKey: self.ADCacheKey)
            self.bannerView?.dataArray = ADModel.arrayWithJson(json: json)
        }) { _ in
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:
    private func setSubView() {
        bannerView = BannerScrollView(frame: CGRect(x: 0, y: NavigationBarH, width: ScreenWidth, height: ScreenWidth * 0.24))
        bannerView?.clickBlock = { link in
            let controller = WebViewController()
            controller.hidesBottomBarWhenPushed = true
            controller.urlString = link
            self.navigationController?.pushViewController(controller, animated: true)
        }
        view.addSubview(bannerView!)
    }
    
    override func rightItemClick() {
        self.showAuthorizationStatusDeniedAlert(title: "GO")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
