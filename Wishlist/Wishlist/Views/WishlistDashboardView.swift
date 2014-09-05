//
//  WishlistDashboardView.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit

class WishlistDashboardView: UIView {
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var newButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    override func layoutSubviews() {
        welcomeLabel.font = UIFont(name: "Chalkduster", size: 17)
    }
}
