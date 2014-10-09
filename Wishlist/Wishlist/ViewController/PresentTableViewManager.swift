//
//  PresentTableViewManager.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 09.10.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit

class PresentTableViewManager: UITableViewController {
    
    var cellHeight:CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 345)
        
        
        var nipName=UINib(nibName: "PresentTableViewCell", bundle:nil)
        self.tableView.registerNib(nipName, forCellReuseIdentifier: "Cell")
    }
    
    func suchen() {
        
    }

    // MARK: - Table view data source

     override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 5
    }

     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> PresentTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as PresentTableViewCell
//        if cell == nil {
//            cell = NibLoader.loadFromNibNamed("PresentTableViewCell") as? PresentTableViewCell
//        }
//        
        cellHeight = cell.contentView.frame.height
        println(cellHeight)
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
     override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 77
    }

}
