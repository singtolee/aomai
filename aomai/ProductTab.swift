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
let cellID = "cellID"

class ProductTab: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var shortPrd = [ShortProduct]()
   // let loadingIndicator = UIActivityIndicatorView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(PrdCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        
        loadShortPrd()

    }
    
//    func setupIndicator() {
//        self.view.addSubview(loadingIndicator)
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
//        loadingIndicator.center = view.center
//    }
    
    func loadShortPrd() {
        
        FIRDatabase.database().reference().child("ShortProducts").observeEventType(.ChildAdded, withBlock: { (snap) in
            if let dict = snap.value as? [String: String] {
                let prd = ShortProduct()
                prd.pID = dict["productID"]!
                prd.pName = dict["productName"]!
                prd.pSub = dict["productSubDetail"]!
                prd.pPrice = dict["productPrice"]!
                prd.pMainImage = dict["productMainImage"]!
                self.shortPrd.append(prd)
                dispatch_async(dispatch_get_main_queue(), {
                    self.collectionView?.reloadData()
                })
            }
        })
    }
    
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shortPrd.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! PrdCell
        let p = shortPrd[indexPath.row]
        cell.prdNameLable.text = p.pName
        cell.prdSubLable.text = p.pSub
        cell.prdPriceLable.text = "THB " + p.pPrice!
        if let imageUrl = p.pMainImage {
            cell.prdImageView.loadImageUsingCacheWithUrlString(imageUrl)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width/2 - 5, (view.frame.width/2 - 5) * 1.48)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
