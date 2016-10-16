//
//  OrderView.swift
//  aomai
//
//  Created by li qiang on 8/10/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class OrderView: UITableViewController {
       override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor //导航栏背景色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor() //导航栏字体颜色
        self.navigationController?.navigationBar.barStyle = .Black  //根据导航栏改变状态栏颜色
        self.navigationController?.navigationBar.translucent = false
        self.title = "ORDERS"
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}
