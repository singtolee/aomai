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
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }()
    let prdNameLable: UILabel = {
        let lab = UILabel()
        return lab
    }()
    let prdSubLable: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    let prdPriceLable: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.redColor()
        return lab
    }()
    let nameView = UIView()
    let subNameView = UIView()
    let priceView = UIView()
    let factor: CGFloat = 0.14
    
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        
        addSubview(prdImageView)
        addSubview(nameView)
        addSubview(subNameView)
        addSubview(priceView)
        
        nameView.addSubview(prdNameLable)
        subNameView.addSubview(prdSubLable)
        priceView.addSubview(prdPriceLable)
        
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
        subNameView.heightAnchor.constraintEqualToAnchor(self.widthAnchor, multiplier: factor).active = true
        
        priceView.topAnchor.constraintEqualToAnchor(subNameView.bottomAnchor).active = true
        priceView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        priceView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        priceView.heightAnchor.constraintEqualToAnchor(self.widthAnchor, multiplier: factor).active = true
        prdNameLable.centerYAnchor.constraintEqualToAnchor(nameView.centerYAnchor).active = true
        prdNameLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 4).active = true
        prdNameLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -4).active = true
        
        prdSubLable.topAnchor.constraintEqualToAnchor(subNameView.topAnchor).active = true
        prdSubLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 4).active = true
        prdSubLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -4).active = true
        
        prdPriceLable.centerYAnchor.constraintEqualToAnchor(priceView.centerYAnchor).active = true
        prdPriceLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: 4).active = true
        prdPriceLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor, constant: -4).active = true
    }
}

