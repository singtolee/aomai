//
//  BriefProductCollectionViewCell.swift
//  aomai
//
//  Created by li qiang on 9/13/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import Foundation
import UIKit
class PrdCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let prdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder48")
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    let prdNameLable: UILabel = {
        let lab = UILabel()
        //lab.font = UIFont(name: "ArialHebrew-Light", size: textSize)
        lab.text = "AOMAI PRODUCT"
        return lab
    }()
    let prdSubLable: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 2
        //lab.font = UIFont(name: "ArialHebrew-Light", size: textSize)
        lab.text = "AOMAI PRODUCT,AOMAI PRODUCT,AOMAI PRODUCT"
        return lab
    }()
    
    let prdPriceLable: UILabel = {
        let lab = UILabel()
        //lab.font = UIFont(name: "ArialHebrew-Light", size: textSize)
        lab.text = "THB 199"
        lab.textColor = UIColor.redColor()
        return lab
    }()
    let nameView = UIView()
    let subNameView = UIView()
    let priceView = UIView()
    let factor: CGFloat = 0.12
    
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        
        addSubview(prdImageView)
        addSubview(nameView)
        addSubview(subNameView)
        addSubview(priceView)
        
        nameView.addSubview(prdNameLable)
        //nameView.backgroundColor = UIColor.grayColor()
        subNameView.addSubview(prdSubLable)
        priceView.addSubview(prdPriceLable)
        //priceView.backgroundColor = UIColor.cyanColor()
        
        nameView.translatesAutoresizingMaskIntoConstraints = false
        subNameView.translatesAutoresizingMaskIntoConstraints = false
        priceView.translatesAutoresizingMaskIntoConstraints = false
        
        prdImageView.translatesAutoresizingMaskIntoConstraints = false
        prdNameLable.translatesAutoresizingMaskIntoConstraints = false
        prdSubLable.translatesAutoresizingMaskIntoConstraints = false
        prdPriceLable.translatesAutoresizingMaskIntoConstraints = false
        
        prdImageView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        prdImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        prdImageView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        prdImageView.heightAnchor.constraintEqualToAnchor(self.widthAnchor).active = true
        
        nameView.topAnchor.constraintEqualToAnchor(prdImageView.bottomAnchor).active = true
        nameView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        nameView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        nameView.heightAnchor.constraintEqualToAnchor(self.widthAnchor, multiplier: factor).active = true
        
        subNameView.topAnchor.constraintEqualToAnchor(nameView.bottomAnchor).active = true
        subNameView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        subNameView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        subNameView.heightAnchor.constraintEqualToAnchor(self.widthAnchor, multiplier: factor * 2).active = true
        
        priceView.topAnchor.constraintEqualToAnchor(subNameView.bottomAnchor).active = true
        priceView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        priceView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        priceView.heightAnchor.constraintEqualToAnchor(self.widthAnchor, multiplier: factor).active = true
        //priceView.heightAnchor.constraintEqualToConstant(30).active = true //font
        
        
        
        
        prdNameLable.centerYAnchor.constraintEqualToAnchor(nameView.centerYAnchor).active = true
        prdNameLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 4).active = true
        prdNameLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -4).active = true
        
        prdSubLable.centerYAnchor.constraintEqualToAnchor(subNameView.centerYAnchor).active = true
        prdSubLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 4).active = true
        prdSubLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -4).active = true
        
        prdPriceLable.centerYAnchor.constraintEqualToAnchor(priceView.centerYAnchor).active = true
        prdPriceLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 4).active = true
        prdPriceLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -4).active = true
        
        
        
        
    }
}

