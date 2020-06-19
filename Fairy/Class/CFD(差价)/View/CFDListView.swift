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
import SwiftyJSON

class CFDListView: UIView,UITableViewDataSource,UITableViewDelegate,SocketDelegate {
    
    private let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
    private var dataList:[ContractInfo]?
    
    weak var fatherVC:UIViewController?
    
    //MARK:
    deinit {
        tableView.removeAllPullToRefresh()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        let hot = DataBase.share.getCFDHotTopTen()
        dataList = hot
        
        tableView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        tableView.register(UINib.init(nibName: "CFDListViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = 148
        tableView.sectionHeaderHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView()
        addSubview(tableView)
        
        let refresher = PullToRefresh()
        refresher.position = .top
        refresher.setEnable(isEnabled: true)
        tableView.addPullToRefresh(refresher) {
            let hot = DataBase.share.getCFDHotTopTen()
            self.dataList = hot
//            self.tableView.reloadData()

            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                self.tableView.endAllRefreshing()
                self.tableView.reloadData()
            }

        }
    }
    
    func didAppear() {
        SocketManager.share.delegate = self
        connectTicker()
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
    
    //MARK:
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var section = tableView.dequeueReusableHeaderFooterView(withIdentifier: "section")
        if section == nil {
            section = UITableViewHeaderFooterView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 44))
//            section!.backgroundColor = UIColor.clear
//            section!.backgroundView = UIColor.clear
            
            let titles = DataBase.share.getCFDTypes()
            let segmetFrame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 44)
            let segmet = Segmentio.initWithTitles(titles: titles,frame: segmetFrame)
            segmet.selectedSegmentioIndex = 0
            section?.addSubview(segmet)
        }
        
        return section
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
        
        let webVC = WebViewController.init()
        webVC.hidesBottomBarWhenPushed = true
        webVC.urlString = dataList![indexPath.row].icon
        fatherVC?.navigationController?.pushViewController(webVC, animated: true)
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
        return;
        let indexPath = tableView.indexPathsForVisibleRows
        
        if indexPath?.count == 0 {
            return
        }
        
        var codeList : [String] = []
        for k in 0...indexPath!.count-1 {
            let model = dataList?[k]
            
            let arr = model!.code.split(separator: "_")
            let code = arr.dropLast().joined(separator: "_")
            codeList.append(code)
        }
        
        SocketManager.share.subscribeTicker(codeArray: codeList)
        SocketManager.share.subscribePline(codeArray: codeList)
    }
    
    func disconnectTicker() {
        
    }

    func didReceive(JsonData: JSON) {
        let event = JsonData["event"].stringValue
        
        if event == "subscribe.ticker" {
            let tickerJson = JsonData["data"]
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
            let pline = JsonData["data"]["plines"]
            let code = JsonData["data"]["code"].stringValue
            
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
    
    func didReceive(socketData: [String : Any]) {
//        let channel = socketData["channel"] as! String
//        
//        if channel != ChannelPlineTicker {
//            return
//        }
        
        let code = socketData["code"] as! String
        if code.count == 0 {
            return
        }
        
        let plineTicker = socketData["data"] as! [String:Any]
        let tickArray = plineTicker["ticker"] as! [Any]
        if tickArray.count != 0 {
//            let ticker = MarketTicker.modelWithArray(array: tickArray)
//            MarketManager.share.ticketInfo[code] = ticker
        }
        
        //pline
        let pline = plineTicker["pline"] as! [Any]
        if pline.count != 0 {
            var tempArray : [String] = []
            for k in 0...pline.count - 1 {
                let price = (pline[k] as! [Any]).last
                if price is String {
                    tempArray.append(price as! String)
                } else if price is NSNumber {
                    tempArray.append((price as! NSNumber).stringValue)
                }
            }
            
            MarketManager.share.plineInfo[code] = tempArray
        }
        
        DispatchQueue.main.async {
            let cells = self.tableView.visibleCells
            for cell in cells {
                let cfdCell = cell as! CFDListViewCell
                let cellCode = cfdCell.contractInfo?.code
                
                if cellCode == code {
                    cfdCell.loadTicker()
                    
                    cfdCell.loadLayer()
                    return
                }
            }
        }
        
        
    }
}
