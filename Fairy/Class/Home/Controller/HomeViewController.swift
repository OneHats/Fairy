//
//  HomeViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tableView:UITableView?
    var dataArray:[JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        tableView?.tableFooterView = UIView()
        tableView?.dataSource = self
        tableView?.delegate = self
        self.view.addSubview(tableView!)
        
        HttpManager.shareManage.getADList { (error, list) in
            if error == nil {
                self.dataArray = list!
                self.tableView?.reloadData()
            }
        }
    }
    
    //MARK:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        let info = self.dataArray[indexPath.row]
        cell?.textLabel?.text = info["contents"].string
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = self.dataArray[indexPath.row]
        
        let controler = WebViewController()
        controler.urlString = info["link"].string
        controler.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controler, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
