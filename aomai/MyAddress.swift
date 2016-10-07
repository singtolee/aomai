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
    let addressType = ["CASH ON DELIVERY ADDRESS", "POST ADDRESS"]
    var mailingAddresses = [PostAddress]()
    var freeAddress = [FreeAddress]()
    let freeHeader = UIView()
    let postHeader = UIView()
    let cellID = "cellID"
    let indicator = MyIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectMake(0, 0, view.frame.size.width, 1))
        tableView.registerClass(AddressCell.self, forCellReuseIdentifier: cellID)
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        self.title = "ADDRESS"
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.widthAnchor.constraintEqualToConstant(42).active = true
        indicator.heightAnchor.constraintEqualToConstant(24).active = true
        indicator.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        indicator.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -40).active = true
        //self.indicator.center = view.center
        loadFreeAddress()
        loadMailingAddress()
    }
    
    func loadFreeAddress() {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            FIRDatabase.database().reference().child("FreeDeliveryAddresses").child(uid).observeEventType(.Value, withBlock: { (snap) in
                self.freeAddress.removeAll()
                if let dict = snap.value as? [String: String] {
                    let free = FreeAddress()
                    free.recipient = dict["recipient"]!
                    free.building = dict["officeBuilding"]!
                    free.phone = dict["phone"]!
                    free.room = dict["roomNumber"]!
                    self.freeAddress.append(free)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
                }, withCancelBlock: nil)
        }
        
    }
    func loadMailingAddress() {
        self.indicator.startAnimating()
        //self.mailingAddresses.removeAll()
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            FIRDatabase.database().reference().child("MailingAddresses").child(uid).observeEventType(.Value, withBlock: { (snap) in
                self.mailingAddresses.removeAll()
                for child in snap.children {
                    guard let csnap = child as? FIRDataSnapshot else {return}
                    if let dict = csnap.value as? [String: String] {
                        let address = PostAddress()
                        address.recipient = dict["recipient"]!
                        address.phone = dict["phone"]!
                        address.postCode = dict["PostCode"]!
                        address.detailAddress = dict["Address"]!
                        //address.ID = dict["ID"]!
                        address.ID = csnap.key
                        self.mailingAddresses.append(address)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                    self.indicator.stopAnimating()
                })
            })
        }
    }
    
    func setUpHeaderFree() -> UIView {
        let vw = UIView()
        vw.backgroundColor = Tools.headerColor
        let label = UILabel()
        label.text = self.addressType[0]
        label.font = UIFont(name: "ArialHebrew-Light", size: 14)
        let btn = UIButton()
        btn.setImage(UIImage(named: "editFreeAddress"), forState: .Normal)
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
        if self.freeAddress.count > 0{
            vc.officeAddress = self.freeAddress[0]
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    func addPost() {
        let vc = AddPostAddress()
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
        var rowNumber: Int
        if section == 0 {
            rowNumber = freeAddress.count
        }
        else {
            rowNumber = mailingAddresses.count
        }
        return rowNumber
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! AddressCell
        if indexPath.section == 0 {
            let add = freeAddress[indexPath.row]
            cell.textLabel?.text = add.recipient
            cell.textLabel?.font = UIFont(name: "ArialHebrew-Light", size: 14)
            cell.detailTextLabel?.font = UIFont(name: "ArialHebrew-Light", size: 14)
            cell.detailTextLabel?.text = add.room + ", " + add.building
            cell.phoneLable.text = add.phone
            cell.accessoryType = .DisclosureIndicator
            cell.selectionStyle = .None
        }
        else {
            let add = mailingAddresses[indexPath.row]
            cell.textLabel?.text = add.recipient
            cell.textLabel?.font = UIFont(name: "ArialHebrew-Light", size: 14)
            cell.detailTextLabel?.text = add.detailAddress + ", " + add.postCode
            cell.phoneLable.text = add.phone
            cell.detailTextLabel?.font = UIFont(name: "ArialHebrew-Light", size: 14)
            cell.accessoryType = .DisclosureIndicator
            cell.selectionStyle = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            let vc = EditPostAddress()
            vc.address = self.mailingAddresses[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let vc = EditFreeAddress()
            vc.officeAddress = self.freeAddress[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if editingStyle == .Delete {
                self.deleteAddressByID(mailingAddresses[indexPath.row].ID)
            }
        } else {
            if editingStyle == .Delete {
                self.deleteFreeAddress()
            }
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func deleteAddressByID(ID: String) {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            let ref = FIRDatabase.database().reference().child("MailingAddresses").child(uid).child(ID)
            ref.removeValue()
        }
    }
    
    func deleteFreeAddress() {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            let ref = FIRDatabase.database().reference().child("FreeDeliveryAddresses").child(uid)
            ref.removeValue()
        }
    }
}
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
