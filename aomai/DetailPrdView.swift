//
//  DetailPrdView.swift
//  aomai
//
//  Created by li qiang on 9/26/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class DetailPrdView: DancingShoesViewController {
    
    var product: DetailProduct?
    var prdKey: String?
//    let sW = UIScreen.mainScreen().bounds.width
//    let sH = UIScreen.mainScreen().bounds.height
//    
//    private lazy var scrollView: DetailScrollView = {
//        let scrollView = DetailScrollView()
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.delegate = self
//        return scrollView
//    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(prdKey)
        findPrdbyKey()
        //setupUI()
    }
    
    func findPrdbyKey() {
        if (prdKey != nil){
            FIRDatabase.database().reference().child("AllProduct").child(prdKey!).observeSingleEventOfType(.Value, withBlock: { (snap) in
                //print(snap)
                if let dict = snap.value as? [String: AnyObject] {
                    let prd = DetailProduct()
                    prd.prdID = dict["productID"]! as? String
                    prd.prdName = dict["productName"] as? String
                    prd.prdSub = dict["productSubDetail"] as? String
                    prd.prdPackageInfo = dict["productPackageInfo"]! as? String
                    prd.prdSuppler = dict["productSuppler"] as? String
                    prd.prdWarranty = dict["productWarranty"] as? String
                    prd.prdQty = dict["productQty"] as? Int
                    prd.prdPrice = dict["productPrice"] as? Double
                    prd.isRefundable = dict["productRefundable"] as? Bool
                    prd.isBrand = dict["productBrand"] as? Bool
                    prd.prdImages = dict["productImages"] as? [String]
                    prd.prdInfoImages = dict["productInfoImages"] as? [String]
                    
                    self.product = prd
                    print(self.product?.isBrand)
                    
                }
                
            })
        }
    }
    
//    func setupUI() {
//        
//        view.addSubview(scrollView)
//        // 添加底部栏
//        scrollView.product = product
//        
//        scrollView.snp_makeConstraints { (make) in
//            make.top.left.right.equalTo(view)
//        }
//    
//        
//        scrollView.contentSize = CGSizeMake(sW, sH - 64 - 45 + 2 + 520)
//    }
//    
    

}

//extension DetailPrdView: UIScrollViewDelegate {
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        var offsetY = scrollView.contentOffset.y
//        if offsetY >= 465 {
//            offsetY = CGFloat(465)
//            scrollView.contentOffset = CGPointMake(0, offsetY)
//        }
//    }
//}

