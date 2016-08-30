//
//  EditPhoneNumber.swift
//  aomai
//
//  Created by li qiang on 8/28/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class EditPhoneNumber: UIViewController, UITextFieldDelegate {
    let phoneTF = UITextField()
    let doneBTN = UIButton()
    let uid = FIRAuth.auth()?.currentUser?.uid
    let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        self.title = "PHONE NUMBER"
        setUpPhoneTF()
        setUpDoneBTN()
        setUpActivityIndicator()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setUpPhoneTF() {
        view.addSubview(phoneTF)
        phoneTF.backgroundColor = UIColor.whiteColor()
        phoneTF.delegate = self
        phoneTF.placeholder = "Mobile Phone"
        phoneTF.keyboardType = .NumberPad
        phoneTF.clearButtonMode = .WhileEditing
        phoneTF.borderStyle = .RoundedRect
        phoneTF.autocorrectionType = .No
        phoneTF.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(80)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
            make.height.equalTo(36)
        }
        
    }
    
    func setUpActivityIndicator() {
        view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .Gray
        indicator.snp_makeConstraints { (make) in
            make.bottom.equalTo(phoneTF.snp_top).offset(-10)
            make.centerX.equalTo(view.snp_centerX)
        }
    }
    
    func setUpDoneBTN() {
        view.addSubview(doneBTN)
        doneBTN.snp_makeConstraints { (make) in
            make.top.equalTo(phoneTF.snp_bottom).offset(14)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
            make.height.equalTo(36)
        }
        doneBTN.layer.cornerRadius = 4
        doneBTN.setTitle("UPDATE", forState: .Normal)
        doneBTN.backgroundColor = Tools.dancingShoesColor
        doneBTN.addTarget(self, action: #selector(updateUserName), forControlEvents: .TouchUpInside)
    }
    
    func updateUserName() {
        self.indicator.startAnimating()
        let newPhone = Tools.trim(phoneTF.text!)
        if (newPhone.characters.count == 10) {
            FIRDatabase.database().reference().child("users").child(uid!).updateChildValues(["phone": newPhone]) { (error, ref) in
                if error != nil {
                    return
                }
                self.indicator.stopAnimating()
                self.navigationController?.popViewControllerAnimated(true)
            }
        } else {
            Tools.shakingUIView(phoneTF)
        }
    }

}
