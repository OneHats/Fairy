//
//  BannerScrollView.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/7.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON

private let reuseIdentifier = "Cell"
typealias ADClickBlock = (String)->()

class BannerScrollView: UIView,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var dataArray:[ADModel] = [] {
        didSet {
            collectionView?.reloadData()
            collectionView?.contentOffset = CGPoint(x: frame.width * CGFloat(dataArray.count), y: 0)
            
            pageControl?.numberOfPages = dataArray.count
            pageControl?.currentPage = 0
        }
    }
    
    var clickBlock:ADClickBlock?//点击回调
    
    private var collectionView:UICollectionView?
    private var pageControl:UIPageControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = KBaseBlueColor
        
        initilizeSubview()
    }
    
    func initilizeSubview() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = frame.size
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(origin: CGPoint.zero, size: frame.size), collectionViewLayout: layout)
        collectionView?.register(ADCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = KBackgroundColor
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        collectionView?.delegate = self
        addSubview(collectionView!)
        
        pageControl = UIPageControl()
        pageControl?.pageIndicatorTintColor = KBackgroundColor
        pageControl?.currentPageIndicatorTintColor = KBaseBlueColor
        pageControl?.center = CGPoint(x: frame.width * 0.5, y: frame.height - 10)
        addSubview(pageControl!)
    }
    
    //MARK:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count * 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ADCollectionViewCell
        
        let info = dataArray[indexPath.item % dataArray.count]
        cell.adInfo = info
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let info = dataArray[indexPath.item % dataArray.count]
        if self.clickBlock != nil {
            self.clickBlock!(info.link!)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width;
        pageControl?.currentPage = Int(page) % dataArray.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width;
        
        let oneScreen = CGFloat(dataArray.count) * scrollView.frame.width
        if Int(page) < dataArray.count {
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x + oneScreen, y: 0)
        } else if Int(page) > dataArray.count * 2 - 1 {
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x - oneScreen, y: 0)
        }
        pageControl?.currentPage = Int(page) % dataArray.count
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
