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
        let store = StoreTab()
        store.tabBarItem.title = "Store"
        store.tabBarItem.image = UIImage(named: "store")
        
        let prd = ProductTab()
        prd.tabBarItem.title = "Product"
        prd.tabBarItem.image = UIImage(named: "product")
        
        //cart tab
        let cart = CartTab()
        cart.tabBarItem.title = "Cart"
        cart.tabBarItem.image = UIImage(named: "cart")
        //me tab
        let me = MeTab()
        me.tabBarItem.title = "Me"
        me.tabBarItem.image = UIImage(named: "me")
        
        viewControllers = [store, prd, cart, me]
    }

  }
