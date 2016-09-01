//
//  MYTextField.swift
//  aomai
//
//  Created by li qiang on 9/2/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class MYTextField: UITextField {
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(NSObject.paste(_:)){
            return false
        }
        
    return super.canPerformAction(action, withSender: sender)
    }
}
