//
//  EmptyTableView.swift
//  aomai
//
//  Created by li qiang on 8/24/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class EmptyTableView: UIView {
    
    var imageView = UIImageView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
    var lable = UILabel(frame: CGRect(x: 100, y: 300, width: 100, height: 36))
    
    override init(frame : CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image: UIImage, lableText: String) {
        super.init(frame: CGRectZero)
        self.imageView.image = image
        self.lable.text = lableText
        addSubview(imageView)
        addSubview(lable)
        
    }

}
