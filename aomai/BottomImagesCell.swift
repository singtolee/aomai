//
//  BottomImagesCell.swift
//  aomai
//
//  Created by li qiang on 10/20/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
class BottomImagesCell: UITableViewCell {
    let img: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(img)
        //img.contentMode = .ScaleAspectFit
        img.contentMode = .ScaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        img.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        img.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        img.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        
    }
}