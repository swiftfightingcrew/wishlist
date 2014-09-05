//
//  PersonTableViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 04.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit
import CoreData

class PersonTableViewController: UITableViewController {
    var personArray: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }
    
    func loadData() {
        personArray.removeAllObjects()
        
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        
        let results:Array = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Person), withPredicate: nil, managedObjectContext: moc)
        
        for person in results {
            let singlePerson:Person = person as Person
            
            let personDict:NSDictionary = ["identifier":singlePerson.identifier, "firstName":singlePerson.firstName, "age":singlePerson.age, "gender":singlePerson.gender, "personImage":singlePerson.personImage]
            
            personArray.addObject(personDict)
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell") as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        }
        
        let personDict:NSDictionary = personArray.objectAtIndex(indexPath.row) as NSDictionary
        
        cell?.textLabel?.text = personDict["firstName"] as? String
        cell?.detailTextLabel?.text = personDict["age"] as? String
        
        let imageData:NSData = personDict["personImage"] as NSData
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
        let personDict:NSDictionary = personArray.objectAtIndex(indexPath.row) as NSDictionary
        
        self.presentViewController(WishlistDashboardViewController(), animated: true, completion: nil)
    }
}
