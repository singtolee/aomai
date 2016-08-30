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
import FirebaseDatabase
import FirebaseAuth
import FBSDKLoginKit

class MeTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //populate functions
    let cellID = "cellID"
    let funcs = ["ORDERS", "ADDRESS","FAVORITE", "PROFILE", "CONTACT US", "SHARE"]
    let icons = [UIImage(named: "order"), UIImage(named: "address"), UIImage(named: "favorite"), UIImage(named: "profile"), UIImage(named: "contactus"), UIImage(named: "share")]
    
    let userAva = UIImageView()
    let goToSignInBtn = UIButton()
    let userName = UILabel()
    let functionsListTableView = UITableView()
    //sign out button, add to top right corner first, later move to tableview list
    let signOutFBBtn = UIButton()
    //let coolView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 1))
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addBG()
        view.backgroundColor = UIColor.whiteColor()
        setUpGoToSignInBtn()
        setUpUserAvatar()
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
                            let url = NSURL(string: uUrl as! String)
                            let imageCache = NSCache()
                            if let cachedImage = imageCache.objectForKey(url!) as? UIImage {
                                self.userAva.image = cachedImage
                                return
                            }
                            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                                if error != nil {
                                    print(error?.localizedDescription)
                                    return
                                }
                                dispatch_async(dispatch_get_main_queue(), {
                                    if let downloadedImage = UIImage(data: data!) {
                                        imageCache.setObject(downloadedImage, forKey: url!)
                                        self.userAva.image = downloadedImage
                                        self.userAva.layer.cornerRadius = self.userAva.frame.size.width/2
                                        self.userAva.clipsToBounds = true
                                    }
                                })
                            }).resume()

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
        self.view.addSubview(signOutFBBtn)
        //self.signOutFBBtn.setTitle("SIGN OUT", forState: .Normal)
        self.signOutFBBtn.setImage(UIImage(named: "exit"), forState: .Normal)
        self.signOutFBBtn.titleLabel!.font =  UIFont(name: "ArialRoundedMTBold", size: 12)
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
        self.userName.text = ""
        self.goToSignInBtn.hidden = false
        self.signOutFBBtn.hidden = true
        self.userAva.image = UIImage(named: "whiteAva")
    }
    
    func setUpFunctionsListTableView() {
        self.view.addSubview(functionsListTableView)
        self.functionsListTableView.backgroundColor = UIColor.whiteColor()
        self.functionsListTableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(180)
            make.bottom.equalTo(self.view).offset(-49)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        self.functionsListTableView.delegate = self
        self.functionsListTableView.dataSource = self
        self.functionsListTableView.reloadData()
    }
    
    func setUpUserAvatar() {
        self.view.addSubview(userAva)
        self.userAva.userInteractionEnabled = true
        self.userAva.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeNewAvatar)))
        self.userAva.image = UIImage(named: "whiteAva")
        self.userAva.snp_makeConstraints { (make) in
            make.size.equalTo(80)
            make.top.equalTo(self.view).offset(40)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        
    }
    func setUpUserName() {
        self.view.addSubview(userName)
        self.userName.userInteractionEnabled = true
        self.userName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProfilePage)))
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
        self.goToSignInBtn.setTitle("SIGN IN/REGISTER", forState: .Normal)
        self.goToSignInBtn.titleLabel!.font =  UIFont(name: "ArialRoundedMTBold", size: 14)
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
        let bgView = UIView()
        bgView.backgroundColor = Tools.dancingShoesColor
        self.view.addSubview(bgView)
        bgView.snp_makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(180)
        }
    }
    
    func goToProfilePage() {
        //handel user profile
        if FIRAuth.auth()?.currentUser != nil {
            let editProfile = EditProfileTableViewController()
            navigationController?.pushViewController(editProfile, animated: true)
        }
    }
    
    func changeNewAvatar() {
        if FIRAuth.auth()?.currentUser != nil {
            let changeAvatarAlertView: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            
            let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            changeAvatarAlertView.addAction(cancelActionButton)
            
            let fromLib: UIAlertAction = UIAlertAction(title: "Library", style: .Default)
            { action -> Void in
                //choose from album
            }
            changeAvatarAlertView.addAction(fromLib)
            
            let takeNewPhoto: UIAlertAction = UIAlertAction(title: "Take Photo", style: .Default)
            { action -> Void in
                //take new photo
            }
            changeAvatarAlertView.addAction(takeNewPhoto)
            self.presentViewController(changeAvatarAlertView, animated: true, completion: nil)
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
