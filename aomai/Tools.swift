//
//  Tools.swift
//  aomai
//
//  Created by li qiang on 7/20/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class Tools {
    
    static let bgColor: UIColor = UIColor(red:251/255, green:252/255, blue:252/255, alpha:1.0)
    static let veryLightColor: UIColor = UIColor(red:21/255, green:67/255, blue:96/255, alpha:1.0)
    static let dancingShoesColor = UIColor(red:255/255, green:56/255, blue:69/255, alpha:1.0)  //FF3845
    static let headerColor = UIColor(red: 242/255, green: 244/255, blue: 244/255, alpha: 1.0)
    static let placeHolderColor = UIColor(red: 199/255, green: 199/255, blue: 205/255, alpha: 1.0)
    
    static func trim(str: String) -> String{
        
        return str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    static func isEmail(email :String) -> Bool {
    
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    
    static func shakingUIView(textField: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - 10, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + 10, textField.center.y))
        textField.layer.addAnimation(animation, forKey: "position")
    }
    
    static func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference().child("users").child(uid)
        ref.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print(err)
                return}
        })
    }
    
    static func saveFreeDeliveryAddressIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference().child("FreeDeliveryAddresses").child(uid)
        ref.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print(err)
                return}
        })
    }


    
}
