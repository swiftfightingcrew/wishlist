//
//  WishlistViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit
import CoreData

class WishlistViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, ITunesServiceDelegate, UICollectionViewDataSource, UICollectionViewDelegate, NSXMLParserDelegate {
    
    var wishlistView:WishlistView!
    var wishText = ""
    var iTunesService:ITunesService = ITunesService()
    var personID: String?
    var name: String?
    var savedWishlistDict: NSDictionary?
    var results: NSArray?
    var imageResults: [String] = Array()
    var index: Int = 0
    var isInItem: Bool = false
    var isLargeImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistView = UIView.loadFromNibNamed("WishlistView") as WishlistView
        self.view = wishlistView
        
        wishlistView.textView.delegate = self
        wishlistView.saveButton.addTarget(self, action: "saveWishlist:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(90, 90)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        wishlistView.itemCollectionView.collectionViewLayout = layout
        wishlistView.itemCollectionView.delegate = self
        wishlistView.itemCollectionView.dataSource = self
        wishlistView.itemCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        wishlistView.itemCollectionView.backgroundColor = UIColor.clearColor()
        
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
        
        // Amazon URL Request
        let url = NSURL(string: "http://172.21.24.112:8080/AmazonRestWebservice/resources/search?keyword=Barbie")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            var xmlParser = NSXMLParser(data: data)
            xmlParser.delegate = self
            xmlParser.parse()
            
            println("\(self.imageResults)")
            self.wishlistView.itemCollectionView.reloadData()
        }
        task.resume()
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
        var countElement = countElements(wishText)
        if  countElement > 5 {
            iTunesService.searchItunesFor(wishText)
        }
        
        return true
    }
    
    func didReceiveResults(results: NSArray) {
        println(results)
        
        if results.count > 0 {
            self.results = results
            wishlistView.itemCollectionView.reloadData()
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
    
    //MARK - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        var imageView: UIImageView = UIImageView(frame: CGRectMake(0, 15.5, 90, 90))
        
        println("imageView: \(imageView)")
        println("cell: \(cell)")
        
        cell.addSubview(imageView)
        
        var url:NSURL = NSURL(string: imageResults[indexPath.row])
        var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
        imageView.image = UIImage(data: data)
        
//        if var array = self.results {
//            println(indexPath.row)
//            println(self.results?.count)
//            var resultDict: NSDictionary = array.objectAtIndex(indexPath.row) as NSDictionary
//            
//            var url:NSURL = NSURL.URLWithString(resultDict["artworkUrl60"] as String)
//            var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
//            imageView.image = UIImage(data: data)
//        } else {
//            imageView.image = UIImage(named: "Geschenk_dummy")
//            println(indexPath.row)
//        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageResults.count
    }
    
    //MARK - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Item selected - index: \(indexPath.row)")
        let activeCell = wishlistView.itemCollectionView.cellForItemAtIndexPath(indexPath)!
        let activeColor = UIColor.lightGrayColor()
        activeCell.backgroundColor = activeCell.backgroundColor == activeColor ? UIColor.clearColor() : activeColor
    }
    
    //MARK - XMLParserDelegate
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        if (elementName == "MediumImage" && !isInItem) {
            isInItem = true
            isLargeImage = true
            //var value = attributeDict["LargeImage"] as String
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String!, qualifiedName qName: String!) {
        if elementName == "Item" {
            isInItem = false
        } else if elementName == "URL" {
            isLargeImage = false
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if isLargeImage {
            imageResults.append(string)
        }
    }
}
