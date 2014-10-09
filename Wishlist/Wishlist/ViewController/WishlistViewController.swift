//
//  WishlistViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit
import CoreData

class WishlistViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, NSXMLParserDelegate {
    
    var wishlistView:WishlistView!
    var wishText = ""
    var personID: String?
    var name: String?
    var savedWishlistDict: NSDictionary?
    var index: Int = 0
    var isInItem: Bool = false
    var isLargeImage: Bool = false
    var presentTableViewManager: PresentTableViewManager = PresentTableViewManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistView = NibLoader.loadFromNibNamed("WishlistView") as WishlistView
        self.view = wishlistView
        
        wishlistView.textView.delegate = self
        wishlistView.saveButton.addTarget(self, action: "saveWishlist:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // TODO: Target für SendButton (speichern & versenden)
        wishlistView.sendButton.addTarget(self, action: "sendWishlist:", forControlEvents: UIControlEvents.TouchUpInside)
        
        if var dict = savedWishlistDict {
            println(savedWishlistDict)
            
            wishlistView.titleText.text = dict["title"] as String
            wishlistView.imageView.image = UIImage(data: (dict["productImage"] as NSData))
            wishlistView.textView.text = dict["letter"] as String
        }
        
        setGreetingLabel()
        
        self.addChildViewController(presentTableViewManager)
        wishlistView.containerView.addSubview(presentTableViewManager.view)
        presentTableViewManager.didMoveToParentViewController(self)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // Versteckt die Statusbar
        return true
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
    func setGreetingLabel() {
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        println(personID!)
        let results:NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Person), withPredicate: NSPredicate(format: "identifier == '\(personID!)'"), managedObjectContext: moc)
        println(results)
        if results.count > 0 {
            var person: Person = results.lastObject as Person
            println(person.identifier)
            wishlistView.greetingLabel.text = "Was wünscht du dir \(person.firstName)?"
        }
    }
}
