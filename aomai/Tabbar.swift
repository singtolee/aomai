//
//  tabbar.swift
//  aomai
//
//  Created by li qiang on 7/14/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class Tabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //store tab
        let store = StoreTab()
        store.tabBarItem.title = "Store"
        store.tabBarItem.image = UIImage(named: "store")
        let navStore = UINavigationController()
        navStore.viewControllers = [store]
        
        
        //let prd = ProductTab(collectionViewLayout: UICollectionViewFlowLayout())
        let prd = ProductTab()
        prd.tabBarItem.title = "Product"
        prd.tabBarItem.image = UIImage(named: "product")
        let navPrd = UINavigationController()
        navPrd.viewControllers = [prd]
        
        //cart tab
        let cart = CartTab()
        cart.tabBarItem.title = "Cart"
        cart.tabBarItem.image = UIImage(named: "cart")
        //me tab
        let me = MeTab()
        me.tabBarItem.title = "Me"
        me.tabBarItem.image = UIImage(named: "me")
        //test if I can put this view controller inside Navigation controller,
        let nav = UINavigationController()
        nav.viewControllers = [me]
        viewControllers = [navStore, navPrd, cart, nav]
    }

  }
