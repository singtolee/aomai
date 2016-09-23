//
//  EidtUserName.swift
//  aomai
//
//  Created by li qiang on 8/28/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
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
        nameTF.placeholder = "Name"
        nameTF.delegate = self
        nameTF.clearButtonMode = .WhileEditing
        nameTF.borderStyle = .RoundedRect
        nameTF.autocorrectionType = .No
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        nameTF.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 80).active = true
        nameTF.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        nameTF.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        nameTF.heightAnchor.constraintEqualToConstant(36).active = true
    }
    
    func setUpActivityIndicator() {
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .Gray
        indicator.bottomAnchor.constraintEqualToAnchor(nameTF.topAnchor, constant: -10).active = true
        indicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    func setUpDoneBTN() {
        view.addSubview(doneBTN)
        doneBTN.translatesAutoresizingMaskIntoConstraints = false
        doneBTN.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        doneBTN.topAnchor.constraintEqualToAnchor(nameTF.bottomAnchor, constant: 14).active = true
        doneBTN.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        doneBTN.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        doneBTN.heightAnchor.constraintEqualToConstant(36).active = true
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
