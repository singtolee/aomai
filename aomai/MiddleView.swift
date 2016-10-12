//
//  MiddleView.swift
//  aomai
//
//  Created by li qiang on 10/8/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class MiddleView: UIView {
    
    
    let titleLable: UITextView = {
        let tv = UITextView()
        tv.textColor = UIColor.blackColor()
        //tv.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        return tv
    }()
    
    let priceTag: UITextView = {
        let lb = UITextView()
        lb.textColor = Tools.dancingShoesColor
        //lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        return lb
    }()

    let estimateDT: UITextView = {
        let lb = UITextView()
        lb.textColor = UIColor.lightGrayColor()
        return lb
    }()
    
    func addTitle() {
        addSubview(titleLable)
        titleLable.scrollEnabled = false
        titleLable.editable = false
        //titleLable.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //titleLable.backgroundColor = UIColor.cyanColor()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        titleLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        titleLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        //titleLable.heightAnchor.constraintEqualToConstant(60).active = true
    }
    func addPriceTag() {
        addSubview(priceTag)
        priceTag.editable = false
        priceTag.scrollEnabled = false
        priceTag.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        //priceTag.backgroundColor = UIColor.yellowColor()
        priceTag.translatesAutoresizingMaskIntoConstraints = false
        priceTag.topAnchor.constraintEqualToAnchor(titleLable.bottomAnchor).active = true
        priceTag.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        priceTag.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
    }
    
    func estimatedDT() {
        addSubview(estimateDT)
        estimateDT.editable = false
        estimateDT.scrollEnabled = false
        //estimateDT.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        estimateDT.translatesAutoresizingMaskIntoConstraints = false
        estimateDT.topAnchor.constraintEqualToAnchor(priceTag.bottomAnchor).active = true
        estimateDT.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        estimateDT.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTitle()
        addPriceTag()
        estimatedDT()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

