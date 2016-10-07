
//
//  meTab.swift
//  aomai
//
//  Created by li qiang on 7/14/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKLoginKit
import SDWebImage

class MeTab: DancingShoesViewController, UITableViewDelegate, UITableViewDataSource {
    
    //populate functions
    let bgView = UIView()
    let cellID = "cellID"
    let funcs = ["ORDERS", "ADDRESS","FAVORITE", "PROFILE", "CONTACT US", "SHARE ME"]
    let icons = [UIImage(named: "order"), UIImage(named: "address"), UIImage(named: "favorite"), UIImage(named: "profile"), UIImage(named: "contactus"), UIImage(named: "share")]
    
    let userAva: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "whiteAva")
        return imageView
    }()
    let goToSignInBtn = UIButton()
    let userName = UILabel()
    let functionsListTableView = UITableView()
    let signOutFBBtn = UIButton()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addBG()
        view.backgroundColor = UIColor.whiteColor()
        setUpUserAvatar()
        setUpGoToSignInBtn()
        setUpFunctionsListTableView()
        setUpUserName()
        setUpFBSignOutBtn() //to be removed later as this bottun will be in the tableview list
        functionsListTableView.tableFooterView = UIView(frame: CGRectMake(0, 0, functionsListTableView.frame.size.width, 1))
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
                //fectch user profile from datebase
                FIRDatabase.database().reference().child("users").child(user.uid).observeEventType(.Value, withBlock: { (snap) in
                    if let dict = snap.value as? [String: AnyObject] {
                        if let uname = dict["name"] {
                            self.userName.text = (uname as! String)
                            self.userName.font = UIFont(name: "ArialRoundedMTBold", size: 14)
                        } else {
                            self.userName.text = "Tap to edit name"
                            self.userName.font = UIFont(name: "ArialRoundedMTBold", size: 14)
                        }
                        if let uUrl = dict["userAvatarUrl"] {
                            let url = uUrl as! String
                            let urlsd = NSURL(string: url)
                            self.userAva.sd_setImageWithURL(urlsd, placeholderImage: UIImage(named: "whiteAva"))
                            self.userAva.layer.cornerRadius = self.userAva.frame.size.width/2
                        } else {
                            self.userAva.image = UIImage(named: "whiteAva")
                        }
                    } else {
                        self.userAva.image = UIImage(named: "whiteAva")
                        self.userName.text = "Tap to edit name"
                        self.userName.font = UIFont(name: "ArialRoundedMTBold", size: 14)
                    }
                    
                }, withCancelBlock: nil)
            } else {
                // No user is signed in.
                self.userAva.image = UIImage(named: "whiteAva")
            }
        }

    }
    //sign out button
    func setUpFBSignOutBtn() {
        self.bgView.addSubview(signOutFBBtn)
        signOutFBBtn.translatesAutoresizingMaskIntoConstraints = false
        signOutFBBtn.rightAnchor.constraintEqualToAnchor(bgView.rightAnchor, constant: -20).active = true
        signOutFBBtn.topAnchor.constraintEqualToAnchor(self.bgView.topAnchor).active = true
        signOutFBBtn.heightAnchor.constraintEqualToConstant(36).active = true
        self.signOutFBBtn.setImage(UIImage(named: "exit"), forState: .Normal)
        self.signOutFBBtn.addTarget(self, action: #selector(signOutActionList), forControlEvents: .TouchUpInside)
    }
    
    //sign out from firebase and Facebook
    func signOutFromAll() {
        try! FIRAuth.auth()!.signOut()
        FBSDKAccessToken.setCurrentAccessToken(nil)
        self.userName.hidden = true
        self.userName.text = ""
        self.goToSignInBtn.hidden = false
        self.signOutFBBtn.hidden = true
        self.userAva.image = UIImage(named: "whiteAva")
    }
    
    func setUpFunctionsListTableView() {
        self.view.addSubview(functionsListTableView)
        self.functionsListTableView.backgroundColor = UIColor.whiteColor()
        functionsListTableView.translatesAutoresizingMaskIntoConstraints = false
        functionsListTableView.topAnchor.constraintEqualToAnchor(bgView.bottomAnchor).active = true
        functionsListTableView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -49).active = true
        functionsListTableView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        functionsListTableView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        self.functionsListTableView.delegate = self
        self.functionsListTableView.dataSource = self
        self.functionsListTableView.reloadData()
    }
    
    func setUpUserAvatar() {
        self.bgView.addSubview(userAva)
        userAva.translatesAutoresizingMaskIntoConstraints = false
        self.userAva.userInteractionEnabled = true
        self.userAva.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProfilePage)))
        userAva.topAnchor.constraintEqualToAnchor(self.bgView.topAnchor).active = true
        userAva.centerXAnchor.constraintEqualToAnchor(self.bgView.centerXAnchor).active = true
        userAva.heightAnchor.constraintEqualToConstant(80).active = true
        userAva.widthAnchor.constraintEqualToConstant(80).active = true
    }
    func setUpUserName() {
        self.bgView.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        self.userName.userInteractionEnabled = true
        self.userName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProfilePage)))
        self.userName.textColor = UIColor.whiteColor()
        //set to be at center
        self.userName.textAlignment = .Center
        userName.topAnchor.constraintEqualToAnchor(userAva.bottomAnchor).active = true
        userName.heightAnchor.constraintEqualToConstant(36).active = true
        userName.leftAnchor.constraintEqualToAnchor(bgView.leftAnchor).active = true
        userName.rightAnchor.constraintEqualToAnchor(bgView.rightAnchor).active = true
    }
    func setUpGoToSignInBtn() {
        self.bgView.addSubview(goToSignInBtn)
        goToSignInBtn.translatesAutoresizingMaskIntoConstraints = false
        self.goToSignInBtn.setTitle("SIGN IN/REGISTER", forState: .Normal)
        self.goToSignInBtn.titleLabel!.font =  UIFont(name: "ArialRoundedMTBold", size: 14)
        self.goToSignInBtn.titleLabel?.textColor = UIColor.whiteColor()
        
        goToSignInBtn.topAnchor.constraintEqualToAnchor(userAva.bottomAnchor).active = true
        goToSignInBtn.heightAnchor.constraintEqualToConstant(36).active = true
        goToSignInBtn.leftAnchor.constraintEqualToAnchor(bgView.leftAnchor).active = true
        goToSignInBtn.rightAnchor.constraintEqualToAnchor(bgView.rightAnchor).active = true
        self.goToSignInBtn.addTarget(self, action: #selector(goToSignInPage), forControlEvents: .TouchUpInside)
        
        
    }
    func goToSignInPage() {
        let signInPage = SocialSignIn()
        presentViewController(signInPage, animated: true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath)
        let cell = UITableViewCell(style: .Default, reuseIdentifier: cellID)
        cell.textLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        cell.textLabel?.text = funcs[indexPath.row]
        cell.imageView?.image = icons[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //check if user signed in
        if FIRAuth.auth()?.currentUser != nil {
            if indexPath.row == 0 {
                let orderView = OrderView()
                navigationController?.pushViewController(orderView, animated: true)
            }
            else if indexPath.row == 1 {
                let addressView = MyAddress()
                navigationController?.pushViewController(addressView, animated: true)
            }
            else if indexPath.row == 2 {
                let vc = MyAddress()
                navigationController?.pushViewController(vc, animated: true)
                
            }
            else if indexPath.row == 3 {
                let editProfile = EditProfileTableViewController()
                navigationController?.pushViewController(editProfile, animated: true)
            }
            else if indexPath.row == 5 {
                let vc = AboutUs()
                navigationController?.pushViewController(vc, animated: true)
                
            }
            else {
                let vc = MyAddress()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        else {
            didplayNeedSignInAlert()
        }
    }
    
    func didplayNeedSignInAlert() {
        let needSignIn = UIAlertController(title: "Sorry", message: "Please sign in First", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) {(_: UIAlertAction) -> Void in}
        needSignIn.addAction(okAction)
        self.presentViewController(needSignIn, animated: true, completion: nil)
        
    }
    
    func addBG() {
        bgView.backgroundColor = Tools.dancingShoesColor
        self.view.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        bgView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        bgView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        bgView.heightAnchor.constraintEqualToConstant(120).active = true
    }
    
    func goToProfilePage() {
        //handel user profile
        if FIRAuth.auth()?.currentUser != nil {
            let editProfile = EditProfileTableViewController()
            navigationController?.pushViewController(editProfile, animated: true)
        }
    }
    
    func signOutActionList() {
        if FIRAuth.auth()?.currentUser != nil {
            let changeAvatarAlertView: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            changeAvatarAlertView.addAction(cancelActionButton)
            
            let fromLib: UIAlertAction = UIAlertAction(title: "SIGN OUT", style: .Default)
            { action -> Void in
                //choose from album
                self.signOutFromAll()
            }
            changeAvatarAlertView.addAction(fromLib)
            
            self.presentViewController(changeAvatarAlertView, animated: true, completion: nil)
        }
    }
}
