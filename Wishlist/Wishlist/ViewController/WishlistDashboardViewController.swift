//
//  WishlistDashboardViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit

class WishlistDashboardViewController: UIViewController {
    
    var wishlistDashboardView:WishlistDashboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistDashboardView = UIView.loadFromNibNamed("WishlistDashboardView") as WishlistDashboardView
        
        self.view = wishlistDashboardView
        
        wishlistDashboardView.newButton.addTarget(self, action: "newButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func newButtonTapped(sender: UIButton) {
        println("huhu")
    }
}
