//
//  WishlistView.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//
import UIKit

class WishlistView: UIView {
    @IBOutlet var textView: UITextView!
    @IBOutlet var titleText: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet var itemCollectionView: UICollectionView!
    var imageView: UIImageView! = UIImageView(image: UIImage(named: "Geschenk_dummy"))
}
