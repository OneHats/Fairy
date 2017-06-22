//
//  UIViewController+Tool.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/20.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAuthorizationStatusDeniedAlert(message:String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "知道啦", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(cancelAction)
        
        let operationAction = UIAlertAction(title: "去设置", style: UIAlertActionStyle.default) { (action) in
            self.openSetting()
        }
        alert.addAction(operationAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openSetting() {
        let url = URL(string: UIApplicationOpenSettingsURLString)
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.openURL(url!)
        }
    }
}
