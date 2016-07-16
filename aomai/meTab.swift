//
//  meTab.swift
//  aomai
//
//  Created by li qiang on 7/14/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import SnapKit

class meTab: UIViewController {
    
    let userAva = UIImageView()
    let goToSignInBtn = UIButton()
    let userName = UILabel()
    let functionsListTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:21/255, green:67/255, blue:96/255, alpha:1.0)
        setUpGoToSignInBtn()
        setUpUserAvatar()
        setUpFunctionsListTableView()
    }
    
    func setUpFunctionsListTableView() {
        self.view.addSubview(functionsListTableView)
        self.functionsListTableView.backgroundColor = UIColor.whiteColor()
        self.functionsListTableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(180)
            make.bottom.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
    }
    
    func setUpUserAvatar() {
        self.view.addSubview(userAva)
        self.userAva.image = UIImage(named: "whiteAva")
        self.userAva.snp_makeConstraints { (make) in
            make.size.equalTo(80)
            make.top.equalTo(self.view).offset(40)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        
    }
    func setUpUserName() {
        self.view.addSubview(userName)
        
        
    }
    func setUpGoToSignInBtn() {
        self.view.addSubview(goToSignInBtn)
        self.goToSignInBtn.setTitle("Sign In/Register", forState: .Normal)
        self.goToSignInBtn.titleLabel?.textColor = UIColor.whiteColor()
        self.goToSignInBtn.snp_makeConstraints { (make) in
            make.height.equalTo(36)
            make.top.equalTo(self.view).offset(130)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        }
        //self.goToSignInBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.goToSignInBtn.addTarget(self, action: #selector(goToSignInPage), forControlEvents: .TouchUpInside)
        
        
    }
    func goToSignInPage() {
        let signInPage = socialSignIn()
        presentViewController(signInPage, animated: true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
