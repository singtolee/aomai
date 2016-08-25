//
//  Tools.swift
//  aomai
//
//  Created by li qiang on 7/20/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import Foundation
import UIKit

class Tools {
    
    static let bgColor: UIColor = UIColor(red:21/255, green:67/255, blue:96/255, alpha:1.0)
    static let dancingShoesColor = UIColor(red:255/255, green:56/255, blue:69/255, alpha:1.0)
    
    static func trim(str: String) -> String{
        
        return str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    static func isEmail(email :String) -> Bool {
    
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(email)
    }
    
    static func shakingUIView(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - 10, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + 10, textField.center.y))
        textField.layer.addAnimation(animation, forKey: "position")
    }

    
}
