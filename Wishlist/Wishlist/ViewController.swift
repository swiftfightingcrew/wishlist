//
//  ViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.08.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var personArray: NSMutableArray = NSMutableArray()
    var dashboardView: DashboardView!
    
    // MARK: - Meine Methoden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardView = NibLoader.loadFromNibNamed("DashboardView") as DashboardView
        self.view = dashboardView
        
        dashboardView.tableView.delegate = self
        dashboardView.tableView.dataSource = self
        
        dashboardView.newButton.addTarget(self, action: "newButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        // Versteckt die Statusbar
        return true
    }
    
    // MARK: - Actions
    func newButtonTapped(sender: UIButton!) {
        let newProfileViewController = NewProfileViewController()
        
        UIView.transitionWithView(self.view, duration: 0.5, options: UIViewAnimationOptions.TransitionCurlUp, animations: { () -> Void in
                self.view.addSubview(newProfileViewController.view)
            }, completion: {(finished: Bool) -> () in
                self.presentViewController(newProfileViewController, animated: false, completion: nil)
        })
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
        
        dashboardView.tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: - Table View Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let personDict:NSDictionary = personArray.objectAtIndex(indexPath.row) as NSDictionary
        
        let personID: String = personDict["identifier"] as String
        
        let wishlistDashboardViewController: WishlistDashboardViewController = WishlistDashboardViewController()
        wishlistDashboardViewController.personID = personID
        
        self.presentViewController(wishlistDashboardViewController, animated: false, completion: nil)
    }
}

