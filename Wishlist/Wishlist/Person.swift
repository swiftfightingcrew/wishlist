//
//  Person.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 31.08.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import Foundation
import CoreData

@objc(Person)
class Person: NSManagedObject {

    @NSManaged var identifier: String
    @NSManaged var firstName: String
    @NSManaged var age: String
    @NSManaged var gender: String
    @NSManaged var personImage: NSData

}
