//
//  SocketManager.swift
//  Icncde
//
//  Created by dssj on 2020/5/20.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit
import Starscream
import Gzip

public protocol SocketDelegate: class {
//    func didReceive(socketData: [String:Any])
    func didReceive(jsonData: JSON)
}

class SocketManager: NSObject,WebSocketDelegate {
    
    static let share = SocketManager()
    var delegate : SocketDelegate?
    
    private var socket : WebSocket?
    private var isConnected = false
    private let connectedMax = 6
    private var connectedTimes = 0
    
    override init() {
        super.init()
    }
    
    func open() {
        if socket != nil {
            isConnected = false
            socket?.disconnect()
            socket = nil
        }
        
        var request = URLRequest(url: URL(string: BaseSocketUrl)!)
        request.timeoutInterval = 10
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.callbackQueue = DispatchQueue(label: "Icncde.Socket.Queue")
        socket?.connect()
    }
    
    //MARK:
//    func subscribeTime() {
//        if !isConnected {
//            connect()
//            return
//        }
//
//        let dict = ["event":"subscribe.time"]
//        let time = dict.jsonString()
//        socket?.write(string: time) {
//        }
//    }
    
    func subscribePing() {
        if !isConnected {
//            open()
            return
        }
        let dict = ["event":"ping"]
        socket?.write(ping: dict.jsonData())
    }
    
    func subscribeKline(code:String,period:String) {
        if !isConnected {
            return
        }
        
        //
        let data = ["code":code,"period":period]
        let kline = ["event":"subscribe.kline","data":data] as [String : Any]
        socket?.write(string: kline.jsonString(), completion: {
        })
    }
    
    func subscribePline(codeArray:[String]) {
        if !isConnected {
            return
        }
        
        //
        let code = codeArray.joined(separator: ",")
        let data = ["code":code,"period":Period.M15]
        let kline = ["event":"subscribe.pline","data":data] as [String : Any]
        socket?.write(string: kline.jsonString(), completion: {
        })
    }
    
    //MARK:
    func subscribeTicker(codeArray:[String]) {
        if !isConnected {
            return
        }
        
        //
        let code = codeArray.joined(separator: ",")
        let data = ["code":code,"period":Period.DAY]
        let ticker = ["event":"subscribe.ticker","data":data] as [String : Any]
        socket?.write(string: ticker.jsonString(), completion: {
        })
    }
    
//    func unsubscribeTicker(code:String) {
//        if !isConnected {
//            connect()
//            return
//        }
//
//        //
//        let data = ["code":code,"period":MarketPeriod.DAY] as [String : Any]
//        let kline = ["event":"subscribe.kline","data":data] as [String : Any]
//        socket?.write(string: kline.jsonString(), completion: {
//        })
//    }
    
    
    func subscribePlinesTickerArray(codeList:[String]) {
        if !isConnected {
            return
        }
        
        //
        let code = codeList.joined(separator: ",")
        let data = ["code":code]
        let dd = ["event":"SUBSCRIBE",
                  "channel":"",
                  "data":data] as [String : Any]
        
        let str = dd.jsonString()
        socket?.write(string: str, completion: {
        })
        
    }
    
    //MARK:
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected( _):
            isConnected = true
            subscribePing()
            print("websocket: \(client.request.url!.absoluteString)")
            
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
            
        case .text(_):
            break
//            guard let sDelegate = delegate else { break }
//            sDelegate.didReceive(socketData: string.jsonObject())
            
        case .binary(let data):
//            print("Received data: \(data.count)")
            
            let decompressedData: Data
            if data.isGzipped {
                decompressedData = try! data.gunzipped()
            } else {
                decompressedData = data
            }
            
            let result = JSON(decompressedData)
            
            if result["event"].stringValue == "subscribe.time" {
                return
            }
            
            guard let sDelegate = delegate else { break }
            sDelegate.didReceive(jsonData: result)
            break
            
        case .ping(_):
            break
        case .pong(_):
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 20) {
                self.subscribePing()
            }
            break
        case .viabilityChanged(_):
//            print("viabilityChanged")
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
            break
        case .error(let error):
            isConnected = false
            print("sockerError"+String(describing: error))
        }
        
    }
    
    
}
