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

class registerWithEmail: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let cancelRegisterBtn = UIButton()
    let chooesAvatarImageView = UIImageView()
    let inputNameTF = UITextField()
    let nameBottomLine = UIView()
    let inputEmailTF = UITextField()
    let emailBottomLine = UIView()
    let inputPasswordTF = UITextField()
    let passwordBottomLine = UIView()
    let registerAccountBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        //set delegate
        self.inputPasswordTF.delegate = self
        self.inputPasswordTF.clearButtonMode = .WhileEditing
        self.inputEmailTF.delegate = self
        self.inputEmailTF.clearButtonMode = .WhileEditing
        self.inputNameTF.delegate = self
        self.inputNameTF.clearButtonMode = .WhileEditing
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allTextFieldsResignFirstResponder)))
        self.view.userInteractionEnabled = true
        setupCancelRegisterBtn()
        setUpChooseAvatarImageView()
        setUpUserNameTextField()
        setUpNameBottomLine()
        setUpInputEmailTextField()
        setUpEmailBottomLine()
        setUpInputPasswordTextField()
        setUpPasswordBottomLine()
        setUpRegisterButton()
        //About Keyboard
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.moveUp), name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.moveBack), name: UIKeyboardWillHideNotification, object: nil)
            }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //About Keyboard
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.moveUp), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.moveBack), name: UIKeyboardWillHideNotification, object: nil)
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
    
    func setUpChooseAvatarImageView() {
        self.view.addSubview(chooesAvatarImageView)
        self.chooesAvatarImageView.image = UIImage(named: "whiteAva")
        self.chooesAvatarImageView.snp_remakeConstraints { (make) in
            make.size.equalTo(100)
            make.top.equalTo(self.view).offset(80)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        self.chooesAvatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openPhotosToChooseAvatar)))
        self.chooesAvatarImageView.userInteractionEnabled = true
    }
    //open photos to choose user Avatar
    func openPhotosToChooseAvatar() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.chooesAvatarImageView.image = selectedImage
            self.chooesAvatarImageView.layer.cornerRadius = self.chooesAvatarImageView.frame.size.width/2
            self.chooesAvatarImageView.clipsToBounds = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setUpUserNameTextField() {
        self.view.addSubview(inputNameTF)
        self.inputNameTF.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        self.inputNameTF.textColor = UIColor.lightGrayColor()
        self.inputNameTF.returnKeyType = .Next
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userName")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        inputNameTF.leftView = imageView
        inputNameTF.leftViewMode = UITextFieldViewMode.Always
        self.inputNameTF.snp_remakeConstraints { (make) in
            make.top.equalTo(chooesAvatarImageView.snp_bottom).offset(40)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(36)
        }
    }
    func setUpNameBottomLine() {
        self.view.addSubview(nameBottomLine)
        self.nameBottomLine.backgroundColor = UIColor.lightGrayColor()
        self.nameBottomLine.snp_makeConstraints { (make) in
            make.top.equalTo(inputNameTF.snp_bottom)
            make.height.equalTo(1)
            make.left.equalTo(inputNameTF.snp_left)
            make.right.equalTo(inputNameTF.snp_right)
        }
    }
    
    func setUpInputEmailTextField() {
        self.view.addSubview(inputEmailTF)
        self.inputEmailTF.keyboardType = .EmailAddress
        self.inputEmailTF.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        self.inputEmailTF.textColor = UIColor.lightGrayColor()
        self.inputEmailTF.returnKeyType = .Next
        let imageView = UIImageView()
        imageView.image = UIImage(named: "email")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        inputEmailTF.leftView = imageView
        inputEmailTF.leftViewMode = UITextFieldViewMode.Always
        self.inputEmailTF.snp_remakeConstraints { (make) in
            make.top.equalTo(inputNameTF.snp_bottom).offset(10)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
            make.height.equalTo(36)
        }

    }
    func setUpEmailBottomLine() {
        self.view.addSubview(emailBottomLine)
        self.emailBottomLine.backgroundColor = UIColor.lightGrayColor()
        self.emailBottomLine.snp_makeConstraints { (make) in
            make.top.equalTo(inputEmailTF.snp_bottom)
            make.height.equalTo(1)
            make.left.equalTo(inputNameTF.snp_left)
            make.right.equalTo(inputNameTF.snp_right)
        }
    }
    
    func setUpInputPasswordTextField() {
        self.view.addSubview(inputPasswordTF)
        self.inputPasswordTF.secureTextEntry = true
        self.inputPasswordTF.attributedPlaceholder = NSAttributedString(string: "Password(at least 6 digits)", attributes: [NSForegroundColorAttributeName : UIColor.lightGrayColor()])
        self.inputPasswordTF.textColor = UIColor.lightGrayColor()
        self.inputPasswordTF.returnKeyType = .Done
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock")
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        inputPasswordTF.leftView = imageView
        inputPasswordTF.leftViewMode = UITextFieldViewMode.Always
        self.inputPasswordTF.snp_remakeConstraints { (make) in
            make.top.equalTo(inputEmailTF.snp_bottom).offset(10)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
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
        self.registerAccountBtn.setTitle("REGISTER", forState: .Disabled)
        self.registerAccountBtn.setTitleColor(Tools.bgColor, forState: .Disabled)
        //self.registerAccountBtn.enabled = false
        self.registerAccountBtn.layer.cornerRadius = 4
        self.registerAccountBtn.backgroundColor = Tools.dancingShoesColor //Indian red
        self.registerAccountBtn.snp_remakeConstraints { (make) in
            make.top.equalTo(inputPasswordTF.snp_bottom).offset(20)
            make.height.equalTo(36)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
        }
        self.registerAccountBtn.addTarget(self, action: #selector(onRegisterBtnClicked), forControlEvents: .TouchUpInside)
    }
    func dismissVC(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //called when register button clicked
    func onRegisterBtnClicked() {
        //first chcek all the textfields are filled and correct.
        if Tools.isEmail(Tools.trim(self.inputEmailTF.text!)) && Tools.trim(self.inputNameTF.text!).characters.count >= 1 && Tools.trim(self.inputPasswordTF.text!).characters.count >= 6 {
            //go to register
            //register account and upload user avatar
            //show registering spin and stop when registration success
            SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
            SVProgressHUD.showWithStatus("Registering...")
            guard let name = inputNameTF.text, email = inputEmailTF.text, pswd = inputPasswordTF.text
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
                guard let uid = user?.uid else {return}
                
                let imageName = NSUUID().UUIDString
                let storeageRef = FIRStorage.storage().reference().child("UserAvatar").child("\(imageName).png")
                //use JPEG format to compress profile picture
                if let uploadData = UIImageJPEGRepresentation(self.chooesAvatarImageView.image!, 0.1){
                    //if let uploadData = UIImagePNGRepresentation(self.chooesAvatarImageView.image!){
                    storeageRef.putData(uploadData, metadata: nil, completion: {(metadata, error) in
                        if error != nil {
                            SVProgressHUD.dismiss()
                            //display error message
                            let failedUploadingAvatarAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                            let ok1Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(_: UIAlertAction) -> Void in }
                            failedUploadingAvatarAlert.addAction(ok1Action)
                            self.presentViewController(failedUploadingAvatarAlert, animated: true, completion: nil)
                            //print(error)
                            return}
                        if let userAvatarUrl = metadata?.downloadURL()?.absoluteString{
                            let values = ["name": Tools.trim(name), "email": Tools.trim(email), "userAvatarUrl": userAvatarUrl]
                            self.registerUserIntoDatabaseWithUID(uid, values: values)
                        }
                    })
                }
            })
        } else {
            //shaking textfield
            if (Tools.trim(self.inputNameTF.text!).characters.count < 1) {
                Tools.shakingUIView(self.inputNameTF)
            }
            else if !Tools.isEmail(Tools.trim(self.inputEmailTF.text!)) {
                Tools.shakingUIView(inputEmailTF)
            }
            else if (Tools.trim(self.inputPasswordTF.text!).characters.count < 6) {
                Tools.shakingUIView(inputPasswordTF)
            }
            else {
                //do nothing
            }
        }
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference()
        let userRef = ref.child("users").child(uid)
        userRef.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                //display error message, failed write to database
                let failedWriteDatabaseAlert = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                let ok2Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(_: UIAlertAction) -> Void in }
                failedWriteDatabaseAlert.addAction(ok2Action)
                self.presentViewController(failedWriteDatabaseAlert, animated: true, completion: nil)
                SVProgressHUD.dismiss()
                return}
            SVProgressHUD.dismiss()
            //send email verification 
            FIRAuth.auth()?.currentUser?.sendEmailVerificationWithCompletion({(error) in
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                //print("email is sent")
            })
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.inputNameTF {
            self.inputEmailTF.becomeFirstResponder()
        }else if (textField == self.inputEmailTF) {
        self.inputPasswordTF.becomeFirstResponder()
        }
        else {
        self.inputPasswordTF.resignFirstResponder()}
        return true
    }
    
