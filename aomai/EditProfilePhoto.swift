//
//  EditProfilePhoto.swift
//  aomai
//
//  Created by li qiang on 8/31/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import SnapKit

class EditProfilePhoto: UIViewController {
    var photoUrl: String?
    let lab = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        self.title = "PROFILE PHOTO"
        
        
        view.addSubview(lab)
        lab.text = photoUrl
        lab.textColor = UIColor.redColor()
        lab.snp_makeConstraints { (make) in
            make.centerX.equalTo(view.snp_centerX)
            make.centerY.equalTo(view.snp_centerY)
            make.height.equalTo(36)
            make.width.equalTo(200)
        }


    }

}
