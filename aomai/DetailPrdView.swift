//
//  DetailPrdView.swift
//  aomai
//
//  Created by li qiang on 9/26/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class DetailPrdView: DancingShoesViewController {
    
    var product: ShortProduct?
    var prdKey: String?
    let sW = UIScreen.mainScreen().bounds.width
    let sH = UIScreen.mainScreen().bounds.height
    
    private lazy var scrollView: DetailScrollView = {
        let scrollView = DetailScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        view.addSubview(scrollView)
        // 添加底部栏
        scrollView.product = product
        
        scrollView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(view)
        }
    
        
        scrollView.contentSize = CGSizeMake(sW, sH - 64 - 45 + 2 + 520)
    }
    
    

}

extension DetailPrdView: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y
        if offsetY >= 465 {
            offsetY = CGFloat(465)
            scrollView.contentOffset = CGPointMake(0, offsetY)
        }
    }
}