//    func textFieldDidEndEditing(textField: UITextField) {
//        if Tools.isEmail(Tools.trim(self.inputEmailTF.text!)) && Tools.trim(self.inputNameTF.text!).characters.count > 3 && Tools.trim(self.inputPasswordTF.text!).characters.count >= 6 {
//            self.registerAccountBtn.enabled = true
//        }else {
//        self.registerAccountBtn.enabled = false}
//    }
    //touch on view, resign keyboard
    func allTextFieldsResignFirstResponder() {
        self.inputNameTF.resignFirstResponder()
        self.inputEmailTF.resignFirstResponder()
        self.inputPasswordTF.resignFirstResponder()
    }
   
    func moveUp(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()) != nil {
            self.view.frame.origin.y = 0
            switch view.bounds.height {
            case 480:
               // self.view.frame.origin.y -= 200
                UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: {
                    self.view.frame.origin.y -= 200
                    self.view.layoutIfNeeded()
                    print("I am 4s")
                    }, completion: nil)
            case 568:
                //self.view.frame.origin.y -= 120
                UIView.animateWithDuration(5, delay: 0.0, options: .CurveLinear, animations: {
                    self.view.frame.origin.y -= 120
                    self.view.layoutIfNeeded()
                    }, completion: nil)
            default:
                //self.view.frame.origin.y -= 10
                UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: {
                    self.view.frame.origin.y -= 10
                    self.view.layoutIfNeeded()
                    }, completion: nil)
            }//4s: 200, 5and5s:120, 6and6s:10
        }
    }
    func moveBack(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue()) != nil {
            //self.view.frame.origin.y = 0
            UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: {
                self.view.frame.origin.y = 0
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
