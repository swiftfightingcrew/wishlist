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
    var personID: String?
    var name: String?
    var savedWishlistDict: NSDictionary?
    var results: NSArray?
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistView = UIView.loadFromNibNamed("WishlistView") as WishlistView
        self.view = wishlistView
        
        wishlistView.textView.delegate = self
        wishlistView.saveButton.addTarget(self, action: "saveWishlist:", forControlEvents: UIControlEvents.TouchUpInside)
        wishlistView.nextArrowButton.addTarget(self, action: "nextPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        wishlistView.previousArrowButton.addTarget(self, action: "previousPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // TODO: Target für SendButton (speichern & versenden)
        wishlistView.sendButton.addTarget(self, action: "sendWishlist:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        iTunesService.delegate = self
        
        if var dict = savedWishlistDict {
            println(savedWishlistDict)
            
            wishlistView.titleText.text = dict["title"] as String
            wishlistView.imageView.image = UIImage(data: (dict["productImage"] as NSData))
            wishlistView.textView.text = dict["letter"] as String
        }
        
        setGreetingLabel()
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
        println(results)
        
        if results.count > 0 {
            self.results = results
            showPresentsAtIndex()
        }
    }
    
    func saveWishlist(sender: UIButton) {
        
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        var wishlist: Wishlist
        
        if var dict = savedWishlistDict {
            let string = personID!
            let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Wishlist), withPredicate: NSPredicate(format: "personId == '\(string)'"), managedObjectContext: moc)
            wishlist = results.lastObject as Wishlist
        } else {
            wishlist = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Wishlist), managedObjectConect: moc) as Wishlist
        }
        
        wishlist.id = wishlist.objectID.URIRepresentation().absoluteString!
        wishlist.letter = wishlistView.textView.text
        wishlist.title = wishlistView.titleText.text
        wishlist.personId = personID!
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
    
    // MARK - Actions
    func showPresentsAtIndex() {
        if var array = self.results {
            var resultDict: NSDictionary = array.objectAtIndex(index) as NSDictionary
            
            var url:NSURL = NSURL.URLWithString(resultDict["artworkUrl60"] as String)
            var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
            wishlistView.imageView.image = UIImage(data: data)
        } else {
            
        }
    }
    
    func nextPressed(sender: UIButton) {
        ++index
        
        if var array = results {
            if index > array.count {
                index = array.count
            }
        }
        
        showPresentsAtIndex()
    }
    
    func previousPressed(sender: UIButton) {
        --index
        if index < 0 {
            index = 0
        }
        showPresentsAtIndex()
    }
    
    func setGreetingLabel() {
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        let string = personID!
        println(string)
        let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Person), withPredicate: NSPredicate(format: "identifier == '\(string)'"), managedObjectContext: moc)
        println(results)
        if results.count > 0 {
            var person: Person = results.lastObject as Person
            wishlistView.greetingLabel.text = "Was wünscht du dir \(person.firstName)"
        }
    }
}
