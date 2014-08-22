//
//  NewProfileViewController.swift
//  Wishlist
//
//  Created by Henning David on 22.08.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import UIKit

class NewProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var pictureImageView: UIImageView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        self.setupScreen()
    }
    
    func setupScreen() {
        var y: CGFloat = 0
        var yMargin: CGFloat = 15
        
        // Info Text
        var infoLabel = UILabel (frame: CGRectMake(0, y, CGRectGetWidth(self.view.frame), 120))
        infoLabel.text = "erstelle hier dein neues Profil"
        infoLabel.font = UIFont(name: "Chalkduster", size: 14)
        infoLabel.backgroundColor = UIColor.clearColor()
        infoLabel.textAlignment = .Center
        infoLabel.numberOfLines = 0 // mehrzeilig
        self.view.addSubview(infoLabel)
        
        y += CGRectGetHeight(infoLabel.frame) + yMargin
        
        // Picture Button
        var picButtonFrame: CGRect = CGRectMake(10, y+20, CGRectGetWidth(self.view.frame) / 2, 40)
        var pictureButton = UiUtil.createButton("Bild auswählen", myFrame: picButtonFrame)
        self.view.addSubview(pictureButton)
        pictureButton.addTarget(self, action: "capture:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Picture Image View
        pictureImageView = UIImageView(frame: CGRectMake(CGRectGetMaxX(pictureButton.frame) + yMargin, y, CGRectGetWidth(self.view.frame) / 2 - 30, 80))
        pictureImageView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(pictureImageView)
    }
    
    
    // MARK: - Actions
    func capture(sender: UIButton) {
        // Bild auswählen
        var imgViewController = UIImagePickerController()
        imgViewController.delegate = self
        imgViewController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imgViewController, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePicker Delegate
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        println("Picking an image from gallery")
        self.dismissViewControllerAnimated(true, completion: nil)
        pictureImageView.image = info[UIImagePickerControllerOriginalImage] as UIImage
    }

}