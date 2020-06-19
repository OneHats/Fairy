//
//  CFDListViewCell.swift
//  Icncde
//
//  Created by dssj on 2020/5/19.
//  Copyright © 2020 dssj. All rights reserved.
//

import UIKit
import Macaw

class CFDListViewCell: UITableViewCell {

    @IBOutlet weak var imageBackView: UIView!
    
    @IBOutlet weak var commodityLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var plineView: UIView!
    
    var iconView: SVGView = SVGView.init()
    
    lazy var marketLayer : CAShapeLayer = {
        let marketLayer = CAShapeLayer.init()
        marketLayer.fillColor = UIColor.clear.cgColor
        marketLayer.strokeColor = UIColor.red.cgColor
        marketLayer.lineJoin = .round
        plineView.layer.addSublayer(marketLayer)
        
        return marketLayer
    }()
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var rightButtonW: NSLayoutConstraint!
    
    var code = ""
    var contractInfo : ContractInfo? {
        didSet {
            guard let contractInfo = contractInfo else {
                code = ""
                return
            }
            
            let arr = contractInfo.code.split(separator: "_")
            code = arr.dropLast().joined(separator: "_")
            
            commodityLabel.text = contractInfo.name
            
            if let svg = contractInfo.iconValue.unWrapBase64() {
                if let node = try? SVGParser.parse(text: svg) {
                    iconView.node = node
                    imageBackView.addSubview(iconView)
                }
            }
            
            needLoadTicker = true
            loadTicker()
            loadLayer()
        }
    }
    
    private var needLoadTicker = true
    
    //MARK:
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        rightButtonW.constant = ceil(ScreenWidth / 375.0 * 80)
        
        plineView.backgroundColor = UIColor.clear
        
        iconView.frame = imageBackView.bounds
        iconView.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:
    func loadTicker() {
        if !needLoadTicker {
            return
        }
        
        let ticker = MarketManager.share.ticketInfo[code]
        if ticker == nil {
            priceLabel.text = "--"
            leftButton.setTitle("--", for: .normal)
            rightButton.setTitle("--", for: .normal)
            
            priceLabel.textColor = ThemeColorBlack
            leftButton.setTitleColor(ThemeColorBlack, for: .normal)
            rightButton.setTitleColor(ThemeColorBlack, for: .normal)
            return
        }
        
        needLoadTicker = false
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.needLoadTicker = true
        }
        
        priceLabel.text = ticker!.price.decimalWith(decimal: 2)
        leftButton.setTitle(ticker!.ask.decimalWith(decimal: 2), for: .normal)
        rightButton.setTitle(ticker!.bid.decimalWith(decimal: 2), for: .normal)
        
        let rise = Double(ticker!.price)! - Double(ticker!.open)!
        if rise > 0 {
            priceLabel.textColor = ThemeColorGreen
            leftButton.setTitleColor(ThemeColorGreen, for: .normal)
            rightButton.setTitleColor(ThemeColorGreen, for: .normal)
            marketLayer.strokeColor = ThemeColorGreen.cgColor
        } else if rise < 0 {
            priceLabel.textColor = ThemeColorRed
            leftButton.setTitleColor(ThemeColorRed, for: .normal)
            rightButton.setTitleColor(ThemeColorRed, for: .normal)
            marketLayer.strokeColor = ThemeColorRed.cgColor
        } else {
            priceLabel.textColor = ThemeColorBlack
            leftButton.setTitleColor(ThemeColorBlack, for: .normal)
            rightButton.setTitleColor(ThemeColorBlack, for: .normal)
            marketLayer.strokeColor = ThemeColorBlack.cgColor
        }
    }
    
    func loadLayer() {
        let lineArray = MarketManager.share.plineInfo[code]
        if lineArray == nil || lineArray?.count == 0 {
            marketLayer.path = UIBezierPath.init().cgPath
            return
        }
        
        let maxValue = lineArray!.max()!
        let minValue = lineArray!.min()!
        var maxPrice = CGFloat(Double(maxValue)!)
        var minPrice = CGFloat(Double(minValue)!)
        
        if (maxPrice - minPrice == 0.0) {
            maxPrice = maxPrice * 1.1;
            minPrice = minPrice * 0.9;
        }
        
        let viewH = plineView.frame.height
        let viewW = plineView.frame.width
        let preH = viewH / CGFloat(maxPrice - minPrice)
        let preW = viewW / CGFloat(lineArray!.count)
        
        let path = UIBezierPath.init()
        for k in 0...lineArray!.count - 1 {
            let value = lineArray![k]
            let price = CGFloat(Double(value)!)
            
            let viewX = preW * CGFloat(k)
            let viewY = preH * (price-minPrice);
            
            if k != 0 {
                path.addLine(to: CGPoint(x: viewX, y: viewY))
            } else {
                path.move(to: CGPoint(x: viewX, y: viewY))
            }
            
        }
        
        marketLayer.path = path.cgPath
    }
    
}
