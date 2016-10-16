//
//  socialSignIn.swift
//  aomai
//
//  Created by li qiang on 7/14/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FBSDKCoreKit
import FBSDKLoginKit
import SVProgressHUD

class SocialSignIn: UIViewController, UITextFieldDelegate {
    
    let fbLoginBtn = UIButton()
    let cancelLoginBtn = UIButton()
    let emailTF = UITextField()
    let pswd = UITextField()
    let welcomeLable = UILabel()
    let emailLoginBtn = UIButton()
    let orLable = UILabel()
    let registerBtn = UIButton()
    let eLine = UIView()
    let pswdLine = UIView()
    let forgetPasswordBtn = UIButton()
    let offset: CGFloat = 24
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(fbLoginBtn)
        self.view.addSubview(cancelLoginBtn)
        self.view.addSubview(emailTF)
        self.view.addSubview(pswd)
        self.view.addSubview(welcomeLable)
        self.view.addSubview(emailLoginBtn)
        self.view.addSubview(orLable)
        self.view.addSubview(registerBtn)
        self.view.addSubview(eLine)
        self.view.addSubview(pswdLine)
        self.view.addSubview(forgetPasswordBtn)
        self.emailTF.delegate = self
        self.pswd.delegate = self
        setupFacebookSignInBtn()
        setupCancelLogInBtn()
        setUpWelcomeLable()
        setUpEmailTF()
        setUpPasswordTF()
        setUpEmailLogInBtn()
        setUpOrLable()
        setUpRegisterBtn()
        addEmailTFBottomLine()
        addPasswordTFBottomLine()
        setUpForgetPasswordButton()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allTextFieldsResignFirstResponder)))
        self.view.userInteractionEnabled = true
    }
    
    override func viewDidAppear(animated: Bool) {
        //if user loged in, dismiss this view
        if FIRAuth.auth()?.currentUser != nil {
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
    
    func setupCancelLogInBtn() {
        self.cancelLoginBtn.setImage(UIImage(named: "cancelLogin"), forState: .Normal)
        
        cancelLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelLoginBtn.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: view.bounds.height/20).active = true
        cancelLoginBtn.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 20).active = true
        cancelLoginBtn.widthAnchor.constraintEqualToConstant(36).active = true
        cancelLoginBtn.heightAnchor.constraintEqualToConstant(36).active = true
        self.cancelLoginBtn.addTarget(self, action: #selector(disMisSignInVc), forControlEvents: .TouchUpInside)
        
    }
    
    func setUpWelcomeLable() {
        self.welcomeLable.text = "welcome to aomai"
        self.welcomeLable.font = UIFont(name: "ArialRoundedMTBold", size: 26)
        //set to be at center
        self.welcomeLable.textAlignment = .Center
        self.welcomeLable.textColor = UIColor.lightGrayColor()
        
        welcomeLable.translatesAutoresizingMaskIntoConstraints = false
        welcomeLable.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: view.bounds.height/8).active = true
        welcomeLable.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        welcomeLable.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        welcomeLable.heightAnchor.constraintEqualToConstant(36).active = true
    }
    
    func setUpEmailTF() {
        self.emailTF.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        self.emailTF.keyboardType = .EmailAddress
        self.emailTF.adjustsFontSizeToFitWidth = true
        self.emailTF.autocorrectionType = .No
        self.emailTF.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        self.emailTF.textColor = UIColor.lightGrayColor()
        self.emailTF.returnKeyType = .Next
        self.emailTF.clearButtonMode = .WhileEditing
        //get NSUserDefaults EMAIL
        let getUserDefault = NSUserDefaults.standardUserDefaults()
        if let savedEmail = getUserDefault.stringForKey("EMAIL") {
            self.emailTF.text = savedEmail
        }
        //add left icon
        let imageView = UIImageView()
        imageView.image = UIImage(named: "email")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        emailTF.leftView = imageView
        emailTF.leftViewMode = UITextFieldViewMode.Always
        
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        emailTF.topAnchor.constraintEqualToAnchor(welcomeLable.bottomAnchor, constant: view.bounds.height/20).active = true
        emailTF.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: offset).active = true
        emailTF.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -offset).active = true
        emailTF.heightAnchor.constraintEqualToConstant(36).active = true
    }
    func addEmailTFBottomLine(){
        self.eLine.backgroundColor = UIColor.lightGrayColor()
        
        eLine.translatesAutoresizingMaskIntoConstraints = false
        eLine.topAnchor.constraintEqualToAnchor(emailTF.bottomAnchor).active = true
        eLine.leftAnchor.constraintEqualToAnchor(emailTF.leftAnchor).active = true
        eLine.rightAnchor.constraintEqualToAnchor(emailTF.rightAnchor).active = true
        eLine.heightAnchor.constraintEqualToConstant(1).active = true
    }
    
    func setUpPasswordTF() {
        self.pswd.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        self.pswd.textColor = UIColor.lightGrayColor()
        self.pswd.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        self.pswd.clearButtonMode = .WhileEditing
        self.pswd.secureTextEntry = true
        self.pswd.returnKeyType = .Done
        //get NSUserDefaults PASSWORD
        let getUserDefault = NSUserDefaults.standardUserDefaults()
        if let savedPSD = getUserDefault.stringForKey("PASSWORD") {
            self.pswd.text = savedPSD
        }
        //add left icon
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        pswd.leftView = imageView
        pswd.leftViewMode = UITextFieldViewMode.Always
        
        pswd.translatesAutoresizingMaskIntoConstraints = false
        pswd.topAnchor.constraintEqualToAnchor(emailTF.bottomAnchor, constant: 10).active = true
        pswd.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: offset).active = true
        pswd.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -offset).active = true
        pswd.heightAnchor.constraintEqualToConstant(36).active = true
    }
    func addPasswordTFBottomLine(){
        self.pswdLine.backgroundColor = UIColor.lightGrayColor()
        
        pswdLine.translatesAutoresizingMaskIntoConstraints = false
        pswdLine.topAnchor.constraintEqualToAnchor(pswd.bottomAnchor).active = true
        pswdLine.leftAnchor.constraintEqualToAnchor(pswd.leftAnchor).active = true
        pswdLine.rightAnchor.constraintEqualToAnchor(pswd.rightAnchor).active = true
        pswdLine.heightAnchor.constraintEqualToConstant(1).active = true
    }
    
    func setUpEmailLogInBtn() {
        self.emailLoginBtn.layer.cornerRadius = 4
        self.emailLoginBtn.backgroundColor = Tools.dancingShoesColor //Indian red
        self.emailLoginBtn.setTitle("LOGIN", forState: .Normal)
        self.emailLoginBtn.titleLabel!.font =  UIFont(name: "ArialRoundedMTBold", size: 18)
        
        emailLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        emailLoginBtn.topAnchor.constraintEqualToAnchor(pswdLine.bottomAnchor, constant: 25).active = true
        emailLoginBtn.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: offset).active = true
        emailLoginBtn.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -offset).active = true
        emailLoginBtn.heightAnchor.constraintEqualToConstant(36).active = true
        self.emailLoginBtn.addTarget(self, action: #selector(loginWithEmail), forControlEvents: .TouchUpInside)
        
    }
    
    func loginWithEmail() {
        //check text field filled correctly
        if Tools.isEmail(Tools.trim(self.emailTF.text!)) && Tools.trim(self.pswd.text!).characters.count >= 6 {
            //NSUserDefaults
            let saveEandP = NSUserDefaults.standardUserDefaults()
            saveEandP.setObject(Tools.trim(self.emailTF.text!), forKey: "EMAIL")
            saveEandP.setObject(Tools.trim(self.pswd.text!), forKey: "PASSWORD")
            
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
            SVProgressHUD.showWithStatus("Logging in...")
            guard let email = self.emailTF.text, psd = self.pswd.text
                else {return}
            FIRAuth.auth()?.signInWithEmail(Tools.trim(email), password: Tools.trim(psd), completion: {(user, error) in
                if error != nil {
                    SVProgressHUD.dismiss()
                    let loginErrorAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                    let action = UIAlertAction(title: "OK", style: .Default) {(_: UIAlertAction) -> Void in}
                    loginErrorAlert.addAction(action)
                    self.presentViewController(loginErrorAlert, animated: true, completion: nil)
                    //print(error?.localizedDescription)
                    return
                }
                SVProgressHUD.dismiss()
                self.dismissViewControllerAnimated(true, completion: nil)
                
            })
        } else {
            if !Tools.isEmail(Tools.trim(self.emailTF.text!)) {
                Tools.shakingUIView(emailTF)
            } else if (Tools.trim(self.pswd.text!).characters.count < 6) {
                Tools.shakingUIView(pswd)
            }
        }
        
    }
    
    func setUpOrLable() {
        self.orLable.text = "OR"
        self.orLable.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        self.orLable.textColor = UIColor.lightGrayColor()
        //set to be at center
        self.orLable.textAlignment = .Center
        orLable.translatesAutoresizingMaskIntoConstraints = false
        orLable.topAnchor.constraintEqualToAnchor(forgetPasswordBtn.bottomAnchor, constant: 15).active = true
        orLable.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        orLable.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
    }
    
    func setUpForgetPasswordButton() {
        self.forgetPasswordBtn.setTitle("Forget your password?", forState: .Normal)
        self.forgetPasswordBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        self.forgetPasswordBtn.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        
        forgetPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        forgetPasswordBtn.topAnchor.constraintEqualToAnchor(emailLoginBtn.bottomAnchor, constant: 10).active = true
        forgetPasswordBtn.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        forgetPasswordBtn.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        self.forgetPasswordBtn.addTarget(self, action: #selector(popUpResetPasswordAlert), forControlEvents: .TouchUpInside)
    }
    func popUpResetPasswordAlert() {
        var resetEmailTF: UITextField?
        let resetPasswordAlert = UIAlertController(title: "Tell me your Email", message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Reset Password", style: .Default) {(result: UIAlertAction) -> Void in
            //send email to reset password
            //print(resetEmailTF?.text)
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
            SVProgressHUD.showWithStatus("Please wait...")
            FIRAuth.auth()?.sendPasswordResetWithEmail((resetEmailTF?.text)!) {error in
                if error != nil {
                    //display error
                    SVProgressHUD.dismiss()
                    //print(error?.localizedDescription)
                    let sendEmailFailed = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    let ok1Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(_: UIAlertAction) -> Void in                    }
                    sendEmailFailed.addAction(ok1Action)
                    self.presentViewController(sendEmailFailed, animated: true, completion: nil)
                    return
                }else {
                    //tell user check email, reset password link was sent
                    SVProgressHUD.dismiss()
                    let sendEmailSuccess = UIAlertController(title: "Check you Inbox", message: "Reset password email was sent to your Email", preferredStyle: UIAlertControllerStyle.Alert)
                    let ok2Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(_: UIAlertAction) -> Void in                    }
                    sendEmailSuccess.addAction(ok2Action)
                    self.presentViewController(sendEmailSuccess, animated: true, completion: nil)
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {(_: UIAlertAction) -> Void in}
        resetPasswordAlert.addAction(okAction)
        resetPasswordAlert.addAction(cancelAction)
        resetPasswordAlert.addTextFieldWithConfigurationHandler { (tf) -> Void in
            //textfield customization code
            resetEmailTF = tf
            resetEmailTF!.placeholder = "Enter your Email"
            resetEmailTF?.keyboardType = .EmailAddress
        }
        self.presentViewController(resetPasswordAlert, animated: true, completion: nil)
        
    }
    
    func setupFacebookSignInBtn() {
        self.fbLoginBtn.layer.cornerRadius = 4
        self.fbLoginBtn.backgroundColor = UIColor(red:59/255, green:89/255, blue:152/255, alpha:1.0) //navy blue
        self.fbLoginBtn.setTitle("Sign In With Facebook", forState: .Normal)
        self.fbLoginBtn.titleLabel!.font =  UIFont(name: "ArialRoundedMTBold", size: 16)
        
        fbLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        fbLoginBtn.topAnchor.constraintEqualToAnchor(orLable.bottomAnchor, constant: 20).active = true
        fbLoginBtn.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: offset).active = true
        fbLoginBtn.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -offset).active = true
        fbLoginBtn.heightAnchor.constraintEqualToConstant(36).active = true
        self.fbLoginBtn.addTarget(self, action: #selector(loginFB), forControlEvents: .TouchUpInside)

    }
    
    func setUpRegisterBtn() {
        self.registerBtn.setTitle("REGISTER AN ACCOUNT", forState: .Normal)
        self.registerBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        self.registerBtn.titleLabel!.font =  UIFont(name: "ArialRoundedMTBold", size: 12)
        
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.topAnchor.constraintEqualToAnchor(fbLoginBtn.bottomAnchor, constant: 25).active = true
        registerBtn.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        registerBtn.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        self.registerBtn.addTarget(self, action: #selector(goToRegisterPage), forControlEvents: .TouchUpInside)
    }
    
    func disMisSignInVc(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default;
    }
    // called when Facebook login button clicked.
    func loginFB() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
        SVProgressHUD.showWithStatus("Logging in...")
        let login: FBSDKLoginManager = FBSDKLoginManager()
        login .logInWithReadPermissions(["public_profile", "email"], fromViewController: self, handler: { (result, error) -> Void in
                    if error != nil {
                        //print("Process error")
                        SVProgressHUD.dismiss()
                    }
                    else if result.isCancelled {
                        //print("Cancelled")
                        SVProgressHUD.dismiss() 
                    }
                    else {
                        //print("Logged in")
                        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                            if error != nil{
                                //report error then return
                                //print(error)
                                SVProgressHUD.dismiss()
                            return}
                            if let uid = user?.uid {
                                //check if this user exists or not
                                //print(uid)
                                let ref = FIRDatabase.database().reference().child("users")
                                ref.observeSingleEventOfType(FIRDataEventType.Value, withBlock: { (snapshot) in
                                    if snapshot.hasChild(uid) {
                                        //user exists
                                        SVProgressHUD.dismiss()
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    } else {
                                        //user not exists
                                        var values: Dictionary = [String: String]()
                                        if let name = user?.displayName {
                                            values["name"] = name
                                        }
                                        if let email = user?.email {
                                            values["email"] = email
                                        }
                                        if let url = user?.photoURL?.absoluteString {
                                            values["userAvatarUrl"] = url
                                        }
                                        Tools.registerUserIntoDatabaseWithUID(uid, values: values)
                                        SVProgressHUD.dismiss()
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    }
                                })
                            } else {
                                //no uid find
                                SVProgressHUD.dismiss()
                            }
                        }
                    }
                })

    }
    func goToRegisterPage() {
        let registerPage = RegisterWithEmail()
        self.presentViewController(registerPage, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailTF {
        self.pswd.becomeFirstResponder()}
        else {
        self.pswd.resignFirstResponder()}
        return true
    }
    
    func allTextFieldsResignFirstResponder() {
        self.emailTF.resignFirstResponder()
        self.pswd.resignFirstResponder()
    }
}
