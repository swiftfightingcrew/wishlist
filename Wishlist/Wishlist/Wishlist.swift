//
//  Wishlist.swift
//  Wishlist
//
//  Created by Edgar König on 10.09.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import CoreData

@objc(Wishlist)
class Wishlist: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var letter: String
    @NSManaged var productImage: NSData
    @NSManaged var title: String
    @NSManaged var personId: String

}
