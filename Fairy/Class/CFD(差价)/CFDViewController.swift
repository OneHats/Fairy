//
//  CFDViewController.swift
//  Icncde
//
//  Created by dssj on 2020/5/14.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

class CFDViewController: UIViewController,SocketDelegate {
    
    var cfdView : CFDListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "CFD"
        
        cfdView = CFDListView.init(frame: CGRect(x: 0, y: NavigationBarH, width: ScreenWidth, height: ScreenHeight - NavigationBarH-TabBarH - BottomH))
        cfdView?.fatherVC = self
        view.addSubview(cfdView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SocketManager.share.delegate = self
        cfdView?.didAppear()
    }
    
    func didReceive(jsonData: JSON) {
        cfdView?.receiveSocketData(jsonData)
    }
    
    
}
