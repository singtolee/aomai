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

class meTab: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //populate functions
    let cellID = "cellID"
    let funcs = ["Orders", "History", "Address", "Profile", "Settings", "About Us"]
    let icons = [UIImage(named: "Truck-24"), UIImage(named: "history-24"), UIImage(named: "Location-24"), UIImage(named: "Info-24"), UIImage(named: "Settings-24"), UIImage(named: "About-24")]
    
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
                //fectch user profile from datebase
                FIRDatabase.database().reference().child("users").child(user.uid).observeEventType(.Value, withBlock: { (snap) in
                    if let dict = snap.value as? [String: AnyObject] {
                        let vser = Vser()
                        vser.setValuesForKeysWithDictionary(dict)
                        self.userName.text = vser.name
                        let url = NSURL(string: vser.userAvatarUrl!)
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
                        
                    }
                    
                }, withCancelBlock: nil)
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
            make.bottom.equalTo(self.view)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        self.functionsListTableView.delegate = self
        self.functionsListTableView.dataSource = self
        self.functionsListTableView.reloadData()
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath)
        let cell = UITableViewCell(style: .Default, reuseIdentifier: cellID)
        cell.textLabel?.text = funcs[indexPath.row]
        cell.imageView?.image = icons[indexPath.row]
        cell.imageView?.tintColor = UIColor.blueColor()
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //check if user signed in
        if FIRAuth.auth()?.currentUser != nil {
            if indexPath.row == 0 {
                let orderView = OrderView()
                let nav = UINavigationController(rootViewController: orderView)
                self.presentViewController(nav, animated: true, completion: nil)
            }
            else if indexPath.row == 1 {
                let orderView = OrderView()
                let nav = UINavigationController(rootViewController: orderView)
                self.presentViewController(nav, animated: true, completion: nil)
            }
            else if indexPath.row == 2 {
                let vc = MyAddress()
                let nav = UINavigationController(rootViewController: vc)
                self.presentViewController(nav, animated: true, completion: nil)
            }
            else {
                let vc = MyAddress()
                let nav = UINavigationController(rootViewController: vc)
                self.presentViewController(nav, animated: true, completion: nil)
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
