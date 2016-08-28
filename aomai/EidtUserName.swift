//
//  EidtUserName.swift
//  aomai
//
//  Created by li qiang on 8/28/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EidtUserName: UIViewController, UITextFieldDelegate {
    
    let nameTF = UITextField()
    let doneBTN = UIButton()
    let uid = FIRAuth.auth()?.currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.title = "EDIT NAME"
        setUpNameTF()
        setUpDoneBTN()
        

        // Do any additional setup after loading the view.
    }
    
    func setUpNameTF() {
        view.addSubview(nameTF)
        nameTF.backgroundColor = UIColor.whiteColor()
        nameTF.delegate = self
        nameTF.clearButtonMode = .WhileEditing
        nameTF.borderStyle = .RoundedRect
        nameTF.autocorrectionType = .No
        nameTF.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(80)
            make.left.equalTo(view).offset(24)
            make.right.equalTo(view).offset(-24)
            make.height.equalTo(36)
        }
        
    }
    
    func setUpDoneBTN() {
        view.addSubview(doneBTN)
        doneBTN.snp_makeConstraints { (make) in
            make.top.equalTo(nameTF.snp_bottom).offset(14)
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
        FIRDatabase.database().reference().child("users").child(uid!).updateChildValues(["name": Tools.trim(nameTF.text!)]) { (error, ref) in
            if error != nil {
                return
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

}
