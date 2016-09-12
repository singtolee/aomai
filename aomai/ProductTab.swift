//
//  ProductTab.swift
//  aomai
//
//  Created by li qiang on 8/19/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
let cellID = "cellID"

class ProductTab: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(PrdCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false

    }
    
//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 27
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width/2 - 5, (view.frame.width/2 - 5) * 1.48)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}
