//
//  EditProfileTableViewController.swift
//  aomai
//
//  Created by li qiang on 8/28/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditProfileTableViewController: UITableViewController {
    let cellID1 = "cellID1"
    let items = ["PROFILE PHOTO", "NAME", "PHONE NUMBER"]
    var userInfo = ["", "", "", ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 1))
        self.fetchUserInfo()
        self.title = "PROFILE"
        navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false


    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: cellID1)
        cell.textLabel?.font = UIFont(name: "ArialHebrew-Light", size: 14)
        cell.textLabel?.text = items[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "ArialHebrew-Light", size: 14)
        cell.detailTextLabel?.text = userInfo[indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .None
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let vc = EditProfilePhoto()
            vc.photoUrl = userInfo[3]
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            let vc = EidtUserName()
            vc.nameTF.text = userInfo[1]
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
            let vc = EditPhoneNumber()
            vc.phoneTF.text = userInfo[2]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func fetchUserInfo() {
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeEventType(.Value, withBlock: { (snap) in
            if let dict = snap.value as? [String: AnyObject] {
                if let uname = dict["name"] {
                    self.userInfo[1] = uname as! String
                }
                if let uPhone = dict["phone"] {
                    self.userInfo[2] = uPhone as! String
                }
                if let uUrl = dict["userAvatarUrl"] {
                    self.userInfo[3] = uUrl as! String
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
            }, withCancelBlock: nil)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
