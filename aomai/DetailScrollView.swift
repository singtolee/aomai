//
//  DetailScrollView.swift
//  aomai
//
//  Created by li qiang on 9/27/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class DetailScrollView: UIScrollView {
    var product: ShortProduct? {
        didSet {
            topScrollView.product = product
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        
        addSubview(topScrollView)
        // 添加底部滚动视图
       // addSubview(bottomScrollView)
        
        topScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSizeMake(UIScreen.mainScreen().bounds.width, 520))
        }
        
//        bottomScrollView.snp_makeConstraints { (make) in
//            make.left.equalTo(self)
//            make.top.equalTo(topScrollView.snp_bottom).offset(kMargin)
//            make.size.equalTo(CGSizeMake(SCREENW, SCREENH - 64 - 45))
//        }
    }
    
    /// 顶部滚动视图
    private lazy var topScrollView: ProductDetailTopView = {
        let topScrollView = ProductDetailTopView()
        topScrollView.backgroundColor = UIColor.whiteColor()
        return topScrollView
    }()
    
    /// 底部滚动视图
//    private lazy var bottomScrollView: YMProductDetailBottomView = {
//        let bottomScrollView = YMProductDetailBottomView()
//        bottomScrollView.backgroundColor = UIColor.whiteColor()
//        return bottomScrollView
//    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
