//
//  LoginViewController.swift
//  xbsj
//
//  Created by dssj on 2019/8/8.
//  Copyright © 2019 dssj. All rights reserved.
//

import UIKit
import RxSwift    
import RxCocoa

class LoginViewController: UIViewController {

    typealias LoginSuccess = () -> Void
    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var loginSuccessBlock : LoginSuccess?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountField.text = "18805618681"
        
        let account = accountField.rx.text.orEmpty.asObservable()
        let accountValid = account.map {
            $0.count > 0
            }.share(replay: 1)
        
        let password = passwordField.rx.text.orEmpty.asObservable()
        let passwordValid = password.map {
            $0.count > 6
        }.share(replay: 1)
        
        let valid = Observable.combineLatest(accountValid,passwordValid) {
            $0 && $1
        }.share(replay:1)
        valid.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        loginButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.loginAction()
        }).disposed(by: disposeBag)
    }
    
    //MARK:
    private func loginAction() {
        guard let mobile = accountField.text,let pwd = passwordField.text else {
            HUD.flash(.label("账号不正确"), delay: hudDuration)
//            ProgressHUD.showError(text: "账号不正确")
            return
        }

        HUD.show(.systemActivity)
        let loginT = MultiTarget(UserService.UserLoginMobile(mobile: mobile, pwd:pwd.MD5()))
        NetWorkManager.request(loginT, success: { json in
//            print(json.dictionaryValue)
//            print(json["data"]["userId"].stringValue)
            UserManager.share.token = json["data"]["accessToken"].stringValue
            self.getUserInfo()

        }) { error in
            HUD.flash(.label(error), delay: hudDuration)
        }
        
    }
    
    func getUserInfo() {
        let target = MultiTarget(UserService.UserHomePageInfo(loginType: 2))
        NetWorkManager.request(target, success: { json in
            HUD.hide(animated: true)
            
            UserManager.share.saveUserInfo(json: json["data"])
            
            if self.loginSuccessBlock != nil {
                self.loginSuccessBlock?()
            }
            self.closeAction()
            
        }) { error in
            HUD.flash(.label(error), delay: hudDuration)
        }
    }
    
    @IBAction func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
}
