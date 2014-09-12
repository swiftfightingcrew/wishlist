//
//  WishlistDashboardViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit
import CoreData

class WishlistDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var wishlistDashboardView: WishlistDashboardView!
    var wishlistArray: NSMutableArray = NSMutableArray()
    var personID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistDashboardView = UIView.loadFromNibNamed("WishlistDashboardView") as WishlistDashboardView
        self.view = wishlistDashboardView
        
        wishlistDashboardView.tableView.delegate = self
        wishlistDashboardView.tableView.dataSource = self
        
        wishlistDashboardView.newButton.addTarget(self, action: "newButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        wishlistDashboardView.dismiss.action = "dismiss:"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        // Versteckt die Statusbar
        return true
    }
    
    func newButtonTapped(sender: UIButton) {
        let wishlistViewController: WishlistViewController = WishlistViewController()
        wishlistViewController.personID = personID
        self.presentViewController(wishlistViewController, animated: true, completion: nil)
    }
    
    func dismiss(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadData() {
        wishlistArray.removeAllObjects()
        
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        println(personID)
        let string = personID!
        let results:Array = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Wishlist), withPredicate: NSPredicate(format: "personId == '\(string)'"), managedObjectContext: moc)
        
        for wishlist in results {
            let singleWishlist:Wishlist = wishlist as Wishlist
            
            println("------------------------")
            println("Titel: \(singleWishlist.title)")
            println("Letter: \(singleWishlist.letter)")
            println("PersonID: \(singleWishlist.personId)")
            println("ObjectID: \(singleWishlist.objectID.URIRepresentation().absoluteString)")
            println("------------------------")
            
            
            let wishlistDict:NSDictionary = ["id":singleWishlist.id, "personId":singleWishlist.personId, "title":singleWishlist.title, "letter":singleWishlist.letter, "productImage":singleWishlist.productImage]
            
            wishlistArray.addObject(wishlistDict)
        }
        wishlistDashboardView.tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        }
        
        let wishlistDict:NSDictionary = wishlistArray.objectAtIndex(indexPath.row) as NSDictionary
        
        cell?.textLabel?.text = wishlistDict["title"] as? String
        cell?.detailTextLabel?.text = wishlistDict["letter"] as? String
        
        let imageData:NSData = wishlistDict["productImage"] as NSData
        cell?.imageView?.image = UIImage(data: imageData)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Deine Wunschzettel"
    }
    
    //MARK: - Table View Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let wishlistDict:NSDictionary = wishlistArray.objectAtIndex(indexPath.row) as NSDictionary
        
        let wishlistViewController: WishlistViewController = WishlistViewController()
        wishlistViewController.savedWishlistDict = wishlistDict
        wishlistViewController.personID = personID
        
        self.presentViewController(wishlistViewController, animated: true, completion: nil)
    }
    
}
