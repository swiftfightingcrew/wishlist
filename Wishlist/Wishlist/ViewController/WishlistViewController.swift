//
//  WishlistViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WishlistViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, ITunesServiceDelegate {
    
    var wishlistView:WishlistView!
    var wishText = ""
    var iTunesService:ITunesService = ITunesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistView = UIView.loadFromNibNamed("WishlistView") as WishlistView
        self.view = wishlistView
        
        wishlistView.textView.delegate = self
        wishlistView.saveButton.addTarget(self, action: "saveWishlist:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // TODO: Target für SendButton (speichern & versenden)
        wishlistView.sendButton.addTarget(self, action: "sendWishlist:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        iTunesService.delegate = self
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // Versteckt die Statusbar
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        println(text)
        
        if text == " " {
            wishText = ""
        }
        
        wishText = wishText + text
        
        if countElements(wishText) > 5 {
            iTunesService.searchItunesFor(wishText)
        }
        
        return true
    }
    
    func didReceiveResults(results: NSArray) {
        //println("JSON Response: \(results)")
        
        if results.count > 0 {
            var resultDict: NSDictionary = results.objectAtIndex(0) as NSDictionary
            
            println(resultDict)
            
            var url:NSURL = NSURL.URLWithString(resultDict["artworkUrl100"] as String)
            var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
            wishlistView.imageView.image = UIImage(data: data)
            
        }
    }
    
    func saveWishlist(sender: UIButton) {
        
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        var wishlist: Wishlist = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Wishlist), managedObjectConect: moc) as Wishlist
        
        wishlist.id = "\(NSDate())"
        wishlist.letter = wishlistView.textView.text
        wishlist.title = wishlistView.titleText.text
        wishlist.personId = "123"
        if (wishlistView.imageView.image != nil) {
            wishlist.productImage = UIImagePNGRepresentation(wishlistView.imageView.image)
        }
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        println("Wishlist saved !!!")
    }
    
    func sendWishlist(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
