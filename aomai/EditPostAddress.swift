//
//  EditPostAddress.swift
//  aomai
//
//  Created by li qiang on 9/4/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditPostAddress: DancingShoesViewController, UITextFieldDelegate {
    let recipientTF = UITextField()
    let phoneTF = MYTextField()
    let postCode = MYTextField()
    let detailAddressTF = UITextField()
    let defaultAddressSwitch = UISwitch()
    let setDefaultLable = UILabel()
    let saveBTN = UIButton()
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    //let buildingPicker = UIPickerView()
    //var buildings = [String]()
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setUpRecipientTF()
        setUpPhoneTF()
        setupPostCodeTF()
        setUpDetailAddressTF()
        addLable()
        addSwitch()
        addBtn()
        setUpActivityIndicator()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allTextFieldsResignFirstResponder)))
        self.view.userInteractionEnabled = true
    }
    
    func setUpActivityIndicator() {
        view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .Gray
        indicator.center = view.center
        //indicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        //indicator.bottomAnchor.constraintEqualToAnchor(saveBTN.topAnchor, constant: -10).active = true
    }
    
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height*1.0)
    }
    
    func setUpRecipientTF() {
        scrollView.addSubview(recipientTF)
        recipientTF.delegate = self
        recipientTF.placeholder = "RECIPIENT"
        recipientTF.borderStyle = .None
        recipientTF.autocorrectionType = .No
        recipientTF.clearButtonMode = .WhileEditing
        recipientTF.returnKeyType = .Next
        recipientTF.font = UIFont(name: "ArialHebrew-Light", size: 14)
        recipientTF.translatesAutoresizingMaskIntoConstraints = false
        recipientTF.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        recipientTF.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        recipientTF.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        recipientTF.topAnchor.constraintEqualToAnchor(scrollView.topAnchor, constant: 20).active = true
        recipientTF.heightAnchor.constraintEqualToConstant(36).active = true
        let subLine0 = UIView()
        subLine0.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(subLine0)
        subLine0.translatesAutoresizingMaskIntoConstraints = false
        subLine0.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        subLine0.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        subLine0.topAnchor.constraintEqualToAnchor(recipientTF.bottomAnchor).active = true
        subLine0.heightAnchor.constraintEqualToConstant(1).active = true
    }
    
    func setUpPhoneTF() {
        scrollView.addSubview(phoneTF)
        phoneTF.delegate = self
        phoneTF.keyboardType = .NumberPad
        phoneTF.clearButtonMode = .WhileEditing
        phoneTF.placeholder = "PHONE NUMBER"
        phoneTF.borderStyle = .None
        phoneTF.returnKeyType = .Next
        phoneTF.font = UIFont(name: "ArialHebrew-Light", size: 14)
        phoneTF.translatesAutoresizingMaskIntoConstraints = false
        phoneTF.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        phoneTF.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        phoneTF.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        phoneTF.topAnchor.constraintEqualToAnchor(recipientTF.bottomAnchor, constant: 10).active = true
        phoneTF.heightAnchor.constraintEqualToConstant(36).active = true
        let subLine1 = UIView()
        subLine1.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(subLine1)
        subLine1.translatesAutoresizingMaskIntoConstraints = false
        subLine1.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        subLine1.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        subLine1.topAnchor.constraintEqualToAnchor(phoneTF.bottomAnchor).active = true
        subLine1.heightAnchor.constraintEqualToConstant(1).active = true
    }
    
    func setUpDetailAddressTF() {
        scrollView.addSubview(detailAddressTF)
        detailAddressTF.delegate = self
        detailAddressTF.autocorrectionType = .No
        detailAddressTF.clearButtonMode = .WhileEditing
        detailAddressTF.placeholder = "DETAIL ADDRESS"
        detailAddressTF.borderStyle = .None
        detailAddressTF.returnKeyType = .Done
        detailAddressTF.font = UIFont(name: "ArialHebrew-Light", size: 14)
        detailAddressTF.translatesAutoresizingMaskIntoConstraints = false
        detailAddressTF.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        detailAddressTF.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        detailAddressTF.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        detailAddressTF.topAnchor.constraintEqualToAnchor(postCode.bottomAnchor, constant: 10).active = true
        detailAddressTF.heightAnchor.constraintEqualToConstant(36).active = true
        let subLine2 = UIView()
        subLine2.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(subLine2)
        subLine2.translatesAutoresizingMaskIntoConstraints = false
        subLine2.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        subLine2.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        subLine2.topAnchor.constraintEqualToAnchor(detailAddressTF.bottomAnchor).active = true
        subLine2.heightAnchor.constraintEqualToConstant(1).active = true
    }
    
    func setupPostCodeTF() {
        scrollView.addSubview(postCode)
        postCode.delegate = self
        postCode.keyboardType = .NumberPad
        postCode.clearButtonMode = .WhileEditing
        postCode.placeholder = "POST CODE"
        postCode.borderStyle = .None
        //postCode.returnKeyType = .Done
        postCode.font = UIFont(name: "ArialHebrew-Light", size: 14)
        postCode.translatesAutoresizingMaskIntoConstraints = false
        postCode.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        postCode.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        postCode.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        postCode.topAnchor.constraintEqualToAnchor(phoneTF.bottomAnchor, constant: 10).active = true
        postCode.heightAnchor.constraintEqualToConstant(36).active = true
        let subLine3 = UIView()
        subLine3.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(subLine3)
        subLine3.translatesAutoresizingMaskIntoConstraints = false
        subLine3.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        subLine3.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        subLine3.topAnchor.constraintEqualToAnchor(postCode.bottomAnchor).active = true
        subLine3.heightAnchor.constraintEqualToConstant(1).active = true
    }
    func addLable() {
        scrollView.addSubview(setDefaultLable)
        setDefaultLable.text = "DEFAULT ADDRESS"
        setDefaultLable.font = UIFont(name: "ArialHebrew-Light", size: 14)
        setDefaultLable.translatesAutoresizingMaskIntoConstraints = false
        setDefaultLable.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        setDefaultLable.centerYAnchor.constraintEqualToAnchor(detailAddressTF.bottomAnchor, constant: 30).active = true
    }
    
    func addSwitch() {
        scrollView.addSubview(defaultAddressSwitch)
        defaultAddressSwitch.onTintColor = Tools.dancingShoesColor
        defaultAddressSwitch.translatesAutoresizingMaskIntoConstraints = false
        defaultAddressSwitch.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        defaultAddressSwitch.centerYAnchor.constraintEqualToAnchor(detailAddressTF.bottomAnchor, constant: 30).active = true
    }
    
    func addBtn() {
        scrollView.addSubview(saveBTN)
        saveBTN.translatesAutoresizingMaskIntoConstraints = false
        saveBTN.backgroundColor = Tools.dancingShoesColor
        saveBTN.layer.cornerRadius = 6
        saveBTN.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        saveBTN.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        saveBTN.topAnchor.constraintEqualToAnchor(setDefaultLable.bottomAnchor, constant: 30).active = true
        saveBTN.heightAnchor.constraintEqualToConstant(36)
        saveBTN.setTitle("SAVE ADDRESS", forState: .Normal)
        saveBTN.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        saveBTN.addTarget(self, action: #selector(checkThenAddtoDB), forControlEvents: .TouchUpInside)
    }
    
    func checkThenAddtoDB() {
        let recipient = Tools.trim(recipientTF.text!)
        let mobile = phoneTF.text!
        let address = detailAddressTF.text
        let postcode = Tools.trim(postCode.text!)
        var isDefaultAddress: Bool = false
        if defaultAddressSwitch.on {
            isDefaultAddress = true
        }
        if recipient != "" && mobile.characters.count == 10 && address != "" && postcode.characters.count == 5 {
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                indicator.startAnimating()
                //var values: Dictionary = [String: String]()
                var values: Dictionary = [String: AnyObject]()
                values["Address"] = address
                values["PostCode"] = postcode
                values["recipient"] = recipient
                values["phone"] = mobile
                values["defaultAddress"] = isDefaultAddress
                let ref = FIRDatabase.database().reference().child("MailingAddresses").child(uid)
                let addressID = ref.childByAutoId().key
                ref.child(addressID).updateChildValues(values, withCompletionBlock: {(err, ref) in
                    if err != nil {
                        self.indicator.stopAnimating()
                        //print(err)
                        return}
                    self.indicator.stopAnimating()
                    self.navigationController?.popViewControllerAnimated(true)
                })
                //Tools.saveFreeDeliveryAddressIntoDatabaseWithUID(uid, values: values)
            }
        } else {
            if recipient == "" {
                Tools.shakingUIView(recipientTF)
            }
            if mobile.characters.count != 10 {
                Tools.shakingUIView(phoneTF)
            }
            if postcode.characters.count != 5 {
                Tools.shakingUIView(postCode)
            }
            if address == "" {
                Tools.shakingUIView(detailAddressTF)
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.postCode {
            switch UIScreen.mainScreen().bounds.height {
            case 480:
                //self.scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
                UIView.animateWithDuration(0.5, animations: {() -> Void in
                    self.scrollView.contentOffset = CGPoint(x: 0, y: 100)
                })
            case 568:
                //self.scrollView.setContentOffset(CGPoint(x: 0, y: 40), animated: true)
                UIView.animateWithDuration(0.5, animations: {() -> Void in
                    self.scrollView.contentOffset = CGPoint(x: 0, y: 40)
                })
            default:
                self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.recipientTF {
            self.phoneTF.becomeFirstResponder()
        }
        if (textField == detailAddressTF) {
            detailAddressTF.resignFirstResponder()
            UIView.animateWithDuration(0.5, animations: {() -> Void in
                self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
            })
        }
        return true
    }
    
    func allTextFieldsResignFirstResponder() {
        self.recipientTF.resignFirstResponder()
        self.phoneTF.resignFirstResponder()
        self.detailAddressTF.resignFirstResponder()
        self.postCode.resignFirstResponder()
        UIView.animateWithDuration(0.5, animations: {() -> Void in
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        })
    }
    
}
