//
//  CategoryProductsListView.swift
//  aomai
//
//  Created by li qiang on 9/21/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//
import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

let cellID = "cellID"

class CategoryProductView: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var shortPrd = [ShortProduct]()
    let screenWidth = UIScreen.mainScreen().bounds.width
    var cellSize = CGSizeZero
    var fontSize = CGFloat()
    let loadingIndicator = MyIndicator()
    var category = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(PrdCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        setupIndicator()
        setCellSize()
        loadShortPrd()
        
    }
    
    func setCellSize() {
        let width = (screenWidth - 8) / 2 - 1
        let height = width * 1.42
        self.cellSize = CGSize(width: width, height: height)
        self.fontSize = screenWidth / 25
    }
    
    func setupIndicator() {
        self.view.addSubview(loadingIndicator)
        //loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.widthAnchor.constraintEqualToConstant(42).active = true
        loadingIndicator.heightAnchor.constraintEqualToConstant(24).active = true
        loadingIndicator.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        loadingIndicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    func loadShortPrd() {
        self.loadingIndicator.startAnimating()
        FIRDatabase.database().reference().child(category).observeEventType(.ChildAdded, withBlock: { (snap) in
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
                    self.loadingIndicator.stopAnimating()
                })
            } else {
                //no data
                self.loadingIndicator.stopAnimating()
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
        cell.prdNameLable.font = UIFont(name: "AppleSDGothicNeo-Light", size: fontSize)
        cell.prdSubLable.text = p.pSub
        cell.prdSubLable.font = UIFont(name: "AppleSDGothicNeo-Thin", size: fontSize)
        cell.prdPriceLable.text = "THB " + p.pPrice!
        cell.prdPriceLable.font = UIFont(name: "AppleSDGothicNeo-Light", size: fontSize)
        if let imageUrl = NSURL(string: p.pMainImage!) {
            //cell.prdImageView.loadImageUsingCacheWithUrlString(imageUrl)
            cell.prdImageView.sd_setImageWithURL(imageUrl, placeholderImage: UIImage(named: "placeholder48"))
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //return CGSizeMake(view.frame.width/2 - 5, (view.frame.width/2 - 5) * 1.48)
        return cellSize
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

