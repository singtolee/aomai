//
//  AddressCell.swift
//  aomai
//
//  Created by li qiang on 10/16/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
class AddressCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRectMake(textLabel!.frame.origin.x, textLabel!.frame.origin.y - 4, self.frame.width - 140, textLabel!.frame.height)
        detailTextLabel?.frame = CGRectMake(detailTextLabel!.frame.origin.x, detailTextLabel!.frame.origin.y + 4, detailTextLabel!.frame.width, detailTextLabel!.frame.height)
        phoneLable.frame = CGRectMake(self.frame.width - 120, textLabel!.frame.origin.y - 4, 70, textLabel!.frame.height)
    }
    
    let phoneLable: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.font = UIFont(name: "ArialHebrew-Light", size: 14)
        return lab
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
        addSubview(phoneLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
