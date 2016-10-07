//
//  DancingShoesViewController.swift
//  aomai
//
//  Created by li qiang on 9/4/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class DancingShoesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        //UINavigationBar.appearance().shadowImage = UIImage()
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
    }
}
