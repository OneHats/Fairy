//
//  PhotosLibraryController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/20.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import Photos

class PhotosLibraryController: UIViewController,UITableViewDataSource {

    private var tableView:UITableView?
    private var dataArray:PHFetchResult<PHAssetCollection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.dataSource = self
//        tableView?.delegate = self
        tableView?.rowHeight = 50
        view.addSubview(tableView!)
    }
    
    //MARK:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let collection = dataArray?[indexPath.row]
        let fetch = PHAsset.fetchAssets(in: collection!, options: nil)
        
        cell.textLabel?.text = (collection?.localizedTitle)! + "(\(fetch.count))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutMargins = UIEdgeInsets.zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
