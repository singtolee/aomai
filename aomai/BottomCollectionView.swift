//
//  BottomCollectionView.swift
//  aomai
//
//  Created by li qiang on 10/22/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import SDWebImage

class BottomCarousel: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    var imageUrls = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.registerClass(CarouselCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        collectionView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        collectionView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        collectionView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! CarouselCell
        let url = imageUrls[indexPath.item]
        if let imageUrl = NSURL(string: url) {
            cell.imageView.sd_setImageWithURL(imageUrl, placeholderImage: UIImage(named: "placeholder48"))
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width, frame.width)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
