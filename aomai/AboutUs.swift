//
//  AboutUs.swift
//  aomai
//
//  Created by li qiang on 8/16/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class AboutUs: UIViewController {
    
    var scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
    var v = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Return", style: .Plain, target: self, action: #selector(dismissVC))
        scrollView.backgroundColor = UIColor.whiteColor()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height*1.2)
        view.addSubview(scrollView)
        v.backgroundColor = UIColor.greenColor()
        scrollView.addSubview(v)
        v.snp_makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(200)
            make.left.equalTo(scrollView).offset(10)
            make.size.equalTo(100)
        }
        //scrollView.addSubview(v)
        scrollView.contentOffset = CGPoint(x: 0, y: 200)

        
    }
    
    func dismissVC() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
