//
//  EditFreeAddress.swift
//  aomai
//
//  Created by li qiang on 9/4/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class EditFreeAddress: DancingShoesViewController, UITextFieldDelegate {
    
    let recipientTF = UITextField()
    let phoneTF = UITextField()
    let roomTF = UITextField()
    let buildingTF = MYTextField()
    let defaultAddressSwitch = UISwitch()
    let setDefaultLable = UILabel()
    let saveBTN = UIButton()
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setUpRecipientTF()
        setUpPhoneTF()
        setUpBuildingTF()
        setupRoomNumberTF()
        addLable()
        addSwitch()
        addBtn()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allTextFieldsResignFirstResponder)))
        self.view.userInteractionEnabled = true
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
    
    func setUpBuildingTF() {
        scrollView.addSubview(buildingTF)
        buildingTF.delegate = self
        buildingTF.clearButtonMode = .UnlessEditing
        buildingTF.placeholder = "OFFICE BUILDING"
        buildingTF.borderStyle = .None
        buildingTF.returnKeyType = .Next
        buildingTF.font = UIFont(name: "ArialHebrew-Light", size: 14)
        buildingTF.translatesAutoresizingMaskIntoConstraints = false
        buildingTF.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        buildingTF.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        buildingTF.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        buildingTF.topAnchor.constraintEqualToAnchor(phoneTF.bottomAnchor, constant: 10).active = true
        buildingTF.heightAnchor.constraintEqualToConstant(36).active = true
        let subLine2 = UIView()
        subLine2.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(subLine2)
        subLine2.translatesAutoresizingMaskIntoConstraints = false
        subLine2.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        subLine2.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        subLine2.topAnchor.constraintEqualToAnchor(buildingTF.bottomAnchor).active = true
        subLine2.heightAnchor.constraintEqualToConstant(1).active = true
    }
    
    func setupRoomNumberTF() {
        scrollView.addSubview(roomTF)
        roomTF.delegate = self
        roomTF.autocorrectionType = .No
        roomTF.clearButtonMode = .WhileEditing
        roomTF.placeholder = "ROOM NUMBER"
        roomTF.borderStyle = .None
        roomTF.returnKeyType = .Done
        roomTF.font = UIFont(name: "ArialHebrew-Light", size: 14)
        roomTF.translatesAutoresizingMaskIntoConstraints = false
        roomTF.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        roomTF.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        roomTF.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        roomTF.topAnchor.constraintEqualToAnchor(buildingTF.bottomAnchor, constant: 10).active = true
        roomTF.heightAnchor.constraintEqualToConstant(36).active = true
        let subLine3 = UIView()
        subLine3.backgroundColor = UIColor.lightGrayColor()
        scrollView.addSubview(subLine3)
        subLine3.translatesAutoresizingMaskIntoConstraints = false
        subLine3.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        subLine3.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        subLine3.topAnchor.constraintEqualToAnchor(roomTF.bottomAnchor).active = true
        subLine3.heightAnchor.constraintEqualToConstant(1).active = true
    }
    func addLable() {
        scrollView.addSubview(setDefaultLable)
        setDefaultLable.text = "DEFAULT ADDRESS"
        setDefaultLable.font = UIFont(name: "ArialHebrew-Light", size: 14)
        setDefaultLable.translatesAutoresizingMaskIntoConstraints = false
        setDefaultLable.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        setDefaultLable.centerYAnchor.constraintEqualToAnchor(roomTF.bottomAnchor, constant: 30).active = true
        //setDefaultLable.heightAnchor.constraintEqualToConstant(20).active = true
    }
    
    func addSwitch() {
        scrollView.addSubview(defaultAddressSwitch)
        defaultAddressSwitch.onTintColor = Tools.dancingShoesColor
        defaultAddressSwitch.translatesAutoresizingMaskIntoConstraints = false
        defaultAddressSwitch.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        defaultAddressSwitch.centerYAnchor.constraintEqualToAnchor(roomTF.bottomAnchor, constant: 30).active = true
        //defaultAddressSwitch.heightAnchor.constraintEqualToConstant(10).active = true
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
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.recipientTF {
            self.phoneTF.becomeFirstResponder()
        } else if (textField == self.phoneTF) {
            self.buildingTF.becomeFirstResponder()
        } else if (textField == buildingTF) {
            self.roomTF.becomeFirstResponder()
        } else if (textField == roomTF) {
            roomTF.resignFirstResponder()
        }
        return true
    }
    
    func allTextFieldsResignFirstResponder() {
        self.recipientTF.resignFirstResponder()
        self.phoneTF.resignFirstResponder()
        self.buildingTF.resignFirstResponder()
        self.roomTF.resignFirstResponder()
    }

    
}
