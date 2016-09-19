//
//  MyIndicator.swift
//  aomai
//
//  Created by li qiang on 9/19/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//
import Foundation
import QuartzCore
import UIKit
class MyIndicator: UIView {
    
    let diameter = UIScreen.mainScreen().bounds.width / 53
    let gap: CGFloat = 2
    var numberOfCircles: Int = 4
    var animationDelay: Double = 0.2
    var defaultColor: UIColor = Tools.dancingShoesColor
    var isAnimating = false
    
    func startAnimating() {
        if !isAnimating {
            self.addCircles()
            isAnimating = true
        }
    }
    
    func addCircles() {
        for i in 0 ..< numberOfCircles {
            self.createCircleWithIndex(i)
        }
    }
    func createCircleWithIndex(index: Int) {
        let oX: CGFloat = CGFloat(index) * (diameter + gap) + gap + diameter / 2
        let oY: CGFloat = gap + diameter / 2
        let circle = UIView(frame: CGRectMake(oX, oY, diameter, diameter))
        circle.backgroundColor = defaultColor
        circle.layer.cornerRadius = diameter / 2
        circle.translatesAutoresizingMaskIntoConstraints = false
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.9
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.beginTime = CACurrentMediaTime() + Double(index) * animationDelay + 0.2
        animation.fromValue = NSValue(CGPoint: CGPointMake(circle.center.x, circle.center.y - 6))
        animation.toValue = NSValue(CGPoint: CGPointMake(circle.center.x, circle.center.y + 6))
        circle.layer.addAnimation(animation, forKey: "position")
        self.addSubview(circle)
    }
    
    func stopAnimating() {
        if isAnimating {
            isAnimating = false
            self.removeCircles()
        }
    }
    
    func removeCircles() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
}
}

