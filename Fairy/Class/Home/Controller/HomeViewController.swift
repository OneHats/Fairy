//
//  HomeViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON
import Moya
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
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightItemClick))
        
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
    
    //MARK:
    private func setSubView() {
        bannerView = BannerScrollView(frame: CGRect(x: 0, y: StatusBar_H + Nav_H, width: Screen_W, height: Screen_W * 0.24))
        bannerView?.clickBlock = { link in
            let controller = WebViewController()
            controller.hidesBottomBarWhenPushed = true
            controller.urlString = link
            self.navigationController?.pushViewController(controller, animated: true)
        }
        view.addSubview(bannerView!)
    }
    
    @objc private func rightItemClick() {
        let controller = LiveInfoController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
