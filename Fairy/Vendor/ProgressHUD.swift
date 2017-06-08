//
//  ProgressHUD.swift
//  Fairy
//
//  Created by 丁鹏飞 on 2017/6/7.
//  Copyright © 2017年 丁鹏飞. All rights reserved.
//

import UIKit

enum HudMode:Int {
    case Indicator
    case CustomeView
    case Text
}

let margin:CGFloat = 10.0

class ProgressHUD: UIView {
    
    private var contentView:UIView = UIView()
    private var indicatorView:UIActivityIndicatorView?
    private var textLabel:UILabel?
    
    private var HudWidth:CGFloat = 0.0
    private var HudHeight:CGFloat = 0.0
    
    private var mode:Int = HudMode.Indicator.rawValue
    private var timer:Timer?
    
    var text:String? {
        didSet {
            textLabel?.text = text
            
            switch mode {
            case HudMode.CustomeView.rawValue:
                let textS = NSString(string: (textLabel?.text)!)
                var size = textS.boundingRect(with: CGSize(width: frame.width * 0.8, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: textLabel?.font! as Any], context: nil).size
                size = CGSize(width: max(size.height + 50.0, size.width), height: size.height)
                
                let indictorW = (indicatorView?.frame.width)!
                contentView.bounds = CGRect(x: 0.0, y: 0.0, width: size.width + margin * 2.0, height: size.height + indictorW + margin * 3.0)
                indicatorView?.center = CGPoint(x: (size.width + margin * 2.0) * 0.5, y: margin + indictorW * 0.5)
                textLabel?.frame = CGRect(origin: CGPoint(x: margin, y: indictorW + margin * 2), size: size)
                
            case HudMode.Text.rawValue:
                let textS = NSString(string: (textLabel?.text)!)
                let size = textS.boundingRect(with: CGSize(width: frame.width * 0.8, height: 0.0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: textLabel?.font! as Any], context: nil).size
                contentView.bounds = CGRect(x: 0.0, y: 0.0, width: size.width + margin * 2.0, height: size.height + margin * 2.0)
                textLabel?.frame = CGRect(origin: CGPoint(x: margin, y: margin), size: size)
                
            default:
                return
            }
        }
    }
    
    //MARK: - public
    ///加载
    class func loading() {
        ProgressHUD.loading(backView: nil, text: nil)
    }
    
    class func loading(backView:UIView?,text:String?) {
        var backView = backView
        if backView == nil {
            backView = UIApplication.shared.windows.last
        }
        
        var hud:ProgressHUD
        if text != nil && text?.characters.count != 0 {
            hud = ProgressHUD(backView: backView!, mode: .CustomeView)
            hud.text = text
            
        } else {
            hud = ProgressHUD(backView: backView!, mode: .Indicator)
        }
        
        backView?.addSubview(hud)
    }
    
    ///提示
    class func showSuccess(text:String?) {
        let successText = (text != nil && text?.characters.count != 0) ? text! : "操作成功"
        ProgressHUD.showMessage(text: successText)
    }
    
    class func showError(text:String?) {
        let successText = (text != nil && text?.characters.count != 0) ? text! : "操作失败"
        ProgressHUD.showMessage(text: successText)
    }
    
    class func hideForView(backView:UIView?) {
        ProgressHUD.hideForView(backView: backView, animated: true)
    }
    
    class func hideForView(backView:UIView?, animated:Bool) {
        var backView = backView
        if backView == nil {
            backView = UIApplication.shared.windows.last
        }
        
        if let hud = ProgressHUD.HUDForView(backView: backView!) {
            if animated {
                hud.hideAnimated()
            } else {
                hud.removeFromSuperview()
            }
        }
    }
    
    //MARK:
    private class func HUDForView(backView:UIView) -> ProgressHUD? {
        for subview in backView.subviews.reversed() {
            if subview.isKind(of: self) {
                return subview as? ProgressHUD
            }
        }
        return nil
    }
    
    private class func showMessage(text:String) {
        let backView = UIApplication.shared.windows.last
        let hud = ProgressHUD(backView: backView!, mode: .Text)
        hud.text = text
        
        backView?.addSubview(hud)
        hud.hideHudAfterDealy(dealyTime: 1.5)
    }
    
    //MARK:
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        initilize()
    }
    
    func initilize() {
        backgroundColor = UIColor.clear
        HudWidth = frame.width * 0.3;
        HudHeight = HudWidth;
        
        contentView.frame = CGRect(x: 0.0, y: 0.0, width: HudWidth, height:HudHeight)
        contentView.center = center
        contentView.backgroundColor = KBackgroundColor
        addSubview(contentView)
        
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicatorView?.color = UIColor.gray
        indicatorView?.startAnimating()
        contentView.addSubview(indicatorView!)
        
        textLabel = UILabel()
        textLabel?.numberOfLines = 0
        textLabel?.textAlignment = .center
        textLabel?.font = UIFont.systemFont(ofSize: 15)
        contentView.addSubview(textLabel!)
    }
    
    convenience init(backView:UIView?) {
        var backView = backView
        if backView == nil {
            backView = UIApplication.shared.windows.last
        }
        self.init(backView: backView!, mode: .CustomeView)
    }
    
    convenience init(backView:UIView,mode:HudMode) {
        self.init(frame: backView.bounds)
        self.mode = mode.rawValue
        
        if mode == .Indicator {
            HudWidth = frame.width * 0.2;
            HudHeight = HudWidth;
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: HudWidth, height:HudHeight)
            indicatorView?.center = CGPoint(x: HudWidth * 0.5, y: HudHeight * 0.5)
            
        } else if mode == .CustomeView {
            HudWidth = frame.width * 0.25;
            HudHeight = HudWidth;
            let indictorW = (indicatorView?.frame.width)!
            
            textLabel?.text = "加载中"
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: HudWidth, height: HudHeight)
            indicatorView?.center = CGPoint(x: HudWidth * 0.5, y: margin + indictorW * 0.5)
            textLabel?.frame = CGRect(x: 0, y: indictorW + margin, width: HudWidth, height: HudHeight - indictorW - margin)
            
        } else if mode == .Text {
            indicatorView?.removeFromSuperview()
            indicatorView = nil
            
            HudWidth = frame.width * 0.25;
            HudHeight = HudWidth * 0.6;
            
            textLabel?.text = "加载中"
            contentView.bounds = CGRect(x: 0.0, y: 0.0, width: HudWidth, height: HudHeight)
            textLabel?.frame = CGRect(x: margin, y: margin, width: HudWidth - margin * 2.0, height: HudHeight - margin * 2.0)
        }
    }
    
    private func hideHudAfterDealy(dealyTime:TimeInterval) {
        timer = Timer.scheduledTimer(timeInterval: dealyTime, target: self, selector: #selector(hideAnimated), userInfo: nil, repeats: false)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    @objc private func hideAnimated() {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        }) { (flag) in
            self.timer?.invalidate()
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
