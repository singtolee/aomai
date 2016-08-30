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
    let noImageVIew = UIImageView()
    let noLab = UILabel()
    let noOrderImage = UIImage(named: "edit")
    let noOrderText = "You do not have order yet."
    let bgView = UIView(frame: UIScreen.mainScreen().bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        setBGView()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor //导航栏背景色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor() //导航栏字体颜色
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = .Black  //根据导航栏改变状态栏颜色
        self.navigationController?.navigationBar.translucent = false
        self.title = "ORDERS"
        //let emptyView = EmptyTableView(image: noOrderImage!, lableText: noOrderText)
        
        tableView.backgroundView = bgView
        
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func setBGView() {
        noImageVIew.image = noOrderImage
        noLab.text = noOrderText
        bgView.addSubview(noImageVIew)
        bgView.addSubview(noLab)
        noImageVIew.snp_makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp_centerX)
            make.centerY.equalTo(bgView.snp_centerY)
        }
        noLab.snp_makeConstraints { (make) in
            make.centerX.equalTo(bgView.snp_centerX)
            //make.centerY.equalTo(bgView.snp_centerY).offset(100)
            make.top.equalTo(noImageVIew.snp_bottom).offset(10)
        }
    }
    
  }
