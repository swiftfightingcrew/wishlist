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
        var leftMargin: CGFloat = 10
        var rightMargin: CGFloat = 20
        
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
        var picButtonFrame: CGRect = CGRectMake(yMargin, y+20, CGRectGetWidth(self.view.frame) / 2, 40)
        var pictureButton = UiUtil.createButton("wähle ein Bild aus", myFrame: picButtonFrame)
        self.view.addSubview(pictureButton)
        pictureButton.addTarget(self, action: "capture:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Picture Image View
        pictureImageView = UIImageView(frame: CGRectMake(CGRectGetMaxX(pictureButton.frame) + yMargin, y, CGRectGetWidth(self.view.frame) / 2 - rightMargin, 80))
        pictureImageView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(pictureImageView)
        
        y += CGRectGetHeight(pictureImageView.frame) + yMargin
        
        // Name Label
        var nameLabel = UILabel (frame: CGRectMake(0, y, CGRectGetWidth(self.view.frame) - rightMargin, 40))
        nameLabel.text = "Wie heißt du?"
        nameLabel.font = UIFont(name: "Chalkduster", size: 14)
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.textAlignment = .Center
        self.view.addSubview(nameLabel)
        
        y += CGRectGetHeight(nameLabel.frame)
        
        // Name Input
        var nameInput = UITextField (frame: CGRectMake(10, y, CGRectGetWidth(self.view.frame) - rightMargin, 40))
        nameInput.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(nameInput)
        
        y += CGRectGetHeight(nameLabel.frame) + yMargin

        // Age Label
        var ageLabel = UILabel (frame: CGRectMake(0, y, CGRectGetWidth(self.view.frame) - rightMargin, 40))
        ageLabel.text = "Wie alt bist du?"
        ageLabel.font = UIFont(name: "Chalkduster", size: 14)
        ageLabel.backgroundColor = UIColor.clearColor()
        ageLabel.textAlignment = .Center
        self.view.addSubview(ageLabel)

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