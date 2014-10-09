//
//  PresentCollectionViewManager.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 09.10.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import UIKit

class PresentCollectionViewManager : UICollectionViewController, UICollectionViewDataSource, UICollectionViewDelegate, ITunesServiceDelegate {
    
    var itemCollectionView = UICollectionView()
    var iTunesService:ITunesService = ITunesService()
    var results: NSArray?
    var imageResults: [String] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(90, 90)
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        itemCollectionView.collectionViewLayout = layout
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        itemCollectionView.backgroundColor = UIColor.clearColor()
        
        iTunesService.delegate = self
    }
    
    func didReceiveResults(results: NSArray) {
        println(results)
        
        if results.count > 0 {
            self.results = results
            itemCollectionView.reloadData()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        var wishText = ""
        
        println(text)
        
        if text == " " {
            wishText = ""
        }
        
        wishText = wishText + text
        var countElement = countElements(wishText)
        if  countElement > 5 {
            iTunesService.searchItunesFor(wishText)
        }
        
        return true
    }
    
    //MARK - UICollectionViewDelegate
    //MARK - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as UICollectionViewCell
        var imageView: UIImageView = UIImageView(frame: CGRectMake(0, 15.5, 90, 90))
        
        println("imageView: \(imageView)")
        println("cell: \(cell)")
        
        cell.addSubview(imageView)
        
        var url:NSURL = NSURL(string: imageResults[indexPath.row])
        var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
        imageView.image = UIImage(data: data)
        
        //        if var array = self.results {
        //            println(indexPath.row)
        //            println(self.results?.count)
        //            var resultDict: NSDictionary = array.objectAtIndex(indexPath.row) as NSDictionary
        //
        //            var url:NSURL = NSURL.URLWithString(resultDict["artworkUrl60"] as String)
        //            var data:NSData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
        //            imageView.image = UIImage(data: data)
        //        } else {
        //            imageView.image = UIImage(named: "Geschenk_dummy")
        //            println(indexPath.row)
        //        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageResults.count
    }
    
    //MARK - UICollectionViewDelegate
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Item selected - index: \(indexPath.row)")
        let activeCell = itemCollectionView.cellForItemAtIndexPath(indexPath)!
        let activeColor = UIColor.lightGrayColor()
        activeCell.backgroundColor = activeCell.backgroundColor == activeColor ? UIColor.clearColor() : activeColor
    }

}
