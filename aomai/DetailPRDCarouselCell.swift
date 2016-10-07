//
//  DetailPRDCarouselCell.swift
//  aomai
//
//  Created by li qiang on 9/27/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class DetailPrdCarouselCollectionViewCell: UICollectionViewCell {
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
    
    func setupViews() {
        backgroundColor = UIColor.whiteColor()
        addSubview(prdImageView)
        prdImageView.translatesAutoresizingMaskIntoConstraints = false
        prdImageView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        prdImageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        prdImageView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        //prdImageView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        prdImageView.heightAnchor.constraintEqualToConstant(frame.width).active = true
        //prdImageView.heightAnchor.constraintEqualToAnchor(self.widthAnchor).active = true
    }


}
