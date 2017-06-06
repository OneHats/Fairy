//
//  RootViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = HomeViewController()
        let homeNVC = UINavigationController(rootViewController: homeVC)
        homeNVC.view.backgroundColor = UIColor.white
        
        let userVC = UserViewController()
        let userNVC = UINavigationController(rootViewController: userVC)
        
        self.viewControllers = [homeNVC,userNVC]
        
        let titles = ["Home","User"]
        for i in 0 ..< (tabBar.items?.count)! {
            let barItem = tabBar.items?[i]
            barItem?.title = titles[i]
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
