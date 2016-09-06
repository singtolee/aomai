//
//  EditFreeAddress.swift
//  aomai
//
//  Created by li qiang on 9/4/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditFreeAddress: DancingShoesViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let recipientTF = UITextField()
    let phoneTF = MYTextField()
    let roomTF = UITextField()
    let buildingTF = MYTextField()
    //let defaultAddressSwitch = UISwitch()
    //let setDefaultLable = UILabel()
    let saveBTN = UIButton()
    let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    let buildingPicker = UIPickerView()
    var buildings = [String]()
    let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setScrollView()
        setUpRecipientTF()
        setUpPhoneTF()
        setUpBuildingTF()
        setupRoomNumberTF()
        addBtn()
        setupBuildingPicker()
        setUpActivityIndicator()
        buildingPicker.delegate = self
        buildingPicker.dataSource = self
        self.fetchOFB()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(allTextFieldsResignFirstResponder)))
        self.view.userInteractionEnabled = true
    }
    
    func setUpActivityIndicator() {
        view.addSubview(indicator)
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .Gray
        indicator.center = view.center
        //indicator.centerXAnchor.constraintEqualToAnchor(saveBTN.centerXAnchor).active = true
        //indicator.bottomAnchor.constraintEqualToAnchor(roomTF.bottomAnchor, constant: 10).active = true
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
        buildingTF.inputView = buildingPicker
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
//    func addLable() {
//        scrollView.addSubview(setDefaultLable)
//        setDefaultLable.text = "DEFAULT ADDRESS"
//        setDefaultLable.font = UIFont(name: "ArialHebrew-Light", size: 14)
//        setDefaultLable.translatesAutoresizingMaskIntoConstraints = false
//        setDefaultLable.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
//        setDefaultLable.centerYAnchor.constraintEqualToAnchor(roomTF.bottomAnchor, constant: 30).active = true
//    }
//    
//    func addSwitch() {
//        scrollView.addSubview(defaultAddressSwitch)
//        defaultAddressSwitch.onTintColor = Tools.dancingShoesColor
//        defaultAddressSwitch.translatesAutoresizingMaskIntoConstraints = false
//        defaultAddressSwitch.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
//        defaultAddressSwitch.centerYAnchor.constraintEqualToAnchor(roomTF.bottomAnchor, constant: 30).active = true
//    }
    
    func addBtn() {
        scrollView.addSubview(saveBTN)
        saveBTN.translatesAutoresizingMaskIntoConstraints = false
        saveBTN.backgroundColor = Tools.dancingShoesColor
        saveBTN.layer.cornerRadius = 6
        saveBTN.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 24).active = true
        saveBTN.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -24).active = true
        saveBTN.topAnchor.constraintEqualToAnchor(roomTF.bottomAnchor, constant: 40).active = true
        saveBTN.heightAnchor.constraintEqualToConstant(36)
        saveBTN.setTitle("SAVE ADDRESS", forState: .Normal)
        saveBTN.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 18)
        saveBTN.addTarget(self, action: #selector(checkThenAddtoDB), forControlEvents: .TouchUpInside)
    }
    
    func checkThenAddtoDB() {
        let recipient = Tools.trim(recipientTF.text!)
        let mobile = phoneTF.text!
        let ofb = buildingTF.text
        let room = Tools.trim(roomTF.text!)
//        var isDefaultAddress: Bool = false
//        if defaultAddressSwitch.on {
//            isDefaultAddress = true
//        }
        if recipient != "" && mobile.characters.count == 10 && ofb != "" && room != "" {
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                indicator.startAnimating()
                //var values: Dictionary = [String: String]()
                var values: Dictionary = [String: AnyObject]()
                values["officeBuilding"] = ofb
                values["roomNumber"] = room
                values["recipient"] = recipient
                values["phone"] = mobile
                //values["defaultAddress"] = isDefaultAddress
                let ref = FIRDatabase.database().reference().child("FreeDeliveryAddresses").child(uid)
                ref.updateChildValues(values, withCompletionBlock: {(err, ref) in
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
            if ofb == "" {
                Tools.shakingUIView(buildingTF)
            }
            if room == "" {
                Tools.shakingUIView(roomTF)
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == self.roomTF {
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
            default: break
                //self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.recipientTF {
            self.phoneTF.becomeFirstResponder()
        }
        if (textField == roomTF) {
            roomTF.resignFirstResponder()
            //self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            UIView.animateWithDuration(0.5, animations: {() -> Void in
                self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
            })
        }
        return true
    }
    
    func allTextFieldsResignFirstResponder() {
        self.recipientTF.resignFirstResponder()
        self.phoneTF.resignFirstResponder()
        self.buildingTF.resignFirstResponder()
        self.roomTF.resignFirstResponder()
        //if this code can make it running smoothly
        UIView.animateWithDuration(0.5, animations: {() -> Void in
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        })
        //self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func setupBuildingPicker() {
        buildingPicker.backgroundColor = UIColor.whiteColor()
        buildingPicker.showsSelectionIndicator = true
        buildingPicker.userInteractionEnabled = false
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = Tools.dancingShoesColor
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(doneButtonForPicker))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(cancelButtonForPicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, flexibleSpace, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        self.buildingTF.inputAccessoryView = toolBar
        
    }
    
    func fetchOFB() {
        FIRDatabase.database().reference().child("OfficeBuildings").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let ob = snapshot.value as! String
            self.buildings.append(ob)
            dispatch_async(dispatch_get_main_queue(), {
                self.buildingPicker.userInteractionEnabled = true
                self.buildingPicker.reloadAllComponents()
            })
            }, withCancelBlock: nil)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return buildings.count
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let lab = UILabel()
        lab.text = buildings[row]
        lab.textColor = Tools.dancingShoesColor
        lab.font = UIFont(name: "ArialHebrew-Light", size: 16)
        lab.textAlignment = .Center
        return lab
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        buildingTF.text = buildings[row]
    }
    
    func doneButtonForPicker() {
        self.buildingTF.resignFirstResponder()
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
        default: break
            //self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
        //self.scrollView.setContentOffset(CGPoint(x:0, y:100), animated: true)
        self.roomTF.becomeFirstResponder()
    }
    
    func cancelButtonForPicker() {
        self.buildingTF.resignFirstResponder()
    }


    
}
