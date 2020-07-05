//
//  CFDListView.swift
//  Icncde
//
//  Created by dssj on 2020/5/19.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit
import PullToRefresh
import Segmentio

class CFDListView: UIView,UITableViewDataSource,UITableViewDelegate {
    
    private let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
    private var dataList:[ContractInfo]?
    
    weak var fatherVC:UIViewController?
    
    //MARK:
    deinit {
        tableView.removeAllPullToRefresh()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        tableView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        tableView.frame = self.bounds
        tableView.register(UINib.init(nibName: "CFDListViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 148
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView()
        addSubview(tableView)
        
        let refresher = PullToRefresh()
        refresher.position = .top
        refresher.setEnable(isEnabled: true)
        tableView.addPullToRefresh(refresher) {
            self.requestCacheData()
        }
        
        requestCacheData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didAppear() {
        connectTicker()
    }
    
    func requestCacheData() {
        DispatchQueue.global().async {
            self.dataList = DataBase.share.getWSCList()
        }
        
        DispatchQueue.main.async {
            self.tableView.endAllRefreshing()
            self.tableView.reloadData()
            self.connectTicker()
        }
    }
    
    //MARK:
    private func headerView() -> UIView {
        let assetH = CGFloat(140)
        let assetView = ShowAssetView.loadNibView(nibname: nil)
        assetView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: assetH)
        
        
        let headerH = assetH
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: headerH))
        headerView.addSubview(assetView)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = dataList?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CFDListViewCell
        let contract = dataList![indexPath.row]
        cell.contractInfo = contract
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let lineVC = CFDLineController.init()
//        lineVC.hidesBottomBarWhenPushed = true
//        lineVC.contractInfo = dataList![indexPath.row]
//        fatherVC?.navigationController?.pushViewController(lineVC, animated: true)
        
//        let webVC = WebViewController.init()
//        webVC.hidesBottomBarWhenPushed = true
//        webVC.urlString = dataList![indexPath.row].icon
//        fatherVC?.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            connectTicker()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        connectTicker()
    }
    
    //MARK:
    func connectTicker() {
        
        let indexPath = tableView.indexPathsForVisibleRows
        if indexPath?.count == 0 {
            return
        }
        
        guard let dataList = dataList else {
            return
        }
        
        var codeList : [String] = []
        for k in 0...indexPath!.count-1 {
            let model = dataList[k]
            
            let k = model.code.lastIndex(of: "_")
            if let k = k {
                let code = model.code.prefix(upTo: k)
                codeList.append(String(code))
            }
            
//            let arr = model!.code.split(separator: "_")
//            let code = arr.dropLast().joined(separator: "_")
//            codeList.append(code)
        }
        
        SocketManager.share.subscribeTicker(codeArray: codeList)
        SocketManager.share.subscribePline(codeArray: codeList)
    }
    
    func disconnectTicker() {
        
    }
    
    func receiveSocketData(_ jsonData: JSON) {
        let event = jsonData["event"].stringValue
        
        if event == "subscribe.ticker" {
            let tickerJson = jsonData["data"]
            let ticker = MarketTicker.modelWithJsonData(json: tickerJson)
            MarketManager.share.ticketInfo[ticker.code] = ticker
            
            DispatchQueue.main.async {
                let cells = self.tableView.visibleCells
                for cell in cells {
                    let cfdCell = cell as! CFDListViewCell
                    guard let cellCode = cfdCell.contractInfo?.code else {
                        return
                    }
                    
                    if cellCode.contains(ticker.code) {
                        cfdCell.loadTicker()
                    }
                }
            }
            
            return
        }
        
        if event == "subscribe.pline" {
            let pline = jsonData["data"]["plines"]
            let code = jsonData["data"]["code"].stringValue
            if pline.array?.count == 0 {
                return
            }
            
            var tempArray : [String] = []
            for k in 0...pline.count - 1 {
                let json = pline[k].array!.last
                let price = json!.stringValue
                tempArray.append(price)
            }
            MarketManager.share.plineInfo[code] = tempArray
            
            DispatchQueue.main.async {
                let cells = self.tableView.visibleCells
                for cell in cells {
                    let cfdCell = cell as! CFDListViewCell
                    guard let cellCode = cfdCell.contractInfo?.code else {
                        return
                    }
                    
                    if cellCode.contains(code) {
                        cfdCell.loadLayer()
                    }
                }
            }
            
            return
        }
        
    }
    
    
}
