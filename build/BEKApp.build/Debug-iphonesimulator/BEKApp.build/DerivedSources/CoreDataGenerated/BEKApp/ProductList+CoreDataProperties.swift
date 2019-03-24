//
//  ProductList+CoreDataProperties.swift
//  
//
//  Created by MAC on 23/03/19.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ProductList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductList> {
        return NSFetchRequest<ProductList>(entityName: "ProductList")
    }

    @NSManaged public var hotelId: Int64
    @NSManaged public var hotelName: String?
    @NSManaged public var itemId: Int64
    @NSManaged public var itemMargin: Double
    @NSManaged public var itemName: String?
    @NSManaged public var itemPerBagQuantity: String?
    @NSManaged public var itemProductionCost: Double
    @NSManaged public var itemQuantity: Int64
    @NSManaged public var itemSubTotal: Double
    @NSManaged public var itemTitle: String?
    @NSManaged public var itemUnitPrice: Double

}
