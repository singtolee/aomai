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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.title = "PHONE NUMBER"
        setUpPhoneTF()
        setUpDoneBTN()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setUpPhoneTF() {
        view.addSubview(phoneTF)
        phoneTF.backgroundColor = UIColor.whiteColor()
        phoneTF.delegate = self
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
        //FIRDatabase.database().reference().child("users").child(uid!).updateChildValues(["name": Tools.trim(nameTF.text!)])
        FIRDatabase.database().reference().child("users").child(uid!).updateChildValues(["phone": Tools.trim(phoneTF.text!)]) { (error, ref) in
            if error != nil {
                return
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

}
