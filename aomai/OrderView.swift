//
//  OrderView.swift
//  aomai
//
//  Created by li qiang on 8/10/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import SnapKit

class OrderView: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Return", style: .Plain, target: self, action: #selector(dismissVC))
        //self.navigationController?.navigationBar.barTintColor = Tools.bgColor
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = .Black
        
        self.title = "My Orders"

    }
    
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
  }
