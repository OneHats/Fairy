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
    
    private var bannerView:BannerScrollView?
    private var tableView:UITableView?
    private var dataArray:[JSON] = []
    private var refreshControl:UIRefreshControl?
    
    var cfdView : CFDListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        self.rightItemWith(title: "看来", color: .white)
        self.rightItemWith(style: .add)
        
//        setSubView()
        cfdView = CFDListView.init(frame: CGRect(x: 0, y: NavigationBarH, width: ScreenWidth, height: ScreenHeight - NavigationBarH-TabBarH - BottomH))
        cfdView?.fatherVC = self
        view.addSubview(cfdView!)
        
//        let target = MultiTarget(MiaoService.GetAD)
//        NetWorkManager.request(target, success: { json in
//            self.bannerView?.dataArray = ADModel.arrayWithJson(json: json)
//        }) { _ in
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cfdView?.didAppear()
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
