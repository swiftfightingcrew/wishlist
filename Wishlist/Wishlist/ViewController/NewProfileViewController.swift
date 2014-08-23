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
        var infoTextFrame = CGRectMake(0, y, CGRectGetWidth(self.view.frame), 60)
        var infoLabel = UiUtil.createLabel("erstelle hier dein neues Profil", myFrame: infoTextFrame)
        infoLabel.numberOfLines = 0 // mehrzeilig
        self.view.addSubview(infoLabel)
        
        y += CGRectGetHeight(infoLabel.frame) + yMargin
        
        // Picture Button
        var picButtonFrame: CGRect = CGRectMake(yMargin, y+20, CGRectGetWidth(self.view.frame) / 2, 40)
        var pictureButton = UiUtil.createButton("wähle ein Bild aus", myFrame: picButtonFrame, action: Selector ("capture:"), sender: self)
        self.view.addSubview(pictureButton)


        
        // Picture Image View
        pictureImageView = UIImageView(frame: CGRectMake(CGRectGetMaxX(pictureButton.frame) + yMargin, y, CGRectGetWidth(self.view.frame) / 2 - rightMargin * 2, 120))
        pictureImageView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(pictureImageView)
        
        y += CGRectGetHeight(pictureButton.frame) + yMargin
        
        // Picture Button
        var camButtonFrame: CGRect = CGRectMake(yMargin, y+20, CGRectGetWidth(self.view.frame) / 2, 40)
        var cameraButton = UiUtil.createButton("neues Foto", myFrame: camButtonFrame, action: Selector ("captureNew:"), sender: self)
        self.view.addSubview(cameraButton)
        
        y += CGRectGetHeight(cameraButton.frame) + yMargin * 2
        
        // Name Label
        var nameLabelFrame = CGRectMake(0, y, CGRectGetWidth(self.view.frame) - rightMargin, 40)
        var nameLabel = UiUtil.createLabel("Wie heißt du?", myFrame: nameLabelFrame)
        self.view.addSubview(nameLabel)
        
        y += CGRectGetHeight(nameLabel.frame)
        
        // Name Input
        var nameInput = UITextField (frame: CGRectMake(10, y, CGRectGetWidth(self.view.frame) - rightMargin, 40))
        nameInput.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(nameInput)
        
        y += CGRectGetHeight(nameLabel.frame) + yMargin

        // Sex Label
        var sexLabelFrame = CGRectMake(0, y, CGRectGetWidth(self.view.frame) - rightMargin, 40)
        var sexLabel = UiUtil.createLabel("Bist du ein Junge oder ein Mädchen?", myFrame: sexLabelFrame)
        self.view.addSubview(sexLabel)
      
        y += CGRectGetHeight(sexLabel.frame) + yMargin

        // Age Label
        var ageLabelFrame = CGRectMake(0, y, CGRectGetWidth(self.view.frame) - rightMargin, 40)
        var ageLabel = UiUtil.createLabel("Wie alt bist du?", myFrame: ageLabelFrame)
        self.view.addSubview(ageLabel)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // Versteckt die Statusbar
        return true
    }
    
    // MARK: - Actions
    func capture(sender: UIButton) {
        // Bild auswählen
        var imgViewController = UIImagePickerController()
        imgViewController.delegate = self
        imgViewController.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        
        self.presentViewController(imgViewController, animated: true, completion: nil)
    }

    func captureNew(sender: UIButton) {
        // neues Foto aufnehmen
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            println("too sad - no camera available :(")
            return
        }
        var imgViewController = UIImagePickerController()
        imgViewController.delegate = self
        imgViewController.sourceType = UIImagePickerControllerSourceType.Camera
        imgViewController.takePicture()
        println("taking a picture from the camera")
        self.presentViewController(imgViewController, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePicker Delegate
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        println("Show the captured image")
        self.dismissViewControllerAnimated(true, completion: nil)
        pictureImageView.image = info[UIImagePickerControllerOriginalImage] as UIImage
    }

}