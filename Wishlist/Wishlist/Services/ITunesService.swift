//
//  ITuneService.swift
//  Wishlist
//
//  Created by Henning David on 23.08.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation

protocol ITunesServiceDelegate {
    func didReceiveResults(results: NSArray)
}

class ITunesService {
    var delegate:ITunesServiceDelegate? = nil
    
    func searchItunesFor(searchTerm: String?) {
        
        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
       let itunesSearchTerm =  searchTerm?.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        // Now escape anything else that isn't URL-friendly
        if let escapedSearchTerm = itunesSearchTerm?.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
            let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
            let url: NSURL = NSURL(string: urlPath)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
                println("Task completed")
                if(error != nil) {
                    // If there is an error in the web request, print it to the console
                    println(error.localizedDescription)
                }
                var err: NSError?
                
                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
                if(err != nil) {
                    // If there is an error parsing JSON, print it to the console
                    println("JSON Error \(err!.localizedDescription)")
                }
                let results: NSArray = jsonResult["results"] as NSArray
                dispatch_async(dispatch_get_main_queue(), {
                    if self.delegate != nil {
                        self.delegate!.didReceiveResults(results)
                    }
                })
            })
            
            task.resume()
        }
    }
}