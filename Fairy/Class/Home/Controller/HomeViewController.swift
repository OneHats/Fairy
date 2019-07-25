//
//  HomeViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Kingfisher

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    private var bannerView:BannerScrollView?
    private var tableView:UITableView?
    private var dataArray:[JSON] = []
    private var refreshControl:UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightItemClick))
        
        setSubView()
        HttpManager.shareManage.getADList { (error, list) in
            if error == nil {
                self.bannerView?.dataArray = ADModel.getModelListWith(array: list!)
            }
        }
        
//        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bannerView?.openTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        bannerView?.invalidateTimer()
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
        
        let tableViewY = (bannerView?.frame.maxY)! + 10
        tableView = UITableView(frame: CGRect(x: 0, y: tableViewY, width: Screen_W, height: Screen_H - tableViewY - Bottom_H - 49), style: .plain)
//        tableView?.backgroundColor = UIColor.red
//        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.rowHeight = 50
        tableView?.layoutMargins = UIEdgeInsets.zero
        tableView?.separatorInset = UIEdgeInsets.zero
        tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.addSubview(tableView!)
        
        refreshControl = UIRefreshControl(frame: CGRect.zero)
        refreshControl?.attributedTitle = NSAttributedString(string: "加载中")
        refreshControl?.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
        tableView?.addSubview(refreshControl!)
    }
    
    @objc private func loadData() {
        HttpManager.shareManage.getHotLive { (error ,json ) in
            self.refreshControl?.endRefreshing()
            
            if error == nil {
                self.dataArray = json!
                self.tableView?.reloadData()
            }
        }
    }
    
    @objc private func rightItemClick() {
        let controller = LiveInfoController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
        }
        
        var imageV = cell?.contentView.viewWithTag(1111) as? UIImageView
        var textL = cell?.contentView.viewWithTag(2222) as? UILabel
        
        if imageV == nil  {
            imageV = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height:40))
            imageV?.tag = 1111
            cell?.contentView.addSubview(imageV!)
            
            textL = UILabel(frame: CGRect(x: 60, y: 5, width: 200, height:40))
            textL?.font = UIFont.systemFont(ofSize: 15)
            textL?.tag = 2222
            cell?.contentView.addSubview(textL!)
        }
        
//        if textL == nil  {
//            textL = UILabel(frame: CGRect(x: 60, y: 5, width: 200, height:40))
//            textL?.font = UIFont.systemFont(ofSize: 15)
//            textL?.tag = 2222
//            cell?.contentView.addSubview(textL!)
//        }
        
        let info = dataArray[indexPath.row]
        textL?.text = info["gps"].string
        imageV?.kf.setImage(with: URL(string: info["bigpic"].string!))
        
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        cell?.detailTextLabel?.text = info["myname"].string
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = LiveInfoController()
        controller.hidesBottomBarWhenPushed = true
        controller.liveModel = dataArray[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
