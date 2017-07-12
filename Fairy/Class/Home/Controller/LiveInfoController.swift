//
//  LiveInfoController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/7/5.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class LiveInfoController: UIViewController {

    var liveModel:JSON?
    private var imageView:UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.title = liveModel?["myname"].string
        
//        imageView = UIImageView(frame: CGRect(x: 0, y: 64, width: Screen_W, height: Screen_W))
//        imageView.kf.setImage(with: URL(string: (liveModel?["bigpic"].string)!))
//        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
