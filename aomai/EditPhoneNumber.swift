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
    let phoneTF = MYTextField()
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
        phoneTF.translatesAutoresizingMaskIntoConstraints = false
        phoneTF.backgroundColor = UIColor.whiteColor()
        phoneTF.delegate = self
        phoneTF.placeholder = "Mobile Phone"
        phoneTF.keyboardType = .NumberPad
        phoneTF.clearButtonMode = .WhileEditing
        phoneTF.borderStyle = .RoundedRect
        phoneTF.autocorrectionType = .No
        phoneTF.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 80).active = true
        phoneTF.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        phoneTF.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        phoneTF.heightAnchor.constraintEqualToConstant(36).active = true
    }
    
    func setUpActivityIndicator() {
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .Gray
        indicator.bottomAnchor.constraintEqualToAnchor(phoneTF.topAnchor, constant: -10).active = true
        indicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    func setUpDoneBTN() {
        view.addSubview(doneBTN)
        doneBTN.translatesAutoresizingMaskIntoConstraints = false
        doneBTN.topAnchor.constraintEqualToAnchor(phoneTF.bottomAnchor, constant: 14).active = true
        doneBTN.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        doneBTN.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        doneBTN.heightAnchor.constraintEqualToConstant(36).active = true
        doneBTN.layer.cornerRadius = 4
        doneBTN.setTitle("UPDATE", forState: .Normal)
        doneBTN.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        doneBTN.backgroundColor = Tools.dancingShoesColor
        doneBTN.addTarget(self, action: #selector(updateUserName), forControlEvents: .TouchUpInside)
    }
    
    func updateUserName() {
        let newPhone = Tools.trim(phoneTF.text!)
        if (newPhone.characters.count == 10) {
            self.indicator.startAnimating()
            FIRDatabase.database().reference().child("users").child(uid!).updateChildValues(["phone": newPhone]) { (error, ref) in
                if error != nil {
                    self.indicator.stopAnimating()
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
