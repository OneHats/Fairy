//
//  WebViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    
    var urlString:String?
    
    private var webView:WKWebView?
    
    deinit {
        webView?.removeObserver(self, forKeyPath: "title")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        leftItem()
        
        if urlString != nil {
            webView = WKWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
            webView?.navigationDelegate = self
            view.addSubview(webView!)
            
            let url = URL(string: urlString!)
            webView?.load(URLRequest(url: url!))
        }
        
//        let blurEffect = UIBlurEffect(style: .light)
//        let effectView = UIVisualEffectView(effect: blurEffect)
//        effectView.frame = view.bounds
//        view.addSubview(effectView)
        
        webView?.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "title" {
            if let newTitle = self.webView?.title {
                self.title = newTitle
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
