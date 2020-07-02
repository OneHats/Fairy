//
//  CFDLineController.swift
//  Icncde
//
//  Created by dssj on 2020/6/3.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

class CFDLineController: UIViewController,SocketDelegate {

    lazy var chartView: KSKChartView = {
        let chartView = KSKChartView.init(frame: CGRect.init(x: 0, y: NavigationBarH, width: ScreenWidth, height: 378))
//        chartView.delegate = self
        return chartView
    }()
    
    var contractInfo : ContractInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeColorBackground
        if contractInfo == nil {
            navigationController?.popViewController(animated: true)
            return
        }
        
        view.addSubview(chartView)
    
        SocketManager.share.delegate = self
        SocketManager.share.subscribeKline(code: "BTC_USD_COINBASE", period: Period.M1)
        SocketManager.share.subscribeTicker(codeArray: ["BTC_USD_COINBASE"])
    }
    
    //MARK:
    func didReceive(JsonData: JSON) {
        let event = JsonData["event"].stringValue
        if event == "subscribe.kline" {
            let dataArray = JsonData["data"]["klines"].arrayValue
            
            var chartDatas = [KSChartItem]()
            
            for value in dataArray {
                let arr = value.arrayValue
                let chartItem = KSChartItem.init()
                
                for k in 0...arr.count-1 {
                    let temp = arr[k]
                    if k == 0 {
                        chartItem.time = temp.intValue / 1000
                    } else if k == 1 {
                        chartItem.open = temp.stringValue
                    } else if k == 2 {
                        chartItem.high = temp.stringValue
                    } else if k == 3 {
                        chartItem.low = temp.stringValue
                    } else if k == 4 {
                        chartItem.close = temp.stringValue
                    } else if k == 5 {
                        chartItem.volume = temp.stringValue
                    }
                }
                chartDatas.append(chartItem)
                
            }
            
            DispatchQueue.main.async {
                self.chartView.resetChart(datas: chartDatas)
                self.chartView.chartView.refreshChart(isAll: true, isDraw: true, isChangeTai: true)
            }
            return;
        }
        
        if event == "subscribe.ticker" {
            let dataArray = JsonData["data"]
            let ticker = MarketTicker.modelWithJsonData(json: dataArray)
            MarketManager.share.ticketInfo[ticker.code] = ticker
            
            let klineData = self.chartView.klineData
            guard let item = klineData.last else {
                return
            }
            if item.time < Int(ticker.timestamp)! / 1000 {
                print("++++++++++")
            } else {
                item.close = ticker.price
                
                if Double(item.lowPrice) > Double(ticker.price)! {
                    item.low = ticker.price
                }
                if Double(item.highPrice) < Double(ticker.price)! {
                    item.high = ticker.price
                }
                
            }
            
            DispatchQueue.main.async {
                self.chartView.resetChart(datas: klineData)
                self.chartView.chartView.refreshChart(isAll: true, isDraw: true, isChangeTai: true)
            }
            
        }
        
//        let period = JsonData["data"]["period"].stringValue
    }
    
    func didReceive(socketData: [String : Any]) {
        let event = socketData["event"] as! String
        if event != "subscribe.kline" {
            return
        }
        
//        let code = socketData["code"] as! String
//        if code.count == 0 || code != contractInfo!.code {
//            return
//        }
        
        var chartDatas = [KSChartItem]()
        
        let klines = socketData["data"] as! Array<Any>
        for value in klines {
            let arr = value as! Array<Any>
            
            let chartItem = KSChartItem.init()
            
            for k in 0...arr.count-1 {
                let temp = arr[k]
                
                if k == 0 {
                    if temp is String {
                        chartItem.time = Int(temp as! String)!
                    } else if temp is NSNumber {
                        chartItem.time = (temp as! NSNumber).intValue
                    }
                    
                } else if k == 1 {
                    if temp is String {
                        chartItem.open = (temp as! String)
                    } else if temp is NSNumber {
                        chartItem.open = (temp as! NSNumber).stringValue
                    }
                } else if k == 2 {
                    if temp is String {
                        chartItem.high = (temp as! String)
                    } else if temp is NSNumber {
                        chartItem.high = (temp as! NSNumber).stringValue
                    }
                } else if k == 3 {
                    if temp is String {
                        chartItem.low = (temp as! String)
                    } else if temp is NSNumber {
                        chartItem.low = (temp as! NSNumber).stringValue
                    }
                } else if k == 4 {
                    if temp is String {
                        chartItem.close = (temp as! String)
                    } else if temp is NSNumber {
                        chartItem.close = (temp as! NSNumber).stringValue
                    }
                } else if k == 5 {
                    if temp is String {
                        chartItem.volume = (temp as! String)
                    } else if temp is NSNumber {
                        chartItem.volume = (temp as! NSNumber).stringValue
                    }
                }
                
            }
            
            chartDatas.append(chartItem)
        }
        
        DispatchQueue.main.async {
            self.chartView.resetChart(datas: chartDatas)
            self.chartView.chartView.refreshChart(isAll: true, isDraw: true, isChangeTai: true)
        }
        
    }
    
}

extension CFDLineController : KSKChartViewDelegate {
}
