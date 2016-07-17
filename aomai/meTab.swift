//
//  meTab.swift
//  aomai
//
//  Created by li qiang on 7/14/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class meTab: UIViewController {
    
    let userAva = UIImageView()
    let goToSignInBtn = UIButton()
    let userName = UILabel()
    let functionsListTableView = UITableView()
    //sign out button, add to top right corner first, later move to tableview list
    let signOutFBBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:21/255, green:67/255, blue:96/255, alpha:1.0)
        setUpGoToSignInBtn()
        setUpUserAvatar()
        setUpFunctionsListTableView()
        setUpUserName()
        setUpFBSignOutBtn() //to be removed later as this bottun will be in the tableview list
        //default hidden and visiable
        self.goToSignInBtn.hidden = false
        self.signOutFBBtn.hidden = true
        self.userName.hidden = true
        //check user sign in or not
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                self.goToSignInBtn.hidden = true
                self.signOutFBBtn.hidden = false
                self.userName.hidden = false
                
                let name = user.displayName
                if name != nil {
                    self.userName.text = name
                }else{
                    self.userName.text = "Your name is a secret."
                }
                let imageUrl = user.photoURL
                
                // set round image frame
                self.userAva.layer.cornerRadius = self.userAva.frame.size.width/2
                self.userAva.clipsToBounds = true
                
                if imageUrl != nil {
                    let avatar = NSData(contentsOfURL: imageUrl!)
                    self.userAva.image = UIImage(data: avatar!)
                }else{
                    self.userAva.image = UIImage(named: "whiteAva")
                }
                
            } else {
                // No user is signed in.
                //maybe clear Facebook sign in tooken?
            }
        }

    }
    //sign out button
    func setUpFBSignOutBtn() {
        self.view.addSubview(signOutFBBtn)
        self.signOutFBBtn.setTitle("Sign Out", forState: .Normal)
        self.signOutFBBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-20)
            make.height.equalTo(36)
        }
        self.signOutFBBtn.addTarget(self, action: #selector(signOutFromAll), forControlEvents: .TouchUpInside)
    }
    
    //sign out from firebase and Facebook
    func signOutFromAll() {
        try! FIRAuth.auth()!.signOut()
        FBSDKAccessToken.setCurrentAccessToken(nil)
        self.userName.hidden = true
        self.goToSignInBtn.hidden = false
        self.signOutFBBtn.hidden = true
        self.userAva.image = UIImage(named: "whiteAva")
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
        self.userName.textColor = UIColor.whiteColor()
        //set to be at center
        self.userName.textAlignment = .Center
        self.userName.snp_makeConstraints { (make) in
            make.height.equalTo(36)
            make.top.equalTo(self.view).offset(130)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }

        
        
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
