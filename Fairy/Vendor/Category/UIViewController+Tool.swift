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
    func leftItem(withTitle text:String) {
        print(text)
    }
    
    func leftItem(imageName name:String? = nil) {
        var name = name
        if name == nil {
            name = "leftItemImage"
        }
        let img = UIImage(named: name!)
        let leftItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(leftItemClick))
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func rightItem(systemItem style:UIBarButtonItem.SystemItem) {
        let rightItem = UIBarButtonItem(barButtonSystemItem: style, target: self, action: #selector(rightItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    func rightItem(withTitle text:String,color:UIColor) {
        let rightItem = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(rightItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    func rightItem(imageName name:String) {
        let img = UIImage(named: name)
        let rightItem = UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(rightItemClick))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func leftItemClick() {
        if let nvc = self.navigationController {
            if nvc.viewControllers.count > 0 {
                nvc.popViewController(animated: true)
                return
            }
        }
        self.dismiss(animated: true) {
        }
    }
    
    @objc func rightItemClick() {
    }
    
}
