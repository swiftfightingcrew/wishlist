//
//  NewProfileViewController.swift
//  Wishlist
//
//  Created by Henning David on 22.08.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//
import UIKit
import CoreData

class NewProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var newProfileView: NewProfileView!
    var elements:Array<String>?
    var pickerView: AgePickerView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.modalTransitionStyle = UIModalTransitionStyle.PartialCurl
        
        newProfileView = UIView.loadFromNibNamed("NewProfileView") as NewProfileView
        self.view = newProfileView
        newProfileView.ageInput.delegate = self
        newProfileView.nameInput.delegate = self
        
        pickerView = UIView.loadFromNibNamed("AgePickerView") as AgePickerView
        pickerView.pickerView?.delegate = self
        pickerView.doneButton?.target = self
        pickerView.doneButton?.action = "done:"
        newProfileView.ageInput.inputView = pickerView
        
        newProfileView.segmentedControlSex.addTarget(self, action: "valueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        newProfileView.pictureButton.addTarget(self, action: "capture:", forControlEvents: UIControlEvents.TouchUpInside)
        newProfileView.cameraButton.addTarget(self, action: "captureNew:", forControlEvents: UIControlEvents.TouchUpInside)
        newProfileView.saveProfile.action = "saveProfile:"
        newProfileView.dismiss.action = "dismiss:"

        elements = []
        for index in 1...16 {
            elements!.append(String(index))
        }
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
        newProfileView.ageInput.resignFirstResponder()
        var selectedRow = pickerView.pickerView?.selectedRowInComponent(0)
        var selectedValue = elements![selectedRow!]
        newProfileView.ageInput.text = selectedValue
    }
    
    func dismiss(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveProfile(sender: UIButton) {
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        var person: Person = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Person), managedObjectConect: moc) as Person
        
        let results:Array  =   SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Person), withPredicate: nil, managedObjectContext: moc)
        
        person.identifier = "\(results.count + 1)"
        person.firstName = newProfileView.nameInput.text
        person.age = newProfileView.ageInput.text
        person.gender = String(newProfileView.segmentedControlSex.selectedSegmentIndex)
        
        let personImageData: NSData = UIImagePNGRepresentation(newProfileView.pictureImageView.image)
        
        person.personImage = personImageData
        
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UIImagePicker Delegate
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        println("Show the captured image")
        self.dismissViewControllerAnimated(true, completion: nil)
        newProfileView.pictureImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
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