//
//  ProductTab.swift
//  aomai
//
//  Created by li qiang on 8/19/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProductTab: DancingShoesViewController {
    var CategoryList = [String]()
    var viewControllers = [CategoryProductView]()
    var tabs = [String]()
    let vc = CategoryProductView()
    let indicator = MyIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCategory()
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.widthAnchor.constraintEqualToConstant(42).active = true
        indicator.heightAnchor.constraintEqualToConstant(24).active = true
        indicator.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        indicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    func loadTabandVCs() {
        for cate in CategoryList {
            let vc = CategoryProductView(collectionViewLayout: UICollectionViewFlowLayout())
            //vc.topLayoutGuide.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 34)
            //vc.view.frame = CGRectMake(0, 100, self.view.frame.width, self.view.frame.height - 149)
            vc.category = cate
            self.viewControllers.append(vc)
            self.tabs.append(cate)
        }
        
        let slidingVC = SlidingContainerViewController(
            parent: self,
            contentViewControllers: viewControllers,
            titles: tabs
        )
        view.addSubview(slidingVC.view)
        slidingVC.sliderView.appearance.outerPadding = 0
        slidingVC.sliderView.appearance.innerPadding = 10
        slidingVC.setCurrentViewControllerAtIndex(0)
    }
    
    func loadCategory() {
        self.indicator.startAnimating()
        FIRDatabase.database().reference().child("ProductCategory").observeEventType(.Value, withBlock: { (snap) in
            for child in snap.children {
                guard let csnap = child as? FIRDataSnapshot else {return}
                let category = csnap.value as! String
                self.CategoryList.append(category)
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.loadTabandVCs()
                self.indicator.stopAnimating()
            })
            
        })
    }
    
    func slidingContainerViewControllerDidShowSliderView(slidingVC: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(slidingVC: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewController(slidingVC: SlidingContainerViewController, viewController: UIViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewControllerAtIndex(slidingVC: SlidingContainerViewController, index: Int) {
        
    }
    
    
}

