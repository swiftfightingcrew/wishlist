//
//  NewProfileViewController.swift
//  Wishlist
//
//  Created by Henning David on 22.08.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var pictureImageView: UIImageView!
    var elements:Array<String>?
    var ageInput: UITextField = UITextField()
    var nameInput: UITextField = UITextField()
    var pickerView: AgePickerView!
    var segmentedControlSex: UISegmentedControl = UISegmentedControl()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        elements = []
        for index in 1...16 {
            elements!.append(String(index))
        }
        
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
        pictureImageView = UIImageView(frame: CGRectMake(CGRectGetMaxX(pictureButton.frame) + leftMargin, y, CGRectGetWidth(self.view.frame) / 2 - rightMargin*2, 120))
        pictureImageView.backgroundColor = UIColor.whiteColor()
        pictureImageView.image = UIImage(named: "dummy")
        self.view.addSubview(pictureImageView)
        
        y += CGRectGetHeight(pictureButton.frame) + yMargin
        
        // Picture Button
        var camButtonFrame: CGRect = CGRectMake(yMargin, y+20, CGRectGetWidth(self.view.frame) / 2, 40)
        var cameraButton = UiUtil.createButton("neues Foto", myFrame: camButtonFrame, action: Selector ("captureNew:"), sender: self)
        self.view.addSubview(cameraButton)
        
        y += CGRectGetHeight(cameraButton.frame) + yMargin * 2
        
        // Name Label
        var nameLabelFrame = CGRectMake(0, y, CGRectGetWidth(self.view.frame), 40)
        var nameLabel = UiUtil.createLabel("Wie heißt du?", myFrame: nameLabelFrame)
        self.view.addSubview(nameLabel)
        
        y += CGRectGetHeight(nameLabel.frame)
        
        // Name Input
        nameInput = UITextField (frame: CGRectMake(10, y, CGRectGetWidth(self.view.frame) - rightMargin, 40))
        nameInput.delegate = self
        nameInput.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(nameInput)
        
        y += CGRectGetHeight(nameLabel.frame) + yMargin

        // Sex Label
        var sexLabelFrame = CGRectMake(0, y, CGRectGetWidth(self.view.frame), 40)
        var sexLabel = UiUtil.createLabel("Bist du ein Junge oder ein Mädchen?", myFrame: sexLabelFrame)
        self.view.addSubview(sexLabel)
      
        y += CGRectGetHeight(sexLabel.frame) + yMargin

        // Auswahl Geschlecht (m/w)
        segmentedControlSex = UISegmentedControl(items: ["Junge","Mädchen"])
        segmentedControlSex.frame = CGRectMake(0, y, CGRectGetWidth(self.view.frame), 40)
        segmentedControlSex.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(segmentedControlSex)
        
        y += CGRectGetHeight(segmentedControlSex.frame) + yMargin
        
        // Age Label
        var ageLabelFrame = CGRectMake(0, y, CGRectGetWidth(self.view.frame), 40)
        var ageLabel = UiUtil.createLabel("Wie alt bist du?", myFrame: ageLabelFrame)
        self.view.addSubview(ageLabel)
        
        y += CGRectGetHeight(ageLabel.frame) + yMargin
        
        // Spinner Auswahl Alter
        ageInput = UITextField (frame: CGRectMake(10, y, CGRectGetWidth(self.view.frame) - rightMargin, 40))
        ageInput.tag = 2
        ageInput.delegate = self
        ageInput.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(ageInput)
        
        pickerView = UIView.loadFromNibNamed("AgePickerView") as AgePickerView
        pickerView.pickerView?.delegate = self
        pickerView.doneButton?.target = self
        pickerView.doneButton?.action = "done:"
        ageInput.inputView = pickerView
        
        y += CGRectGetHeight(ageInput.frame) + yMargin

        // Speichern Button
        var saveButtonFrame: CGRect = CGRectMake(yMargin, y, CGRectGetWidth(self.view.frame) / 2, 40)
        var saveButton = UiUtil.createButton("Speichern", myFrame: saveButtonFrame, action: Selector ("saveProfile:"), sender: self)
        self.view.addSubview(saveButton)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // Versteckt die Statusbar
        return true
    }
    
    // MARK: - Actions
    func valueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.backgroundColor = UIColor(red: 152/255.0, green: 245/255.0, blue: 255/255, alpha: 1.0)
        case 1:
            self.view.backgroundColor = UIColor(red: 255/255.0, green: 130/255.0, blue: 171/255.0, alpha: 1.0)
        default:
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
    
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
    
    func done(sender: UIButton) {
        ageInput.resignFirstResponder()
        var selectedRow = pickerView.pickerView?.selectedRowInComponent(0)
        var selectedValue = elements![selectedRow!]
        ageInput.text = selectedValue
    }

    func saveProfile(sender: UIButton) {
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()

        var person: Person = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Person), managedObjectConect: moc) as Person

        person.identifier = "\(NSDate())"
        person.firstName = nameInput.text
        person.age = ageInput.text
        person.gender = String(segmentedControlSex.selectedSegmentIndex)
        
        let personImageData: NSData = UIImagePNGRepresentation(pictureImageView.image)

        person.personImage = personImageData

        SwiftCoreDataHelper.saveManagedObjectContext(moc)

        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UIImagePicker Delegate
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        println("Show the captured image")
        self.dismissViewControllerAnimated(true, completion: nil)
        pictureImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    // MARK: - UITextFieldDelegate
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    // MARK: - UIPickerViewDelegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return elements![row]
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return elements!.count
    }
}

    //MARK: - Extensions
    extension UIView {
        class func loadFromNibNamed(nibNamed: String, bundle : NSBundle = NSBundle.mainBundle()) -> UIView! {
            return UINib(nibName: nibNamed, bundle: bundle).instantiateWithOwner(nil, options: nil)[0] as? UIView
        }
    }