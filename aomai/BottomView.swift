//
//  ListImage.swift
//  aomai
//
//  Created by li qiang on 10/20/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//
import UIKit
import SDWebImage

class BottomTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    let cellId = "cellId"
    var imageUrls = [String]()
    let imageTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageTableView)
        imageTableView.registerClass(BottomImagesCell.self, forCellReuseIdentifier: cellId)
        imageTableView.estimatedRowHeight = 400
        imageTableView.rowHeight = UITableViewAutomaticDimension
        imageTableView.dataSource = self
        imageTableView.delegate = self
        imageTableView.translatesAutoresizingMaskIntoConstraints = false
        imageTableView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
        imageTableView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
        imageTableView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
        imageTableView.bottomAnchor.constraintEqualToAnchor(self.bottomAnchor).active = true
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageUrls.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! BottomImagesCell
        let url = imageUrls[indexPath.item]
        if let imageUrl = NSURL(string: url) {
            cell.img.sd_setImageWithURL(imageUrl, placeholderImage: UIImage(named: "placeholder48"))

        }
        return cell
    }
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return imageTableView.frame.width
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

