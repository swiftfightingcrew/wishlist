//
//  WishlistViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import UIKit

class WishlistViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, ITunesServiceDelegate {
    
    var wishlistView:WishlistView!
    var wishText = ""
    var iTunesService:ITunesService = ITunesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistView = UIView.loadFromNibNamed("WishlistView") as WishlistView
        self.view = wishlistView
        
        wishlistView.textView.delegate = self
        
        iTunesService.delegate = self
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        println(text)
        
        if text == " " {
            wishText = ""
        }
        
        wishText = wishText + text
        
        if countElements(wishText) > 5 {
            iTunesService.searchItunesFor(wishText)
        }
        
        return true
    }
    
    func didReceiveResults(results: NSArray) {
        //println("JSON Response: \(results)")
        
        if results.count > 0 {
            var resultDict: NSDictionary = results.objectAtIndex(0) as NSDictionary
            
            println(resultDict)
            
            var url:NSURL = NSURL.URLWithString(resultDict["artworkUrl100"] as String)
            var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
            wishlistView.imageView.image = UIImage(data: data)
            
        }
    }
}
