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
        tv.scrollEnabled = false
        tv.editable = false
        tv.textColor = UIColor.blackColor()
        return tv
    }()
    
    let priceTag: UITextView = {
        let lb = UITextView()
        lb.scrollEnabled = false
        lb.editable = false
        lb.textColor = Tools.dancingShoesColor
        return lb
    }()
    
    let detailTag: UITextView = {
        let tv = UITextView()
        tv.scrollEnabled = false
        tv.editable = false
        return tv
    }()
    
    let commitmentView = UIView()
    
    let freeShippingLable: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        let iconSize = CGRect(x: 0, y: 1, width: 8, height: 8)
        let attributedString = NSMutableAttributedString(string: "  ")
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "dot")
        attachment.bounds = iconSize
        attributedString.appendAttributedString(NSAttributedString(attachment: attachment))
        attributedString.appendAttributedString(NSAttributedString(string: " FREE DELIVERY"))
        lb.attributedText = attributedString
        return lb
    }()
    
    let cashOnDeliveryLable: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        let iconSize = CGRect(x: 0, y: 1, width: 8, height: 8)
        let attributedString = NSMutableAttributedString(string: "  ")
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "dot")
        attachment.bounds = iconSize
        attributedString.appendAttributedString(NSAttributedString(attachment: attachment))
        attributedString.appendAttributedString(NSAttributedString(string: " CASH ON DELIVERY(BANGKOK SELECTED AREA)"))
        lb.attributedText = attributedString
        return lb
    }()
    
    let refundableLable: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        let iconSize = CGRect(x: 0, y: 1, width: 8, height: 8)
        let attributedString = NSMutableAttributedString(string: "  ")
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "dot")
        attachment.bounds = iconSize
        attributedString.appendAttributedString(NSAttributedString(attachment: attachment))
        attributedString.appendAttributedString(NSAttributedString(string: " REFUNDABLE WITHIN 7 DAYS"))
        lb.attributedText = attributedString
        return lb
    }()
    
    let nonrefundableLable: UILabel = {
        let lb = UILabel()
        lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        let iconSize = CGRect(x: 0, y: 1, width: 8, height: 8)
        let attributedString = NSMutableAttributedString(string: "  ")
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "undot")
        attachment.bounds = iconSize
        attributedString.appendAttributedString(NSAttributedString(attachment: attachment))
        attributedString.appendAttributedString(NSAttributedString(string: " NON-REFUNDABLE"))
        lb.attributedText = attributedString
        return lb
    }()
    
    let warrantyLable: UITextView = {
        let lb = UITextView()
        lb.scrollEnabled = false
        lb.editable = false
        lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return lb
    }()
    
    let packageTV: UITextView = {
        let lb = UITextView()
        lb.scrollEnabled = false
        lb.editable = false
        lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return lb
    }()
    
    let supplerInfoTV: UITextView = {
        let lb = UITextView()
        lb.scrollEnabled = false
        lb.editable = false
        lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return lb
    }()
    
    let isBrand: UITextView = {
        let lb = UITextView()
        lb.scrollEnabled = false
        lb.editable = false
        lb.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        return lb
    }()
    
    func addTitle() {
        addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        titleLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        titleLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
    }
    func addPriceTag() {
        addSubview(priceTag)
        //priceTag.textContainerInset = UIEdgeInsetsMake(0, 4, 0, 0)
        priceTag.translatesAutoresizingMaskIntoConstraints = false
        priceTag.topAnchor.constraintEqualToAnchor(titleLable.bottomAnchor).active = true
        priceTag.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        priceTag.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
    }
    
    func addDetailTag() {
        addSubview(detailTag)
        detailTag.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        detailTag.translatesAutoresizingMaskIntoConstraints = false
        detailTag.topAnchor.constraintEqualToAnchor(priceTag.bottomAnchor).active = true
        detailTag.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        detailTag.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
    }
    
    func setUpCommitmentView() {
        commitmentView.addSubview(freeShippingLable)
        freeShippingLable.backgroundColor = UIColor.whiteColor()
        freeShippingLable.translatesAutoresizingMaskIntoConstraints = false
        freeShippingLable.topAnchor.constraintEqualToAnchor(commitmentView.topAnchor, constant: 4).active = true
        freeShippingLable.leftAnchor.constraintEqualToAnchor(commitmentView.leftAnchor, constant: 0).active = true
        freeShippingLable.rightAnchor.constraintEqualToAnchor(commitmentView.rightAnchor).active = true
        
        commitmentView.addSubview(cashOnDeliveryLable)
        cashOnDeliveryLable.backgroundColor = UIColor.whiteColor()
        cashOnDeliveryLable.translatesAutoresizingMaskIntoConstraints = false
        cashOnDeliveryLable.topAnchor.constraintEqualToAnchor(freeShippingLable.bottomAnchor, constant: 4).active = true
        cashOnDeliveryLable.leftAnchor.constraintEqualToAnchor(commitmentView.leftAnchor, constant: 0).active = true
        cashOnDeliveryLable.rightAnchor.constraintEqualToAnchor(commitmentView.rightAnchor).active = true
        
        commitmentView.addSubview(refundableLable)
        refundableLable.hidden = true
        refundableLable.backgroundColor = UIColor.whiteColor()
        refundableLable.translatesAutoresizingMaskIntoConstraints = false
        refundableLable.topAnchor.constraintEqualToAnchor(cashOnDeliveryLable.bottomAnchor, constant: 4).active = true
        refundableLable.leftAnchor.constraintEqualToAnchor(commitmentView.leftAnchor, constant: 0).active = true
        refundableLable.rightAnchor.constraintEqualToAnchor(commitmentView.rightAnchor).active = true
        
        commitmentView.addSubview(nonrefundableLable)
        nonrefundableLable.hidden = true
        nonrefundableLable.backgroundColor = UIColor.whiteColor()
        nonrefundableLable.translatesAutoresizingMaskIntoConstraints = false
        nonrefundableLable.topAnchor.constraintEqualToAnchor(cashOnDeliveryLable.bottomAnchor, constant: 4).active = true
        nonrefundableLable.leftAnchor.constraintEqualToAnchor(commitmentView.leftAnchor, constant: 0).active = true
        nonrefundableLable.rightAnchor.constraintEqualToAnchor(commitmentView.rightAnchor).active = true
        
    }
    
    
    func addCommitmentView() {
        setUpCommitmentView()
        addSubview(commitmentView)
        commitmentView.backgroundColor = UIColor.whiteColor()
        commitmentView.translatesAutoresizingMaskIntoConstraints = false
        commitmentView.topAnchor.constraintEqualToAnchor(detailTag.bottomAnchor, constant: 6).active = true
        commitmentView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        commitmentView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        commitmentView.heightAnchor.constraintEqualToConstant(56).active = true
        
    }
    
    func addWarranty() {
        addSubview(warrantyLable)
        warrantyLable.translatesAutoresizingMaskIntoConstraints = false
        warrantyLable.topAnchor.constraintEqualToAnchor(commitmentView.bottomAnchor, constant: 6).active = true
        warrantyLable.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        warrantyLable.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
    }
    
    func addPackageInfo() {
        addSubview(packageTV)
        packageTV.translatesAutoresizingMaskIntoConstraints = false
        packageTV.topAnchor.constraintEqualToAnchor(warrantyLable.bottomAnchor).active = true
        packageTV.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        packageTV.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
    }
    
    func addSupplerTV() {
        addSubview(supplerInfoTV)
        supplerInfoTV.translatesAutoresizingMaskIntoConstraints = false
        supplerInfoTV.topAnchor.constraintEqualToAnchor(packageTV.bottomAnchor).active = true
        supplerInfoTV.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        supplerInfoTV.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
    }
    
    func addBrand() {
        addSubview(isBrand)
        isBrand.translatesAutoresizingMaskIntoConstraints = false
        isBrand.topAnchor.constraintEqualToAnchor(supplerInfoTV.bottomAnchor).active = true
        isBrand.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        isBrand.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTitle()
        addPriceTag()
        addDetailTag()
        addCommitmentView()
        addWarranty()
        addPackageInfo()
        addSupplerTV()
        addBrand()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

