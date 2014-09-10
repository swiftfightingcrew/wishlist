//
//  WishlistDashboardViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit
import CoreData

class WishlistDashboardViewController: UITableViewController {
    
    var wishlistDashboardView:WishlistDashboardView!
    var wishlistArray: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistDashboardView = UIView.loadFromNibNamed("WishlistDashboardView") as WishlistDashboardView
        
        self.view = wishlistDashboardView
        
        wishlistDashboardView.newButton.addTarget(self, action: "newButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func newButtonTapped(sender: UIButton) {
        self.presentViewController(WishlistViewController(), animated: true, completion: nil)
    }
    
    func loadData() {
        wishlistArray.removeAllObjects()
        
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        let results:Array = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Wishlist), withPredicate: nil, managedObjectContext: moc)
        
    
        
        for wishlist in results {
            let singleWishlist:Wishlist = wishlist as Wishlist
            
            println(singleWishlist.id)
            println(singleWishlist.personId)
             println(singleWishlist.title)
            println(singleWishlist.letter)
            
            
            
            let wishlistDict:NSDictionary = ["id":singleWishlist.id, "personId":singleWishlist.personId, "title":singleWishlist.title, "letter":singleWishlist.letter, "productImage":singleWishlist.productImage]
            
            wishlistArray.addObject(wishlistDict)
        }
        self.tableView?.reloadData()
    }
    
    // MARK: - Table View Data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: - Table View Delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let wishlistDict:NSDictionary = wishlistArray.objectAtIndex(indexPath.row) as NSDictionary
        
        self.presentViewController(WishlistDashboardViewController(), animated: true, completion: nil)
    }
    
}
