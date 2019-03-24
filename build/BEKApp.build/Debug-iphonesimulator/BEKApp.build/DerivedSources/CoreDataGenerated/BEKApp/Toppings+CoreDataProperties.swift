//
//  Toppings+CoreDataProperties.swift
//  
//
//  Created by MAC on 23/03/19.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Toppings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Toppings> {
        return NSFetchRequest<Toppings>(entityName: "Toppings")
    }

    @NSManaged public var toppingId: Int64
    @NSManaged public var toppingName: String?
    @NSManaged public var toppingPrice: Double
    @NSManaged public var cart: Cart?

}
