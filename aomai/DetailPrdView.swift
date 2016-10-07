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

class DetailPrdView: DancingShoesViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var product: DetailProduct?
    var pImage = [String]()
    var prdKey: String?
    let sW = UIScreen.mainScreen().bounds.width
    let sH = UIScreen.mainScreen().bounds.height
    
    var imageCarouselCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: sW, height: sW)
        layout.scrollDirection = .Horizontal
        imageCarouselCollectionView = UICollectionView(frame: CGRectMake(0, 0, sW, sW + 200), collectionViewLayout: layout)
        imageCarouselCollectionView.dataSource = self
        imageCarouselCollectionView.delegate = self
        imageCarouselCollectionView.showsHorizontalScrollIndicator = false
        imageCarouselCollectionView.pagingEnabled = true
        imageCarouselCollectionView.backgroundColor = UIColor.lightGrayColor()
        imageCarouselCollectionView.registerClass(DetailPrdCarouselCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(imageCarouselCollectionView)
        imageCarouselCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageCarouselCollectionView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        imageCarouselCollectionView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        imageCarouselCollectionView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        imageCarouselCollectionView.heightAnchor.constraintEqualToConstant(self.sW).active = true
        findPrdbyKey()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pImage.count
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(sW, sW + 200)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! DetailPrdCarouselCollectionViewCell
        let url = pImage[indexPath.item]
        if let imageUrl = NSURL(string: url) {
            cell.prdImageView.sd_setImageWithURL(imageUrl, placeholderImage: UIImage(named: "placeholder48"))
        }
        return cell
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
                    self.pImage = prd.prdImages!
                    self.imageCarouselCollectionView.reloadData()
                    print(prd.isBrand)
                    print(prd.prdPrice)
                    print(prd.prdQty)
                    print(prd.prdName)
                }else {
                    //no prd with this key, error
                }
                
            })
        }
    }

}



