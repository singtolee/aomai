//
//  registerWithEmail.swift
//  aomai
//
//  Created by li qiang on 7/19/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class RegisterWithEmail: UIViewController, UITextFieldDelegate {
    
    let cancelRegisterBtn = UIButton()
    let inputEmailTF = UITextField()
    let emailBottomLine = UIView()
    let inputPasswordTF = MYTextField()
    let passwordBottomLine = UIView()
    let registerAccountBtn = UIButton()
    let offset = 24.0
    override func viewDidLoad() {
        super.viewDidLoad()
        //set delegate
        self.inputPasswordTF.delegate = self
        self.inputPasswordTF.clearButtonMode = .WhileEditing
        self.inputEmailTF.delegate = self
        self.inputEmailTF.clearButtonMode = .WhileEditing
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allTextFieldsResignFirstResponder)))
        self.view.userInteractionEnabled = true
        setupCancelRegisterBtn()
        setUpInputEmailTextField()
        setUpEmailBottomLine()
        setUpInputPasswordTextField()
        setUpPasswordBottomLine()
        setUpRegisterButton()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    func setupCancelRegisterBtn() {
        self.view.addSubview(cancelRegisterBtn)
        self.cancelRegisterBtn.setImage(UIImage(named: "cancelLogin"), forState: .Normal)
        self.cancelRegisterBtn.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(30)
            make.left.equalTo(self.view).offset(20)
            make.height.equalTo(36)
            make.width.equalTo(36)
        }
        self.cancelRegisterBtn.addTarget(self, action: #selector(dismissVC), forControlEvents: .TouchUpInside)
        
    }
    
    
    func setUpInputEmailTextField() {
        self.view.addSubview(inputEmailTF)
        self.inputEmailTF.keyboardType = .EmailAddress
        self.inputEmailTF.adjustsFontSizeToFitWidth = true
        self.inputEmailTF.autocorrectionType = .No
        self.inputEmailTF.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        self.inputEmailTF.textColor = UIColor.lightGrayColor()
        self.inputEmailTF.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        self.inputEmailTF.returnKeyType = .Next
        let imageView = UIImageView()
        imageView.image = UIImage(named: "email")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        inputEmailTF.leftView = imageView
        inputEmailTF.leftViewMode = UITextFieldViewMode.Always
        self.inputEmailTF.snp_remakeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.left.equalTo(self.view).offset(offset)
            make.right.equalTo(self.view).offset(-offset)
            make.height.equalTo(36)
        }

    }
    func setUpEmailBottomLine() {
        self.view.addSubview(emailBottomLine)
        self.emailBottomLine.backgroundColor = UIColor.lightGrayColor()
        self.emailBottomLine.snp_makeConstraints { (make) in
            make.top.equalTo(inputEmailTF.snp_bottom)
            make.height.equalTo(1)
            make.left.equalTo(inputEmailTF.snp_left)
            make.right.equalTo(inputEmailTF.snp_right)
        }
    }
    
    func setUpInputPasswordTextField() {
        self.view.addSubview(inputPasswordTF)
        self.inputPasswordTF.secureTextEntry = true
        self.inputPasswordTF.attributedPlaceholder = NSAttributedString(string: "Password(at least 6 chars)", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        self.inputPasswordTF.textColor = UIColor.lightGrayColor()
        self.inputPasswordTF.font = UIFont(name: "ArialRoundedMTBold", size: 14)
        self.inputPasswordTF.returnKeyType = .Done
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        inputPasswordTF.leftView = imageView
        inputPasswordTF.leftViewMode = UITextFieldViewMode.Always
        self.inputPasswordTF.snp_remakeConstraints { (make) in
            make.top.equalTo(inputEmailTF.snp_bottom).offset(10)
            make.left.equalTo(self.view).offset(offset)
            make.right.equalTo(self.view).offset(-offset)
            make.height.equalTo(36)
        }

    }
    func setUpPasswordBottomLine() {
        self.view.addSubview(passwordBottomLine)
        self.passwordBottomLine.backgroundColor = UIColor.lightGrayColor()
        self.passwordBottomLine.snp_makeConstraints { (make) in
            make.top.equalTo(inputPasswordTF.snp_bottom)
            make.height.equalTo(1)
            make.left.equalTo(inputPasswordTF.snp_left)
            make.right.equalTo(inputPasswordTF.snp_right)
        }
    }
    
    func setUpRegisterButton() {
        self.view.addSubview(registerAccountBtn)
        self.registerAccountBtn.setTitle("REGISTER", forState: .Normal)
        self.registerAccountBtn.titleLabel!.font =  UIFont(name: "ArialRoundedMTBold", size: 18)
        self.registerAccountBtn.setTitleColor(Tools.bgColor, forState: .Disabled)
        self.registerAccountBtn.layer.cornerRadius = 4
        self.registerAccountBtn.backgroundColor = Tools.dancingShoesColor //Indian red
        self.registerAccountBtn.snp_remakeConstraints { (make) in
            make.top.equalTo(inputPasswordTF.snp_bottom).offset(20)
            make.height.equalTo(36)
            make.left.equalTo(self.view).offset(offset)
            make.right.equalTo(self.view).offset(-offset)
        }
        self.registerAccountBtn.addTarget(self, action: #selector(onRegisterBtnClicked), forControlEvents: .TouchUpInside)
    }
    func dismissVC(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //called when register button clicked
    func onRegisterBtnClicked() {
        //first chcek all the textfields are filled and correct.
        if Tools.isEmail(Tools.trim(self.inputEmailTF.text!)) && Tools.trim(self.inputPasswordTF.text!).characters.count >= 6 {
            //go to register
            //register account and CANCEL uploading user avatar
            //show registering spin and stop when registration success
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
            SVProgressHUD.showWithStatus("Registering...")
            guard let email = inputEmailTF.text, pswd = inputPasswordTF.text
                else {return}
            FIRAuth.auth()?.createUserWithEmail(Tools.trim(email), password: Tools.trim(pswd), completion: {(user: FIRUser?, error) in
                if error != nil {
                    SVProgressHUD.dismiss()
                    //display error message
                    let errorEmailAlertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(_: UIAlertAction) -> Void in}
                    errorEmailAlertController.addAction(okAction)
                    self.presentViewController(errorEmailAlertController, animated: true, completion: nil)
                    return}
                //guard let uid = user?.uid else {return}
                //let values = ["email": Tools.trim(email)]
                //Tools.registerUserIntoDatabaseWithUID(uid, values: values)
                SVProgressHUD.dismiss()
                //send email verification
                FIRAuth.auth()?.currentUser?.sendEmailVerificationWithCompletion({(error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        return
                    }
                })
                self.dismissViewControllerAnimated(true, completion: nil)
                })
        } else {
            //shaking textfield
            if !Tools.isEmail(Tools.trim(self.inputEmailTF.text!)) {
                Tools.shakingUIView(inputEmailTF)
            }
            else if (Tools.trim(self.inputPasswordTF.text!).characters.count < 6) {
                Tools.shakingUIView(inputPasswordTF)
            }
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.inputEmailTF {
            self.inputPasswordTF.becomeFirstResponder()
        } else if (textField == self.inputPasswordTF) {
        self.inputPasswordTF.resignFirstResponder()
        }
        return true
    }
    
    func allTextFieldsResignFirstResponder() {
        self.inputEmailTF.resignFirstResponder()
        self.inputPasswordTF.resignFirstResponder()
    }
}
