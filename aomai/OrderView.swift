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
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor //导航栏背景色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor() //导航栏字体颜色
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = .Black  //根据导航栏改变状态栏颜色
        
        self.title = "ORDERS"
        let emptyView = EmptyTableView(image: noOrderImage!, lableText: noOrderText)
        
        tableView.backgroundView = emptyView
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
  }
