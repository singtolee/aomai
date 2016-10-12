//
//  MyPrdView.swift
//  aomai
//
//  Created by li qiang on 10/7/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MyPrdView: UIViewController, UIScrollViewDelegate {
    
    let sw = UIScreen.mainScreen().bounds.width
    var product: DetailProduct?
    
    var prdKey: String?
    //let sW = UIScreen.mainScreen().bounds.width
    
    let scrollView = UIScrollView()
    let carouselView = Carousel()
    let middleView = MiddleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = prdKey
        addScrollView()
        addCarousel()
        addMiddleView()
        findPrdbyKey()
        
    }
    
    func addMiddleView() {
        scrollView.addSubview(middleView)
        //middleView.backgroundColor = UIColor.brownColor()
        self.middleView.translatesAutoresizingMaskIntoConstraints = false
        middleView.topAnchor.constraintEqualToAnchor(self.carouselView.bottomAnchor).active = true
        middleView.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor).active = true
        middleView.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        //middleView.heightAnchor.constraintEqualToConstant(136).active = true
        
    }
    
    func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height*2)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        scrollView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        scrollView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        scrollView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        
    }
    
    func addCarousel() {
        carouselView.backgroundColor = UIColor.redColor()
        carouselView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(carouselView)
        carouselView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor).active = true
        carouselView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        carouselView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        carouselView.heightAnchor.constraintEqualToConstant(view.frame.width).active = true
    }
    
    func findPrdbyKey() {
        if (prdKey != nil){
            FIRDatabase.database().reference().child("AllProduct").child(prdKey!).observeSingleEventOfType(.Value, withBlock: { (snap) in
                if let dict = snap.value as? [String: AnyObject] {
                    let prd = DetailProduct()
                    var jg = "0"
                    var sl = "0"
                    prd.prdID = dict["productID"] as? String
                    prd.prdName = dict["productName"] as? String
                    prd.prdSub = dict["productSubDetail"] as? String
                    prd.prdPackageInfo = dict["productPackageInfo"] as? String
                    prd.prdSuppler = dict["productSuppler"] as? String
                    prd.prdWarranty = dict["productWarranty"] as? String
                    jg = (dict["productPrice"] as? String)!
                    sl = (dict["productQty"] as? String)!
                    if(Int(sl) != nil) {
                        prd.prdQty = Int(sl)
                    }else {
                        prd.prdQty = 0
                    }
                    if(Double(jg) != nil) {
                        prd.prdPrice = Double(jg)
                    } else {
                        prd.prdPrice = 9999.0
                    }
                    prd.isRefundable = dict["productRefundable"] as? Bool
                    prd.isBrand = dict["productBrand"] as? Bool
                    prd.prdImages = dict["productImages"] as? [String]
                    if let info = dict["productInfoImages"] as? [String] {
                        prd.prdInfoImages = info
                    }
                    self.product = prd
                    self.populateView(prd)
                }else {
                    //no prd with this key, error
                }
                
            })
        }
    }
    
    func populateView(prd: DetailProduct) {
        self.carouselView.pageControl.numberOfPages = prd.prdImages!.count
        self.carouselView.imageUrls = prd.prdImages!
        self.carouselView.collectionView.reloadData()
        
        self.middleView.titleLable.text = prd.prdName! + "\n" + prd.prdSub!
        self.middleView.titleLable.font = UIFont(name: "AppleSDGothicNeo-Medium", size: sw/25)
        
        self.middleView.priceTag.text = "THB " + String(prd.prdPrice!)
        self.middleView.priceTag.font = UIFont(name: "AppleSDGothicNeo-Medium", size: sw/25)
        
        if(prd.prdQty < 1) {
            self.middleView.priceTag.font = UIFont(name: "AppleSDGothicNeo-Medium", size: sw/30)
            self.middleView.estimateDT.text = "Estimated Delivery Time :" + "12:00"
        }else {
            self.middleView.priceTag.font = UIFont(name: "AppleSDGothicNeo-Medium", size: sw/30
            )
            self.middleView.estimateDT.text = "Estimated Delivery Time :" + "NOW"
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
        
    }


}
