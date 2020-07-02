//
//  UIViewController+Tool.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/20.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAuthorizationStatusDeniedAlert(title:String) {
        let alert = UIAlertController(title: nil, message: title, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "知道啦", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(cancelAction)
        
        let operationAction = UIAlertAction(title: "去设置", style: UIAlertAction.Style.default) { (action) in
            self.openSetting()
        }
        alert.addAction(operationAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openSetting() {
        let url = URL(string: UIApplication.openSettingsURLString)
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:]) { _ in
            }
        }
    }
    
    //MARK:--------------navigationItem
    func rightItemWith(style:UIBarButtonItem.SystemItem) {
        let item = UIBarButtonItem(barButtonSystemItem: style,
                                   target: self,
                                   action: #selector(rightItemClick))
        self.navigationItem.rightBarButtonItem = item
    }
    
    func rightItemWith(title:String,color:UIColor) {
        let item = UIBarButtonItem(title: title,
                                   style: .plain,
                                   target: self,
                                   action: #selector(rightItemClick))
        let attri = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14),
                     NSAttributedString.Key.foregroundColor:color]
        item.setTitleTextAttributes(attri, for: .normal)
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func rightItemClick() {
    }
    
}
