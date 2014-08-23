//
//  UiUtil.swift
//  Wishlist
//
//  Created by Henning David on 22.08.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import UiKit

class UiUtil{
    
    class func createButton(title: String, myFrame: CGRect) -> UIButton {
        //return createButton(title, myFrame: myFrame,  action: nil, sender: nil)
        return  createButton(title, myFrame: myFrame, action: nil, sender: self)
    }
    
    class func createButton(title: String, myFrame: CGRect, action: Selector, sender: AnyObject ) -> UIButton {
        var button = UIButton(frame: myFrame)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 15
        if (action != nil) {
            button.addTarget(sender, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        }
        return button
    }
    
    class func createLabel(text: String, myFrame: CGRect) -> UILabel {
        var infoLabel = UILabel (frame: myFrame)
        infoLabel.text = text
        infoLabel.font = UIFont(name: "Chalkduster", size: 14)
        infoLabel.backgroundColor = UIColor.clearColor()
        infoLabel.textAlignment = .Center
        return infoLabel
    }
}