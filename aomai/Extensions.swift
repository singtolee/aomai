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

