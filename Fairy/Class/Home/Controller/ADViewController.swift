//
//  ADViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reuseIdentifier = "Cell"

class ADViewController: UIViewController {
    
    private var bannerView:BannerScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        bannerView = BannerScrollView(frame: CGRect(x: 0, y: 64, width: Screen_W, height: Screen_W * 0.24))
        bannerView?.clickBlock = { link in
            let controller = WebViewController()
            controller.urlString = link
            self.navigationController?.pushViewController(controller, animated: true)
        }
        view.addSubview(bannerView!)
        
        HttpManager.shareManage.getADList { (error, list) in
            if error == nil {
                self.bannerView?.dataArray = ADModel.getModelListWith(array: list!)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        bannerView?.invalidateTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
