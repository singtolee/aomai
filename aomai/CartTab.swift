//
//  cartTabViewController.swift
//  aomai
//
//  Created by li qiang on 7/14/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit

class CartTab: UIViewController,UIScrollViewDelegate {
    
    //let v1 = UIView(frame: CGRectMake(0, 0, 300, 200))
    let v1 = UIView()
    let v2 = UITextView()
    let v3 = UITextView()
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        addScrollView()
        addV1()
        addV2()
        addV3()
//        let y = CGRectGetMaxY(v2.frame)
//        scrollView.contentSize = CGSize(width: view.bounds.width, height: y + 113)
//        print(y)
        
    }
    
    
    func addScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = UIColor.whiteColor()
        //scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 2.3)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        scrollView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        scrollView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        scrollView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -49).active = true
    }
    
    func addV1() {
        scrollView.addSubview(v1)
        v1.backgroundColor = Tools.dancingShoesColor
        v1.translatesAutoresizingMaskIntoConstraints = false
        v1.topAnchor.constraintEqualToAnchor(scrollView.topAnchor).active = true
        v1.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        v1.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        v1.heightAnchor.constraintEqualToConstant(213).active = true
    }
    func addV2() {
        scrollView.addSubview(v2)
        v2.scrollEnabled = false
        v2.editable = false
        v2.text = "大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启"
        v2.backgroundColor = UIColor.whiteColor()
        v2.translatesAutoresizingMaskIntoConstraints = false
        v2.topAnchor.constraintEqualToAnchor(v1.bottomAnchor).active = true
        v2.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        v2.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
    }
    
    func addV3() {
        scrollView.addSubview(v3)
        v3.scrollEnabled = false
        v3.editable = false
        v3.text = "的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启动盘做到人人都会U盘装系统! U盘制作成功率几乎高达100%,试验过上百种U盘,目前没有遇到一例失败. U盘的启动文件,是大白菜小组精心优化的系统,大白菜超级U盘启"
        v3.backgroundColor = UIColor.brownColor()
        v3.translatesAutoresizingMaskIntoConstraints = false
        v3.topAnchor.constraintEqualToAnchor(v2.bottomAnchor).active = true
        v3.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        v3.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let y = CGRectGetMaxY(v3.frame)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: y)
        print(y)
        
    }


}
