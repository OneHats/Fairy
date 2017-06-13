//
//  ADCollectionViewCell.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON

class ADCollectionViewCell: UICollectionViewCell {
    
    var adInfo:ADModel? {
        didSet {
            imageView?.kf.setImage(with: URL(string: (adInfo?.imageUrl!)!))
            titleLabel?.text = adInfo?.title
        }
    }
    
    private var titleLabel:UILabel?
    private var imageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        let viewW = frame.size.width
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewW, height: frame.size.height))
        contentView.addSubview(imageView!)
        
//        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: viewW, height: 30))
//        contentView.addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
