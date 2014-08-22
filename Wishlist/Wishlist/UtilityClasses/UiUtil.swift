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
        return createButton(title, myFrame: myFrame,  touchAction: nil)
    }
    
    class func createButton(title: String, myFrame: CGRect, touchAction: Selector ) -> UIButton {
        var button = UIButton(frame: myFrame)
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 15
        if (touchAction != nil) {
            button.addTarget(self, action: touchAction, forControlEvents: UIControlEvents.TouchUpInside)
        }
        return button
    }
}