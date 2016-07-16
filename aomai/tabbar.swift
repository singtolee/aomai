//
//  tabbar.swift
//  aomai
//
//  Created by li qiang on 7/14/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class tabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //store tab
        let store = storeTab()
        store.tabBarItem.title = "Store"
        store.tabBarItem.image = UIImage(named: "store")
        //cart tab
        let cart = cartTabViewController()
        cart.tabBarItem.title = "Cart"
        cart.tabBarItem.image = UIImage(named: "cart")
        //me tab
        let me = meTab()
        me.tabBarItem.title = "Me"
        me.tabBarItem.image = UIImage(named: "me")
        
        viewControllers = [store, cart, me]
    }

  }
