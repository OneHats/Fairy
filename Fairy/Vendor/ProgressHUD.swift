//
//  ProgressHUD.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/7.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit

enum HudType:Int {
    case Text
    case Indicator
}

class ProgressHUD: UIView {
    
    private var indicator:UIActivityIndicatorView?
    private var contentView:UIView = UIView()
    
    private var HudWidth:CGFloat = 0.0
    private var HudHeight:CGFloat = 0.0
    
    private var timer:Timer?
    
    //MARK: - public
    class func loading(backView:UIView?,text:String?) {
        var backView = backView
        if backView == nil {
            backView = UIApplication.shared.windows.last
        }
        
        let hud = ProgressHUD(frame: (backView?.bounds)!, type:.Indicator)
        
        if text != nil {
            let labelW = hud.contentView.frame.width
            
            let label = UILabel(frame: CGRect(x: 0.0, y: 50, width: labelW, height: hud.contentView.frame.height - 50))
            label.textAlignment = .center
            label.numberOfLines = 0
            label.text = text
            label.font = UIFont.systemFont(ofSize: 15)
            hud.contentView.addSubview(label)
        } else {
            hud.contentView.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            hud.indicator?.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        }
        
        backView?.addSubview(hud)
    }
    
    class func showSuccess(text:String?) {
        let backView = UIApplication.shared.windows.last
        let hud = ProgressHUD(frame: (backView?.bounds)!, type: .Text)
        
        let labelW = hud.contentView.frame.width
        
        let label = UILabel(frame: CGRect(x: 0.0, y: 0, width: labelW, height: 50))
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = (text != nil && text?.characters.count != 0 ) ? text : "操作成功"
        hud.contentView.addSubview(label)
        backView?.addSubview(hud)
        
        hud.hideHudAfterDealy(dealyTime: 2.0)
    }
    
    class func hideForView(backView:UIView) -> Bool {
        if let hud = ProgressHUD.HUDForView(backView: backView) {
            hud.removeFromSuperview()
            return true
        }
        return false
    }
    
    
    //MARK:
    private class func showInView(backView:UIView) -> ProgressHUD {
        let hud = ProgressHUD(frame: backView.bounds)
        backView.addSubview(hud)
        
        return hud
    }
    
    private class func HUDForView(backView:UIView) -> ProgressHUD? {
        for subview in backView.subviews.reversed() {
            if subview.isKind(of: self) {
                return subview as? ProgressHUD
            }
        }
        return nil
    }
    
    //MARK:
    private override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        HudWidth = frame.width * 0.3;
    }
    
    convenience init(frame:CGRect,type:HudType) {
        self.init(frame: frame)
        
        if type == .Text {
            HudHeight = 50.0;
            
            initilize()
            
        } else {
            HudHeight = 90.0;
            
            initilize()
            addIndicator()
        }
        
    }

    private func initilize() {
        contentView.frame = CGRect(x: 0.0, y: 0.0, width: HudWidth, height:HudHeight)
        contentView.center = center
        contentView.backgroundColor = KBackgroundColor
        addSubview(contentView)
    }
    
    private func addIndicator() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator?.center = CGPoint(x: HudWidth * 0.5, y: 30)
        indicator?.color = UIColor.gray
        indicator?.startAnimating()
        contentView.addSubview(indicator!)
    }
    
    private func hideHudAfterDealy(dealyTime:TimeInterval) {
        timer = Timer.scheduledTimer(timeInterval: dealyTime, target: self, selector: #selector(hideHudAnimated), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func hideHudAnimated() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.alpha = 0.1
        }) { (flag) in
            self.contentView.alpha = 0.1
            
            self.timer?.invalidate()
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
