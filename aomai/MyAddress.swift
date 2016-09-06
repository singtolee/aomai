//
//  address.swift
//  aomai
//
//  Created by li qiang on 8/1/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SnapKit

class MyAddress: UITableViewController {
    let addressType = ["Free Delivery Address", "Mailing Address"]
    let free = ["aa", "bb"]
    var mailingAddresses = [PostAddress]()
    //let post = ["cc", "dd", "ee", "ff"]
    let freeHeader = UIView()
    let postHeader = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        self.title = "ADDRESS"
        loadMailingAddress()
    }
    func loadFreeAddress() {
        
    }
    func loadMailingAddress() {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            FIRDatabase.database().reference().child("MailingAddresses").child(uid).observeEventType(.ChildAdded, withBlock: { (snap) in
                if let dict = snap.value as? [String: AnyObject] {
                    let address = PostAddress()
                    address.recipient = dict["recipient"] as! String
                    address.phone = dict["phone"] as! String
                    address.postCode = dict["PostCode"] as! String
                    address.detailAddress = dict["Address"] as! String
                    address.defaultAddress = dict["defaultAddress"] as! Bool
                    self.mailingAddresses.append(address)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
                }, withCancelBlock: nil)
        }
    }
    
    func setUpHeaderFree() -> UIView {
        let vw = UIView()
        vw.backgroundColor = Tools.headerColor
        let label = UILabel()
        label.text = self.addressType[0]
        label.font = UIFont(name: "ArialHebrew-Light", size: 14)
        let btn = UIButton()
        btn.setImage(UIImage(named: "addNewAddress"), forState: .Normal)
        btn.addTarget(self, action: #selector(addFree), forControlEvents: .TouchUpInside)
        vw.addSubview(label)
        vw.addSubview(btn)
        label.translatesAutoresizingMaskIntoConstraints = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraintEqualToAnchor(vw.leftAnchor, constant: 12).active = true
        label.centerYAnchor.constraintEqualToAnchor(vw.centerYAnchor).active = true
        btn.rightAnchor.constraintEqualToAnchor(vw.rightAnchor).active = true
        btn.widthAnchor.constraintEqualToConstant(60).active = true
        btn.backgroundColor = Tools.headerColor
        btn.centerYAnchor.constraintEqualToAnchor(vw.centerYAnchor).active = true
        return vw
    }
    func setUpHeaderPost() -> UIView {
        let vw = UIView()
        vw.backgroundColor = Tools.headerColor
        let label = UILabel()
        label.text = self.addressType[1]
        label.font = UIFont(name: "ArialHebrew-Light", size: 14)
        let btn = UIButton()
        //btn.setTitle("ADD", forState: .Normal)
        btn.setImage(UIImage(named: "addNewAddress"), forState: .Normal)
        btn.addTarget(self, action: #selector(addPost), forControlEvents: .TouchUpInside)
        vw.addSubview(label)
        vw.addSubview(btn)
        label.translatesAutoresizingMaskIntoConstraints = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraintEqualToAnchor(vw.leftAnchor, constant: 12).active = true
        label.centerYAnchor.constraintEqualToAnchor(vw.centerYAnchor).active = true
        btn.rightAnchor.constraintEqualToAnchor(vw.rightAnchor).active = true
        btn.widthAnchor.constraintEqualToConstant(60).active = true
        btn.backgroundColor = Tools.headerColor
        btn.centerYAnchor.constraintEqualToAnchor(vw.centerYAnchor).active = true
        return vw
    }
    
    func addFree() {
        let vc = EditFreeAddress()
        vc.title = "Add Address"
        navigationController?.pushViewController(vc, animated: true)
    }
    func addPost() {
        let vc = EditPostAddress()
        vc.title = "Add Mailing Address"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return self.setUpHeaderFree()
            
        } else {
            return self.setUpHeaderPost()
        }
    }
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return addressType.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cc: Int
        if section == 0 {
        cc = free.count}
        else {
        cc = mailingAddresses.count}
        return cc
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath)
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cellID")
        if indexPath.section == 0 {
            cell.textLabel?.text = self.free[indexPath.row]
        }
        else {
            cell.textLabel?.text = self.mailingAddresses[indexPath.row].detailAddress
            //cell.detailTextLabel?.text = self.mailingAddresses[indexPath.row].detailAddress
        }
        
        return cell
    }

}