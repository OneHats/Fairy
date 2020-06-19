//
//  PhotosLibraryController.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/20.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import Photos

class PhotosLibraryController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    private var tableView:UITableView?
    private var dataArray:PHFetchResult<PHAssetCollection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        checkStatus()
    }
    
    func checkStatus() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            addSubView()
            
        case .denied:
            ProgressHUD.showError(text: "已经禁用")
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.addSubView()
                    }
                    
                case .denied:
                    DispatchQueue.main.async {
                        ProgressHUD.showError(text: "已经禁用")
                    }
                    
                default:
                    break
                }
            })
            
        default:
            break
        }
        
    }
    
    func addSubView() {
        dataArray = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
        
        tableView = UITableView(frame: view.bounds, style: UITableView.Style.plain)
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.dataSource = self
        tableView?.delegate = self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collection = dataArray?[indexPath.row]
        let fetch = PHAsset.fetchAssets(in: collection!, options: nil)
        
        let controller = PhotosCollectionController()
        controller.fetchResult = fetch
        navigationController?.pushViewController(controller, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("ddddddd")
    }
}
