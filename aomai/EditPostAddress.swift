//
//  EditPostAddress.swift
//  aomai
//
//  Created by li qiang on 9/8/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditPostAddress: AddPostAddress {
    
    var address: PostAddress?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "deleteAddress"), style: .Plain, target: self, action: #selector(deleteAddress))
        saveBTN.setTitle("UPDATE", forState: .Normal)
        recipientTF.text = address?.recipient
        phoneTF.text = address?.phone
        postCode.text = address?.postCode
        detailAddressTF.text = address?.detailAddress
        
    }
    override func checkThenAddtoDB() {
        let recipient = Tools.trim(recipientTF.text!)
        let mobile = phoneTF.text!
        let address = detailAddressTF.text
        let postcode = Tools.trim(postCode.text!)
        if recipient != "" && mobile.characters.count == 10 && address != "" && postcode.characters.count == 5 {
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                indicator.startAnimating()
                var values: Dictionary = [String: AnyObject]()
                values["Address"] = address
                values["PostCode"] = postcode
                values["recipient"] = recipient
                values["phone"] = mobile
                let ref = FIRDatabase.database().reference().child("MailingAddresses").child(uid).child(self.address!.ID)
                //let addressID = ref.childByAutoId().key
                //values["ID"] = addressID
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
            if postcode.characters.count != 5 {
                Tools.shakingUIView(postCode)
            }
            if address == "" {
                Tools.shakingUIView(detailAddressTF)
            }
        }
    }
    
    func deleteAddress() {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            indicator.startAnimating()
            let ref = FIRDatabase.database().reference().child("MailingAddresses").child(uid).child(self.address!.ID)
            ref.removeValueWithCompletionBlock({ (error, ref) in
                if error != nil {
                    self.indicator.stopAnimating()
                    return
                }
                self.indicator.stopAnimating()
                self.navigationController?.popViewControllerAnimated(true)
                
            })
        }
        
    }
    
}
