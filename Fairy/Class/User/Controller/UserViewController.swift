//
//  UserViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    private var tableView:UITableView?
    private var dataArray = [["01"],["001","002"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.sectionFooterHeight = 0.0
        tableView?.layoutMargins = UIEdgeInsets.zero
        tableView?.separatorInset = UIEdgeInsets.zero
        view.addSubview(tableView!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = dataArray[section]
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let array = dataArray[indexPath.section]
        cell.textLabel?.text = array[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
