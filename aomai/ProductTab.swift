//
//  ProductTab.swift
//  aomai
//
//  Created by li qiang on 8/19/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProductTab: DancingShoesViewController {
    var CategoryList = [String]()
    var viewControllers = [CategoryProductView]()
    var tabs = [String]()
    let vc = CategoryProductView()
    let indicator = MyIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCategory()
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.widthAnchor.constraintEqualToConstant(42).active = true
        indicator.heightAnchor.constraintEqualToConstant(24).active = true
        indicator.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        indicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    func loadTabandVCs() {
        for cate in CategoryList {
            let vc = CategoryProductView(collectionViewLayout: UICollectionViewFlowLayout())
            //vc.topLayoutGuide.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 34)
            //vc.view.frame = CGRectMake(0, 100, self.view.frame.width, self.view.frame.height - 149)
            vc.category = cate
            self.viewControllers.append(vc)
            self.tabs.append(cate)
        }
        
        let slidingVC = SlidingContainerViewController(
            parent: self,
            contentViewControllers: viewControllers,
            titles: tabs
        )
        view.addSubview(slidingVC.view)
        slidingVC.sliderView.appearance.outerPadding = 0
        slidingVC.sliderView.appearance.innerPadding = 10
        slidingVC.setCurrentViewControllerAtIndex(0)
    }
    
    func loadCategory() {
        self.indicator.startAnimating()
        FIRDatabase.database().reference().child("ProductCategory").observeEventType(.Value, withBlock: { (snap) in
            for child in snap.children {
                guard let csnap = child as? FIRDataSnapshot else {return}
                let category = csnap.value as! String
                self.CategoryList.append(category)
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.loadTabandVCs()
                self.indicator.stopAnimating()
            })
            
        })
    }
    
    func slidingContainerViewControllerDidShowSliderView(slidingVC: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidHideSliderView(slidingVC: SlidingContainerViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewController(slidingVC: SlidingContainerViewController, viewController: UIViewController) {
        
    }
    
    func slidingContainerViewControllerDidMoveToViewControllerAtIndex(slidingVC: SlidingContainerViewController, index: Int) {
        
    }
    
    
}

//class ProductTab: DancingShoesViewController {
//    //var channels = [YMChannel]()
//    let kTitlesViewY: CGFloat = 0
//    let kTitlesViewH: CGFloat = 36
//    let kIndicatorViewH: CGFloat = 2.0
//    let kAnimationDuration = 0.25
//    let SCREENW = UIScreen.mainScreen().bounds.size.width
//    
//    var channels = [String]()
//    // 标签
//    weak var titlesView = UIView()
//    //底部红色指示器
//    weak var indicatorView = UIView()
//    
//    weak var contentView = UIScrollView()
//    /// 当前选中的按钮
//    weak var selectedButton = UIButton()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // 获取首页顶部选择数据
//        loadCategory()
//    }
//    
//    func loadTabandVCs() {
//        for cate in channels {
//            let vc = CategoryProductView(collectionViewLayout: UICollectionViewFlowLayout())
//            //vc.topLayoutGuide.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 34)
//            //vc.view.frame = CGRectMake(0, 100, self.view.frame.width, self.view.frame.height - 149)
//            vc.category = cate
//            self.addChildViewController(vc)
//            //self.viewControllers.append(vc)
//            //self.tabs.append(cate)
//        }
//        self.setupTitlesView()
//        self.setupContentView()
//    }
//    
//    func loadCategory() {
//        //self.indicator.startAnimating()
//        FIRDatabase.database().reference().child("ProductCategory").observeEventType(.Value, withBlock: { (snap) in
//            for child in snap.children {
//                guard let csnap = child as? FIRDataSnapshot else {return}
//                let category = csnap.value as! String
//                self.channels.append(category)
//            }
//            dispatch_async(dispatch_get_main_queue(), {
//                self.loadTabandVCs()
//                //self.indicator.stopAnimating()
//            })
//            
//        })
//    }
//    
//    func setupTitlesView() {
//        // 顶部背景
//        let bgView = UIView()
//        bgView.frame = CGRectMake(0, kTitlesViewY, SCREENW, kTitlesViewH)
//        view.addSubview(bgView)
//        // 标签
//        let titlesView = UIView()
//        titlesView.backgroundColor = YMGlobalColor()
//        titlesView.frame = CGRectMake(0, 0, SCREENW, kTitlesViewH)
//        bgView.addSubview(titlesView)
//        self.titlesView = titlesView
//        //底部红色指示器
//        let indicatorView = UIView()
//        indicatorView.backgroundColor = YMGlobalRedColor()
//        indicatorView.height = kIndicatorViewH
//        indicatorView.y = kTitlesViewH - kIndicatorViewH
//        indicatorView.tag = -1
//        self.indicatorView = indicatorView
//        
//        // 选择按钮
////        let arrowButton = UIButton()
////        arrowButton.frame = CGRectMake(SCREENW - kTitlesViewH, 0, kTitlesViewH, kTitlesViewH)
////        arrowButton.setImage(UIImage(named: "arrow_index_down_8x4_"), forState: .Normal)
////        arrowButton.addTarget(self, action: #selector(arrowButtonClick(_:)), forControlEvents: .TouchUpInside)
////        arrowButton.backgroundColor = YMGlobalColor()
////        bgView.addSubview(arrowButton)
//        
//        //内部子标签
//        let count = childViewControllers.count
//        let width = titlesView.width / CGFloat(count)
//        let height = titlesView.height
//        
//        for index in 0..<count {
//            let button = UIButton()
//            button.height = height
//            button.width = width
//            button.x = CGFloat(index) * width
//            button.tag = index
//            //let vc = childViewControllers[index]
//            button.titleLabel!.font = UIFont.systemFontOfSize(14)
//            button.setTitle(channels[index], forState: .Normal)
//            button.setTitleColor(UIColor.grayColor(), forState: .Normal)
//            button.setTitleColor(YMGlobalRedColor(), forState: .Disabled)
//            button.addTarget(self, action: #selector(titlesClick(_:)), forControlEvents: .TouchUpInside)
//            titlesView.addSubview(button)
//            //默认点击了第一个按钮
//            if index == 0 {
//                button.enabled = false
//                selectedButton = button
//                //让按钮内部的Label根据文字来计算内容
//                button.titleLabel?.sizeToFit()
//                indicatorView.width = button.titleLabel!.width
//                indicatorView.centerX = button.centerX
//            }
//        }
//        //底部红色指示器
//        titlesView.addSubview(indicatorView)
//    }
//    
//    /// 箭头按钮点击
////    func arrowButtonClick(button: UIButton) {
////        UIView.animateWithDuration(kAnimationDuration) {
////            button.imageView?.transform = CGAffineTransformRotate(button.imageView!.transform, CGFloat(M_PI))
////        }
////    }
//    
//    /// 标签上的按钮点击
//    func titlesClick(button: UIButton) {
//        // 修改按钮状态
//        selectedButton!.enabled = true
//        button.enabled = false
//        selectedButton = button
//        // 让标签执行动画
//        UIView.animateWithDuration(kAnimationDuration) {
//            self.indicatorView!.width = self.selectedButton!.titleLabel!.width
//            self.indicatorView!.centerX = self.selectedButton!.centerX
//        }
//        //滚动,切换子控制器
//        var offset = contentView!.contentOffset
//        offset.x = CGFloat(button.tag) * contentView!.width
//        contentView!.setContentOffset(offset, animated: true)
//    }
//    
//    /// 底部的scrollview
//    func setupContentView() {
//        //不要自动调整inset
//        automaticallyAdjustsScrollViewInsets = false
//        
//        let contentView = UIScrollView()
//        contentView.frame = view.bounds
//        contentView.delegate = self
//        contentView.contentSize = CGSizeMake(contentView.width * CGFloat(childViewControllers.count), 0)
//        contentView.pagingEnabled = true
//        view.insertSubview(contentView, atIndex: 0)
//        self.contentView = contentView
//        //添加第一个控制器的view
//        scrollViewDidEndScrollingAnimation(contentView)
//    }
//    
//    func YMGlobalRedColor() -> UIColor {
//        return YMColor(245, g: 80, b: 83, a: 1.0)
//    }
//    
//    func YMGlobalColor() -> UIColor {
//        return YMColor(240, g: 240, b: 240, a: 1)
//    }
//    
//    func YMColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
//        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
//    }
//    
//}
//
//
//extension ProductTab: UIScrollViewDelegate {
//    // MARK: - UIScrollViewDelegate
//    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
//        // 添加子控制器的 view
//        // 当前索引
//        let index = Int(scrollView.contentOffset.x / scrollView.width)
//        // 取出子控制器
//        let vc = childViewControllers[index]
//        vc.view.x = scrollView.contentOffset.x
//        vc.view.y = 0 // 设置控制器的y值为0(默认为20)
//        //设置控制器的view的height值为整个屏幕的高度（默认是比屏幕少20）
//        vc.view.height = scrollView.height
//        scrollView.addSubview(vc.view)
//    }
//    
//    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        scrollViewDidEndScrollingAnimation(scrollView)
//        // 当前索引
//        let index = Int(scrollView.contentOffset.x / scrollView.width)
//        // 点击 Button
//        let button = titlesView!.subviews[index] as! UIButton
//        titlesClick(button)
//    }
//}
