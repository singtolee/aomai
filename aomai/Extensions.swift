//
//  Extensions.swift
//  aomai
//
//  Created by li qiang on 9/3/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
let imageCache = NSCache()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        //check cache for image first
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            self.image = cachedImage
            //print("Cachefd Image")
            return
        }
        //cache is empty, download and save to cache
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                //TODO, report error elgently
                //print(error?.localizedDescription)
                self.image = UIImage(named: "placeholder48")
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString)
                    self.image = downloadedImage
                    //print("Downloaded Image")
                }
            })
        }).resume()
    }
    
    func loadUserAvatar(urlString: String) {
        
        //self.image = nil
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            self.image = cachedImage
            self.layer.cornerRadius = self.frame.size.width/2
            self.clipsToBounds = true
            return
        }
        //cache is empty, download and save to cache
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                //TODO, report error elgently
                self.image = UIImage(named: "whiteAva")
                self.layer.cornerRadius = self.frame.size.width/2
                self.clipsToBounds = true
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString)
                    self.image = downloadedImage
                    self.layer.cornerRadius = self.frame.size.width/2
                    self.clipsToBounds = true
                }
            })
        }).resume()
    }

}

extension UIView {
    
    /// 裁剪 view 的圆角
    func clipRectCorner(direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSizeMake(cornerRadius, cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.CGPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
}

