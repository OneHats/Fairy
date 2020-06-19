//
//  BannerScrollView.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/7.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

private let reuseIdentifier = "Cell"
typealias ADClickBlock = (String)->()

class BannerScrollView: UIView,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var dataArray:[ADModel] = [] {
        didSet {
            totalPage = dataArray.count * 20
            collectionView?.reloadData()
            collectionView?.contentOffset = CGPoint(x: frame.width * CGFloat(totalPage / 2), y: 0)
            
            if dataArray.count > 1 {
                pageControl?.numberOfPages = dataArray.count
                pageControl?.currentPage = 0
                
                beginTimer()
            }
        }
    }
    
    var clickBlock:ADClickBlock?//点击回调
    
    private var collectionView:UICollectionView?
    private var pageControl:UIPageControl?
    private var totalPage:Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = KBaseBlueColor
        
        initilizeSubview()
    }
    
    private func initilizeSubview() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = frame.size
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        return totalPage
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        var imageV = cell.contentView.viewWithTag(1111) as? UIImageView
        if imageV == nil  {
            imageV = UIImageView(frame: cell.contentView.bounds)
            imageV?.tag = 1111
            cell.contentView.addSubview(imageV!)
        }
        
        let info = dataArray[indexPath.item % dataArray.count]
        if info.imageUrl != nil {
            imageV?.kf.setImage(with: URL(string: info.imageUrl!))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let info = dataArray[indexPath.item % dataArray.count]
        if self.clickBlock != nil && info.link != nil {
            self.clickBlock!(info.link!)
        }
    }
    
    //MARK:
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        endTimer()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = currentPage(scrollView)
        if velocity.x > 0 {
            pageControl?.currentPage = (page + 1) % dataArray.count
        } else if velocity.x < 0 {
            pageControl?.currentPage = page % dataArray.count
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            beginTimer()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        beginTimer()
        
        let page = currentPage(scrollView)
        pageControl?.currentPage = page % dataArray.count
        
        if page == 0 || Int(page) == totalPage - 1 {
            collectionView?.scrollToItem(at: IndexPath(item: totalPage / 2, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
        }
    }
    
    private func currentPage(_ scrollView:UIScrollView) -> Int {
        return Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
    //MARK:
    @objc private func autoScroll() {
        var currentPage = self.currentPage(collectionView!) + 1
        
        if currentPage >= totalPage {
            currentPage = totalPage / 2
            
            collectionView?.scrollToItem(at: IndexPath(item: currentPage - 1, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
            collectionView?.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        } else {
            collectionView?.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        }
        
        pageControl?.currentPage = currentPage % dataArray.count
        
        beginTimer()
    }
    
    func beginTimer() {
        self.perform(#selector(autoScroll), with: nil, afterDelay: 3.0, inModes: [.default])
    }
    
    func endTimer() {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
    }
}
