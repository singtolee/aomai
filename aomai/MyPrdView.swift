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
    
    let bottomBar = UIView()
    let sw = UIScreen.mainScreen().bounds.width
    var product: DetailProduct?
    
    var prdKey: String?
    //let sW = UIScreen.mainScreen().bounds.width
    
    let scrollView = UIScrollView()
    let carouselView = Carousel()
    let middleView = MiddleView()
    
    //bottomBar button
    let likeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "like"), forState: .Highlighted)
        btn.setImage(UIImage(named: "unlike"), forState: .Normal)
        return btn
    }()
    
    let addToCartBtn: UIButton = {
        let addBtn = UIButton()
        addBtn.setTitle("ADD TO CART", forState: .Normal)
        addBtn.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        addBtn.backgroundColor = Tools.dancingShoesColor
        addBtn.layer.cornerRadius = 6
        return addBtn
    }()
    
    let buyBtn: UIButton = {
        let buy = UIButton()
        buy.setTitle("BUY NOW", forState: .Normal)
        buy.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        buy.backgroundColor = Tools.dancingShoesColor
        buy.layer.cornerRadius = 6
        return buy
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = prdKey
        addScrollView()
        addCarousel()
        addMiddleView()
        findPrdbyKey()
        setUpBottomBar()
        
    }
    
    func setUpBottomBar() {
        view.addSubview(bottomBar)
        bottomBar.backgroundColor = UIColor.whiteColor()
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        bottomBar.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        bottomBar.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        bottomBar.heightAnchor.constraintEqualToConstant(40).active = true
        bottomBar.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.topAnchor.constraintEqualToAnchor(bottomBar.topAnchor).active = true
        likeButton.heightAnchor.constraintEqualToConstant(36).active = true
        likeButton.widthAnchor.constraintEqualToConstant(36).active = true
        likeButton.leftAnchor.constraintEqualToAnchor(bottomBar.leftAnchor, constant: 20).active = true
        
        bottomBar.addSubview(addToCartBtn)
        addToCartBtn.translatesAutoresizingMaskIntoConstraints = false
        addToCartBtn.topAnchor.constraintEqualToAnchor(bottomBar.topAnchor, constant: 2).active = true
        addToCartBtn.bottomAnchor.constraintEqualToAnchor(bottomBar.bottomAnchor, constant: -2).active = true
        //addToCartBtn.heightAnchor.constraintEqualToConstant(36).active = true
        addToCartBtn.widthAnchor.constraintEqualToConstant(140).active = true
        addToCartBtn.leftAnchor.constraintEqualToAnchor(likeButton.rightAnchor, constant: 14).active = true
        
        bottomBar.addSubview(buyBtn)
        buyBtn.translatesAutoresizingMaskIntoConstraints = false
        buyBtn.topAnchor.constraintEqualToAnchor(bottomBar.topAnchor, constant: 2).active = true
        buyBtn.bottomAnchor.constraintEqualToAnchor(bottomBar.bottomAnchor, constant: -2).active = true
        //addToCartBtn.heightAnchor.constraintEqualToConstant(36).active = true
        buyBtn.rightAnchor.constraintEqualToAnchor(bottomBar.rightAnchor, constant: -2).active = true
        buyBtn.leftAnchor.constraintEqualToAnchor(addToCartBtn.rightAnchor, constant: 2).active = true
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
        
        self.middleView.titleLable.text = prd.prdName!
        self.middleView.titleLable.font = UIFont(name: "AppleSDGothicNeo-Medium", size: sw/22)
        
        self.middleView.priceTag.text = "THB " + String(prd.prdPrice!)
        self.middleView.priceTag.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: sw/22)
        
        self.middleView.detailTag.text = prd.prdSub!
        self.middleView.detailTag.font = UIFont(name: "AppleSDGothicNeo-Light", size: sw/25)
        
        if(prd.prdQty < 1) {
            self.middleView.estimateDT.font = UIFont(name: "AppleSDGothicNeo-Medium", size: sw/30)
            self.middleView.estimateDT.text = "Estimated Delivery Time :" + "12:00"
        }else {
            self.middleView.estimateDT.font = UIFont(name: "AppleSDGothicNeo-Medium", size: sw/30)
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
