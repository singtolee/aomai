//
//  EditProfilePhoto.swift
//  aomai
//
//  Created by li qiang on 8/31/2559 BE.
//  Copyright © 2559 aomai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SnapKit
import SVProgressHUD

class EditProfilePhoto: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let avatarImageView = UIImageView()
    let placeHolder = UIImage(named: "placeholder48")

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "fromAlbum"), style: .Plain, target: self, action: #selector(openAlbum))
        view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = Tools.dancingShoesColor
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = false
        self.title = "PROFILE PHOTO"
        self.setUpAvatarView()
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEventOfType(.Value, withBlock: { (snap) in
            if let dict = snap.value as? [String: AnyObject] {
                if let uUrl = dict["userAvatarUrl"] {
                    let url = NSURL(string: uUrl as! String)
                    let imageCache = NSCache()
                    if let cachedImage = imageCache.objectForKey(url!) as? UIImage {
                        self.avatarImageView.image = cachedImage
                        self.avatarImageView.contentMode = .ScaleAspectFit
                        return
                    }
                    NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                        if error != nil {
                            print(error?.localizedDescription)
                            self.avatarImageView.image = self.placeHolder
                            self.avatarImageView.contentMode = .ScaleAspectFit
                            return
                        }
                        dispatch_async(dispatch_get_main_queue(), {
                            if let downloadedImage = UIImage(data: data!) {
                                imageCache.setObject(downloadedImage, forKey: url!)
                                self.avatarImageView.image = downloadedImage
                                self.avatarImageView.contentMode = .ScaleAspectFit
                            }
                        })
                    }).resume()
                    
                } else {
                    self.avatarImageView.image = self.placeHolder
                    self.avatarImageView.contentMode = .ScaleAspectFit
                }
            } else {
                self.avatarImageView.image = self.placeHolder
                self.avatarImageView.contentMode = .ScaleAspectFit
            }
        }, withCancelBlock: nil)
        
        
    }
    
    func setUpAvatarView() {
        view.addSubview(avatarImageView)
        avatarImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(view.snp_centerY).offset(-25)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.height.equalTo(view.frame.width)
        }
        self.avatarImageView.image = self.placeHolder
        self.avatarImageView.contentMode = .ScaleAspectFit
        
    }
    
    func openAlbum() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            self.avatarImageView.image = selectedImage
            //self.avatarImageView.layer.cornerRadius = self.chooesAvatarImageView.frame.size.width/2
            //self.avatarImageView.clipsToBounds = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        self.onRegisterBtnClicked()
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onRegisterBtnClicked() {
        //register account and upload user avatar
        //show registering spin and stop when registration success
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.Dark)
        SVProgressHUD.showWithStatus("Uploading...")
        let uid = FIRAuth.auth()?.currentUser?.uid
        //let imageName = NSUUID().UUIDString
        let storeageRef = FIRStorage.storage().reference().child("USERPROFILEPHOTO").child("\(uid!).png")
        if let uploadData = UIImageJPEGRepresentation(self.avatarImageView.image!, 0.2){
            storeageRef.putData(uploadData, metadata: nil, completion: {(metadata, error) in
                if error != nil {
                    SVProgressHUD.dismiss()
                    let failedUploadingAvatarAlert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    let ok1Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(_: UIAlertAction) -> Void in }
                    failedUploadingAvatarAlert.addAction(ok1Action)
                    self.presentViewController(failedUploadingAvatarAlert, animated: true, completion: nil)
                    return
                }
                if let avatarUrl = metadata?.downloadURL()?.absoluteString{
                    let values = ["userAvatarUrl": avatarUrl]
                    //Tools.registerUserIntoDatabaseWithUID(uid!, values: values)
                    let ref = FIRDatabase.database().reference().child("users").child(uid!)
                    ref.updateChildValues(values, withCompletionBlock: {(err, ref) in
                        if err != nil {
                            let failedWriteDatabaseAlert = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                            let ok2Action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {(_: UIAlertAction) -> Void in }
                            failedWriteDatabaseAlert.addAction(ok2Action)
                            self.presentViewController(failedWriteDatabaseAlert, animated: true, completion: nil)
                            SVProgressHUD.dismiss()
                            return
                        }
                        SVProgressHUD.dismiss()
                    })
                    
                }
            })
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
