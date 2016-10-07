//
//  CarouselCell.swift
//  aomai
//
//  Created by li qiang on 10/7/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .ScaleAspectFit
        return iv
    }()
    func setupViews() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        imageView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        imageView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
    }
    
}
