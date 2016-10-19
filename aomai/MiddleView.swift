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

    let estimateDT: UITextView = {
        let lb = UITextView()
        lb.scrollEnabled = false
        lb.editable = false
        return lb
    }()
    
    let commitmentView = UIView()
    let swpView = UIView()
    
    let freeShippingLable: UILabel = {
        let lb = UILabel()
        lb.text = "·FREE SHIPPING"
        lb.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        return lb
    }()
    
    let cashOnDeliveryLable: UILabel = {
        let lb = UILabel()
        lb.text = "·CASH ON DELIVERY"
        lb.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        return lb
    }()
    
    let refundableLable: UILabel = {
        let lb = UILabel()
        lb.text = "·REFUNDABLE WITHIN 7 DAYS"
        lb.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        return lb
    }()
    
    let nonrefundableLable: UILabel = {
        let lb = UILabel()
        lb.text = "·NON-REFUNDABLE"
        lb.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
        return lb
    }()
    
    let warrantyLable: UILabel = {
        let lb = UILabel()
        lb.text = "WARRANTY: "
        lb.font = UIFont(name: "AppleSDGothicNeo-Light", size: 12)
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
    
    func estimatedDT() {
        addSubview(estimateDT)
        estimateDT.editable = false
        estimateDT.scrollEnabled = false
        //estimateDT.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0)
        estimateDT.translatesAutoresizingMaskIntoConstraints = false
        estimateDT.topAnchor.constraintEqualToAnchor(detailTag.bottomAnchor).active = true
        estimateDT.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        estimateDT.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        
    }
    
    func setUpCommitmentView() {
        commitmentView.addSubview(freeShippingLable)
        freeShippingLable.backgroundColor = UIColor.whiteColor()
        freeShippingLable.translatesAutoresizingMaskIntoConstraints = false
        freeShippingLable.topAnchor.constraintEqualToAnchor(commitmentView.topAnchor).active = true
        freeShippingLable.leftAnchor.constraintEqualToAnchor(commitmentView.leftAnchor, constant: 0).active = true
        freeShippingLable.rightAnchor.constraintEqualToAnchor(commitmentView.rightAnchor).active = true
        
        commitmentView.addSubview(cashOnDeliveryLable)
        cashOnDeliveryLable.backgroundColor = UIColor.whiteColor()
        cashOnDeliveryLable.translatesAutoresizingMaskIntoConstraints = false
        cashOnDeliveryLable.topAnchor.constraintEqualToAnchor(freeShippingLable.bottomAnchor).active = true
        cashOnDeliveryLable.leftAnchor.constraintEqualToAnchor(commitmentView.leftAnchor, constant: 0).active = true
        cashOnDeliveryLable.rightAnchor.constraintEqualToAnchor(commitmentView.rightAnchor).active = true
        
        commitmentView.addSubview(refundableLable)
        refundableLable.backgroundColor = UIColor.whiteColor()
        refundableLable.translatesAutoresizingMaskIntoConstraints = false
        refundableLable.topAnchor.constraintEqualToAnchor(cashOnDeliveryLable.bottomAnchor).active = true
        refundableLable.leftAnchor.constraintEqualToAnchor(commitmentView.leftAnchor, constant: 0).active = true
        refundableLable.rightAnchor.constraintEqualToAnchor(commitmentView.rightAnchor).active = true
        
        commitmentView.addSubview(nonrefundableLable)
        nonrefundableLable.backgroundColor = UIColor.whiteColor()
        nonrefundableLable.translatesAutoresizingMaskIntoConstraints = false
        nonrefundableLable.topAnchor.constraintEqualToAnchor(refundableLable.bottomAnchor).active = true
        nonrefundableLable.leftAnchor.constraintEqualToAnchor(commitmentView.leftAnchor, constant: 0).active = true
        nonrefundableLable.rightAnchor.constraintEqualToAnchor(commitmentView.rightAnchor).active = true
        
    }
    
    func setUpswpView() {
        swpView.addSubview(warrantyLable)
        warrantyLable.backgroundColor = UIColor.whiteColor()
        warrantyLable.translatesAutoresizingMaskIntoConstraints = false
        warrantyLable.topAnchor.constraintEqualToAnchor(swpView.topAnchor).active = true
        warrantyLable.leftAnchor.constraintEqualToAnchor(swpView.leftAnchor, constant: 0).active = true
        warrantyLable.rightAnchor.constraintEqualToAnchor(swpView.rightAnchor).active = true
    }
    
    func addCommitmentView() {
        setUpCommitmentView()
        addSubview(commitmentView)
        commitmentView.backgroundColor = UIColor.whiteColor()
        commitmentView.translatesAutoresizingMaskIntoConstraints = false
        commitmentView.topAnchor.constraintEqualToAnchor(detailTag.bottomAnchor, constant: 6).active = true
        commitmentView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        commitmentView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        commitmentView.heightAnchor.constraintEqualToConstant(80).active = true
        
    }
    
    func addswpView() {
        addSubview(swpView)
        setUpswpView()
        swpView.backgroundColor = UIColor.whiteColor()
        swpView.translatesAutoresizingMaskIntoConstraints = false
        swpView.topAnchor.constraintEqualToAnchor(commitmentView.bottomAnchor, constant: 6).active = true
        swpView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        swpView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        //swpView.heightAnchor.constraintEqualToConstant(100).active = true
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTitle()
        addPriceTag()
        addDetailTag()
        //estimatedDT()
        addCommitmentView()
        addswpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

