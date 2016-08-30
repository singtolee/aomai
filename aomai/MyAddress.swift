//
//  address.swift
//  aomai
//
//  Created by li qiang on 8/1/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SnapKit

class MyAddress: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    let freeLabel = UILabel()
    var addFromDB = [String]()
    let addressPicker = UIPickerView()
    let addressTextField = UITextField()
    let detailAddressTextField = UITextField()
    let phoneTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFreeDeliveryLabel()
        setUpAddressTextField()
        setUpAddressPickerView()
        setUpDetailAddressTextField()
        setUpPhoneTextField()
        addressPicker.delegate = self
        addressPicker.dataSource = self
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false

        self.title = "EDIE ADDRESS"
        view.backgroundColor = UIColor.whiteColor()
        fetchOFB()
    }
    
    func fetchOFB() {
        FIRDatabase.database().reference().child("OfficeBuildings").observeEventType(.ChildAdded, withBlock: { (snapshot) in
            let oo = snapshot.value as! String
            self.addFromDB.append(oo)
            dispatch_async(dispatch_get_main_queue(), {
                self.addressPicker.userInteractionEnabled = true
                self.addressPicker.reloadAllComponents()
            })
        }, withCancelBlock: nil)
    }
    
    func setUpFreeDeliveryLabel() {
        self.view.addSubview(freeLabel)
        freeLabel.text = "We deliver to this address for free."
        freeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.left.equalTo(self.view).offset(30)
        }
    }
    
    func setUpAddressTextField() {
        self.view.addSubview(addressTextField)
        addressTextField.borderStyle = .RoundedRect
        addressTextField.placeholder = "Choose office building"
        addressTextField.inputView = addressPicker
        addressTextField.snp_makeConstraints { (make) in
            make.top.equalTo(self.freeLabel.snp_bottom).offset(20)
            make.left.equalTo(self.view).offset(24)
            make.right.equalTo(self.view).offset(-24)
            make.height.equalTo(36)
        }
    }
    func setUpAddressPickerView() {
        addressPicker.showsSelectionIndicator = true
        addressPicker.backgroundColor = Tools.bgColor
        addressPicker.userInteractionEnabled = false
        //add Done button
        let toolBar = UIToolbar()
        toolBar.barStyle = .Default
        toolBar.translucent = true
        toolBar.tintColor = Tools.bgColor
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(doneButtonForPicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        self.addressTextField.inputAccessoryView = toolBar
    }
    func setUpDetailAddressTextField() {
        detailAddressTextField.borderStyle = .RoundedRect
        self.detailAddressTextField.returnKeyType = .Done
        self.detailAddressTextField.placeholder = "Floor and Room Number"
        self.detailAddressTextField.delegate = self
        self.view.addSubview(detailAddressTextField)
        self.detailAddressTextField.snp_makeConstraints { (make) in
            make.top.equalTo(addressTextField.snp_bottom).offset(10)
            make.left.equalTo(addressTextField)
            make.right.equalTo(addressTextField)
            make.height.equalTo(36)
        }
    }
    
    func setUpPhoneTextField() {
        phoneTextField.borderStyle = .RoundedRect
        self.phoneTextField.delegate = self
        self.view.addSubview(phoneTextField)
        self.phoneTextField.returnKeyType = .Done
        self.phoneTextField.placeholder = "Phone Number"
        self.phoneTextField.snp_makeConstraints { (make) in
            make.top.equalTo(detailAddressTextField.snp_bottom).offset(10)
            make.left.equalTo(detailAddressTextField)
            make.right.equalTo(detailAddressTextField)
            make.height.equalTo(36)
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.detailAddressTextField.resignFirstResponder()
        return true
    }
    
    func doneButtonForPicker() {
        self.addressTextField.resignFirstResponder()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return addFromDB.count
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = addFromDB[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 8.0)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        return myTitle
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addressTextField.text = addFromDB[row]
    }
}
