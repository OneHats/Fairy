//
//  CFDViewController.swift
//  Icncde
//
//  Created by dssj on 2020/5/14.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit

class CFDViewController: UIViewController {
    
    let scrollView = UIScrollView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "CCC"
        
        scrollView.frame = self.view.bounds
        scrollView.backgroundColor = ThemeColorBlue
        view.addSubview(scrollView)
    }

    
    
    
}
