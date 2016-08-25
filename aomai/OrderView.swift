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
    
    let noOrderImage = UIImage(named: "edit")
    let noOrderText = "There is nothing to display."

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .Plain, target: self, action: #selector(dismissVC))
        //self.navigationController?.navigationBar.barTintColor = Tools.bgColor
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = .Black
        
        self.title = "ORDERS"
        let emptyView = EmptyTableView(image: noOrderImage!, lableText: noOrderText)
        
        tableView.backgroundView = emptyView
        
    }
    
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
  }
