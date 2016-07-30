//
//  socialSignIn.swift
//  aomai
//
//  Created by li qiang on 7/14/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import SVProgressHUD

class socialSignIn: UIViewController, UITextFieldDelegate {
    
    let fbLoginBtn = UIButton()        //facebook login button
    let cancelLoginBtn = UIButton()    //cancek kogin button
    //name and password text field
    let emailTF = UITextField()
    let pswd = UITextField()
    let welcomeLable = UILabel()
    //email login button
    let emailLoginBtn = UIButton()
    //or lable
    let orLable = UILabel()
    //register button
    let registerBtn = UIButton()
    //email text field bottom line
    let eLine = UIView()
    //password text field bottom line
    let pswdLine = UIView()
    //forget password button
    let forgetPasswordBtn = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Tools.bgColor //#154360
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
        //resign keyboard when touch outside textfields
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
        self.cancelLoginBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(30)
            make.left.equalTo(self.view).offset(20)
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
        self.cancelLoginBtn.addTarget(self, action: #selector(disMisSignInVc), forControlEvents: .TouchUpInside)
        
    }
    
    func setUpWelcomeLable() {
        self.welcomeLable.text = "welcome to aomai"
        self.welcomeLable.font = UIFont.boldSystemFontOfSize(30)
        //set to be at center
        self.welcomeLable.textAlignment = .Center
        self.welcomeLable.textColor = UIColor.whiteColor()
        self.welcomeLable.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.height.equalTo(36)
        }
    }
    
    func setUpEmailTF() {
        self.emailTF.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        self.emailTF.textColor = UIColor.whiteColor()
        self.emailTF.returnKeyType = .Next
        self.emailTF.clearButtonMode = .WhileEditing
        //add left icon
        let imageView = UIImageView()
        imageView.image = UIImage(named: "email")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 24)
        emailTF.leftView = imageView
        emailTF.leftViewMode = UITextFieldViewMode.Always
        
        self.emailTF.snp_makeConstraints { (make) in
            make.top.equalTo(welcomeLable.snp_bottom).offset(35)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(36)
        }
        
    }
    func addEmailTFBottomLine(){
        self.eLine.backgroundColor = UIColor.whiteColor()
        self.eLine.snp_makeConstraints { (make) in
            make.top.equalTo(emailTF.snp_bottom)
            make.height.equalTo(1)
            make.left.equalTo(emailTF.snp_left)
            make.right.equalTo(emailTF.snp_right)
        }
    }
    
    func setUpPasswordTF() {
        self.pswd.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        self.pswd.textColor = UIColor.whiteColor()
        self.pswd.clearButtonMode = .WhileEditing
        self.pswd.secureTextEntry = true
        self.pswd.returnKeyType = .Done
        
        //add left icon
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 24)
        pswd.leftView = imageView
        pswd.leftViewMode = UITextFieldViewMode.Always
        self.pswd.snp_makeConstraints { (make) in
            make.top.equalTo(emailTF.snp_bottom).offset(10)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(36)
        }

    }
    func addPasswordTFBottomLine(){
        self.pswdLine.backgroundColor = UIColor.whiteColor()
        self.pswdLine.snp_makeConstraints { (make) in
            make.top.equalTo(pswd.snp_bottom)
            make.height.equalTo(1)
            make.left.equalTo(pswd.snp_left)
            make.right.equalTo(pswd.snp_right)
        }
    }
    
    func setUpEmailLogInBtn() {
        self.emailLoginBtn.layer.cornerRadius = 4
        self.emailLoginBtn.backgroundColor = UIColor(red:0.80, green:0.36, blue:0.36, alpha:1.0) //Indian red
        self.emailLoginBtn.setTitle("LOGIN", forState: .Normal)
        self.emailLoginBtn.enabled = false
        self.emailLoginBtn.setTitleColor(Tools.bgColor, forState: .Disabled)
        self.emailLoginBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.pswdLine.snp_bottom).offset(25)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(36)
        }
        self.emailLoginBtn.addTarget(self, action: #selector(loginWithEmail), forControlEvents: .TouchUpInside)
        
    }
    
    func loginWithEmail() {
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
        
    }
    
    func setUpOrLable() {
        self.orLable.text = "OR"
        self.orLable.textColor = UIColor.whiteColor()
        //set to be at center
        self.orLable.textAlignment = .Center
        self.orLable.snp_makeConstraints { (make) in
            make.top.equalTo(self.forgetPasswordBtn.snp_bottom).offset(15)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
    }
    
    func setUpForgetPasswordButton() {
        self.forgetPasswordBtn.setTitle("Forget your password?", forState: .Normal)
        self.forgetPasswordBtn.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 14)
        self.forgetPasswordBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.emailLoginBtn.snp_bottom).offset(10)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
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
                    let sendEmailSuccess = UIAlertController(title: "Check you Inbox", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
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
        }
        self.presentViewController(resetPasswordAlert, animated: true, completion: nil)
        
    }
    
    func setupFacebookSignInBtn() {
        self.fbLoginBtn.layer.cornerRadius = 4
        self.fbLoginBtn.backgroundColor = UIColor(red:59/255, green:89/255, blue:152/255, alpha:1.0) //navy blue
        self.fbLoginBtn.setTitle("Sign In With Facebook", forState: .Normal)
        self.fbLoginBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.orLable.snp_bottom).offset(20)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(36)
        }
        
        self.fbLoginBtn.addTarget(self, action: #selector(loginFB), forControlEvents: .TouchUpInside)

    }
    
    func setUpRegisterBtn() {
        self.registerBtn.setTitle("Register an account", forState: .Normal)
        self.registerBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.fbLoginBtn.snp_bottom).offset(25)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
        }
        self.registerBtn.addTarget(self, action: #selector(goToRegisterPage), forControlEvents: .TouchUpInside)
    }
    
    func disMisSignInVc(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    // called when Facebook login button clicked.
    func loginFB() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
        SVProgressHUD.showWithStatus("Logging in...")
        let login: FBSDKLoginManager = FBSDKLoginManager()
        login .logInWithReadPermissions(["public_profile", "email"], fromViewController: self, handler: { (result, error) -> Void in
                    if error != nil {
                       // print("Process error")
                        SVProgressHUD.dismiss()
                    }
                    else if result.isCancelled {
                        //print("Cancelled")
                        SVProgressHUD.dismiss() 
                    }
                    else {
                       // print("Logged in")
                        let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                           // print("I am in Firebase now")
                            if error != nil{
                            return}
                            //save user name, email and avatar to Database
                            guard let uid = user?.uid, name = user?.displayName, email = user?.email else {return}
                            let values = ["name": name, "email": email]
                            self.registerUserIntoDatabaseWithUID(uid, values: values)
                            SVProgressHUD.dismiss()
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                        }
        
                    }
                    
                })

    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference()
        let userRef = ref.child("users").child(uid)
        userRef.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print(err)
                return}
        })
    }

    
    func goToRegisterPage() {
        let registerPage = registerWithEmail()
        self.presentViewController(registerPage, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.emailTF {
        self.pswd.becomeFirstResponder()}
        else {
        self.pswd.resignFirstResponder()}
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if Tools.isEmail(Tools.trim(self.emailTF.text!)) && Tools.trim(self.pswd.text!).characters.count >= 6 {
            self.emailLoginBtn.enabled = true
        }else {self.emailLoginBtn.enabled = false}
        
    }
    
    func allTextFieldsResignFirstResponder() {
        self.emailTF.resignFirstResponder()
        self.pswd.resignFirstResponder()
    }

    
}
