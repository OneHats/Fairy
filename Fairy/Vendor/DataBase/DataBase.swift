//
//  DataBase.swift
//  Icncde
//
//  Created by dssj on 2020/5/19.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit
import SQLite

class DataBase: NSObject {

    static let share : DataBase = DataBase()
//    static let share : DataBase = {
//        let share : DataBase = DataBase()
//        return share
//    }()
    
    private var db:Connection?
    private var contract:Table
    
    let code = Expression<String>("code")
    let name = Expression<String>("name")
    var currency = Expression<String>("currency")
    let commodity = Expression<String>("commodity")
    let country = Expression<String>("country")
    let type = Expression<String>("type")
    let exType = Expression<String>("exType")
    let tag = Expression<String>("tag")
    let symbol = Expression<String>("symbol")
    let icon = Expression<String>("icon")
    let circulation = Expression<String>("circulation")
    
//    let lowMargin = Expression<String>("lowMargin")
    
    override init() {
        let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let path = documents! + "/db.sqlite"
//        print(path)
        
        db = try? Connection(path)
        contract = Table("contract")
        super.init()
        
        openDB()
    }
    
    func openDB() {
        guard let db = db else {
            return
        }
        
        _ = try? db.run(contract.create(ifNotExists:true,block: { t in
            t.column(code,unique: true)
            t.column(name)
            t.column(currency)
            t.column(commodity)
            t.column(country)
            t.column(type)
            t.column(exType)
            t.column(tag)
            t.column(symbol)
            t.column(icon)
        }))
//        _ = try? db.run(contract.addColumn(circulation, defaultValue: "0"))
    }
    
    //MARK:
    func updateContract(datas:[JSON]) {
        guard let db = db else {
            return
        }
        
        _ = try? db.run(contract.delete())
        for k in datas {
            let insert = contract.insert(code <- k["code"].stringValue,
                                         name <- k["name"].stringValue,
                                         currency <- k["currency"].stringValue,
                                         commodity <- k["commodity"].stringValue,
                                         country <- k["country"].stringValue,
                                         type <- k["type"].stringValue,
                                         exType <- k["exType"].stringValue,
                                         tag <- k["tag"].stringValue,
                                         symbol <- k["symbol"].stringValue,
                                         icon <- k["icon"].stringValue,
                                         circulation <- k["circulation"].stringValue
            )
            _ = try? db.run(insert)
        }
        
    }
    
    //MARK:
    func getCFDHotTopTen() -> [ContractInfo] {
        guard let db = db else {
            return []
        }
        
//        let hot = contract.filter(type == "ENCRY")
        guard let result = try? db.prepare(contract) else {
            return []
        }
        
        var arr = [ContractInfo]()
        for contract in result {
            let obj = ContractInfo()
            obj.code = contract[code]
            obj.name = contract[name]
            obj.currency = contract[currency]
            obj.commodity = contract[commodity]
            obj.type = contract[type]
            obj.exType = contract[exType]
            obj.tag = contract[tag]
            obj.symbol = contract[symbol]
            obj.icon = contract[icon]
            obj.circulation = contract[circulation]
            
            arr.append(obj)
        }
        
        return arr
    }
    
    func getCFDTypes() -> [String] {
        guard let db = db else {
            return []
        }
        
        let hot = contract.group(type)
        var arr = [String]()
        
        guard let result = try? db.prepare(hot) else {
            return []
        }
        
        for contract in result {
            arr.append(contract[type])
        }
        
        return arr
    }
    
    //MARK:
    func canOperation() -> Bool {
        guard db != nil else {
            return false
        }
        return true
    }
}
