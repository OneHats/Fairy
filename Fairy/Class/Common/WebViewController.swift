//
//  WebViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var urlString:String?
    
    private var webView:WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        if urlString != nil {
            webView = WKWebView(frame: CGRect(x: 0, y: 0, width: Screen_W, height: Screen_H))
            view.addSubview(webView!)
            
            let url = URL(string: urlString!)
            webView?.load(URLRequest(url: url!))
        }
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let effectView = UIVisualEffectView(effect: blurEffect)
//        effectView.frame = view.bounds
//        view.addSubview(effectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
