//
//  NewProfileView.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 11.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import UIKit

class NewProfileView: UIView {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var ageInput: UITextField!
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var pickerView: AgePickerView!
    @IBOutlet var segmentedControlSex: UISegmentedControl!
    @IBOutlet var pictureButton: UIButton!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var saveProfile: UIBarButtonItem!
    @IBOutlet var dismiss: UIBarButtonItem!
}

