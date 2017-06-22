//
//  PhotosCollectionController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/21.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import Photos

class PhotosCollectionController: UIViewController,UICollectionViewDataSource {
    
    var fetchResult:PHFetchResult<PHAsset>?
    
    private let identifier = "cell"
    private var collectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        if (fetchResult?.count)! > 0 {
            let flowLayout = UICollectionViewFlowLayout()
            
            flowLayout.itemSize = CGSize(width: (Screen_W - 30) / 2.0, height: (Screen_W - 30) / 2.0)
            flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
            
            collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
            collectionView?.backgroundColor = UIColor.white
            collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: identifier)
            collectionView?.dataSource = self
            view.addSubview(collectionView!)
        }
    }
    
    //MARK:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (fetchResult?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        var imageView = cell.viewWithTag(1111) as? UIImageView
        if imageView == nil {
            imageView = UIImageView(frame: cell.bounds)
            cell.contentView.addSubview(imageView!)
        }
        
        let asset = fetchResult?[indexPath.item]
        PHImageManager.default().requestImage(for: asset!, targetSize: CGSize.zero, contentMode: PHImageContentMode.aspectFit, options: nil) { (image, _) in
            imageView?.image = image
        }
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
