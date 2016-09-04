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
    let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        self.title = "EDIT NAME"
        setUpNameTF()
        setUpDoneBTN()
        setUpActivityIndicator()
        

        // Do any additional setup after loading the view.
    }
    
    func setUpNameTF() {
        view.addSubview(nameTF)
        nameTF.backgroundColor = UIColor.whiteColor()
        nameTF.adjustsFontSizeToFitWidth = true
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
    
    func setUpActivityIndicator() {
        view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .Gray
        indicator.snp_makeConstraints { (make) in
            make.bottom.equalTo(nameTF.snp_top).offset(-10)
            make.centerX.equalTo(view.snp_centerX)
        }
    }
    
    func setUpDoneBTN() {
        view.addSubview(doneBTN)
        doneBTN.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 18)
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
        let newName = Tools.trim(nameTF.text!)
        if (newName.characters.count > 0) {
            self.indicator.startAnimating()
            FIRDatabase.database().reference().child("users").child(uid!).updateChildValues(["name": newName]) { (error, ref) in
                if error != nil {
                    self.indicator.stopAnimating()
                    return
                }
                self.indicator.stopAnimating()
                self.navigationController?.popViewControllerAnimated(true)
            }
        } else {
            Tools.shakingUIView(nameTF)
        }
    }

}
