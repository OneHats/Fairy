//
//  ADViewController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/6.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reuseIdentifier = "Cell"

class ADViewController: UIViewController,UICollectionViewDataSource {

    var collectionView:UICollectionView?
    var dataArray:[JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenWidth, height: ScreenWidth * 0.24)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight), collectionViewLayout: layout)
        collectionView?.backgroundColor = KBackgroundColor
        collectionView?.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        collectionView?.dataSource = self
        collectionView?.register(ADCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(collectionView!)
        
        HttpManager.shareManage.getADList { (error, list) in
            if error == nil {
                self.dataArray = list!
                self.collectionView?.reloadData()
            }
        }
        
    }
    
    //MARK:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ADCollectionViewCell
        
        let info = dataArray[indexPath.item]
//        cell.title = info["title"].string
        cell.imageUrl = info["imageUrl"].string
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
