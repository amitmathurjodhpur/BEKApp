//
//  CoreDataModel.swift
//
//  Created by Bhavik Barot on 7/3/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum CoreDataEntityList: String {
    case productList = "ProductList"
    case cart = "Cart"
    case toppings = "Toppings"
}

class CoreDataModel: NSObject {

    
//    hotelId: Int64, hotelName: String?, itemMargin: Double, itemName: String, itemPerBagQuantity: Int64, itemProductionCost: Double, itemQuantity: Int64, itemSubTotal: Double, itemTitle: String?, itemUnitPrice: Double, toppingId: Int64, toppingName: String?, toppingPrice: Double
    
    //@NSManaged public var hotelId: Int64
    //@NSManaged public var hotelName: String?
    //@NSManaged public var itemMargin: Double
    //@NSManaged public var itemName: String?
    //@NSManaged public var itemPerBagQuantity: Int64
    //@NSManaged public var itemProductionCost: Double
    //@NSManaged public var itemQuantity: Int64
    //@NSManaged public var itemSubTotal: Double
    //@NSManaged public var itemTitle: String?
    //@NSManaged public var itemUnitPrice: Double
    //@NSManaged public var toppings: Toppings?
    
    //@NSManaged public var toppingId: Int64
    //@NSManaged public var toppingName: String?
    //@NSManaged public var toppingPrice: Double
    //@NSManaged public var cart: Cart?
    
    //Cart
    private let attributeHotelId = "hotelId"
    private let attributeHotelName = "hotelName"
    private let attributeItemId = "itemId"
    private let attributeItemName = "itemName"
    private let attributeItemMargin = "itemMargin"
    private let attributeItemPerBagQuantity = "itemPerBagQuantity"
    private let attributeItemProductionCost = "itemProductionCost"
    private let attributeItemQuantity = "itemQuantity"
    private let attributeItemSubTotal = "itemSubTotal"
    private let attributeItemTitle = "itemTitle"
    private let attributeItemUnitPrice = "itemUnitPrice"
    private let attributeToppings = "toppings"
    
    //Toppings
    private let attributeToppingId = "toppingId"
    private let attributeToppingName = "toppingName"
    private let attributeToppingPrice = "toppingPrice"

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context: NSManagedObjectContext!
    private var entityProductList: NSEntityDescription?
    private var entityCart: NSEntityDescription?
    private var entityToppings: NSEntityDescription?
    
    public static let shared = CoreDataModel()
    
    override init() {
        self.context = self.appDelegate.persistentContainer.viewContext
        self.entityProductList = NSEntityDescription.entity(forEntityName: CoreDataEntityList.productList.rawValue, in: self.context)
        self.entityCart = NSEntityDescription.entity(forEntityName: CoreDataEntityList.cart.rawValue, in: self.context)
        self.entityToppings = NSEntityDescription.entity(forEntityName: CoreDataEntityList.toppings.rawValue, in: self.context)
    }
    
    
    public func saveDataToProductList(with hotelId: Int64, hotelName: String?, itemMargin: Double, itemName: String, itemPerBagQuantity: String, itemProductionCost: Double, itemQuantity: Int64, itemSubTotal: Double, itemTitle: String?, itemUnitPrice: Double) {
        let newUser = NSManagedObject(entity: self.entityProductList!, insertInto: self.context)
        newUser.setValue(hotelId, forKey: self.attributeHotelId)
        newUser.setValue(hotelName, forKey: self.attributeHotelName)
        newUser.setValue(itemMargin, forKey: self.attributeItemMargin)
        newUser.setValue(itemName, forKey: self.attributeItemName)
        newUser.setValue(itemPerBagQuantity, forKey: self.attributeItemPerBagQuantity)
        newUser.setValue(itemProductionCost, forKey: self.attributeItemProductionCost)
        newUser.setValue(itemQuantity, forKey: self.attributeItemQuantity)
        newUser.setValue(itemSubTotal, forKey: self.attributeItemSubTotal)
        newUser.setValue(itemTitle, forKey: self.attributeItemTitle)
        newUser.setValue(itemUnitPrice, forKey: self.attributeItemUnitPrice)
        
        do {
            try self.context.save()
        } catch {
            print("Error to save data in Product List")
        }
    }
    
    public func getDataFromProductList(for hotelId: Int64) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityList.productList.rawValue)
        var result: [NSManagedObject] = []
        request.predicate = NSPredicate(format: "hotelId = %d", hotelId)
        request.returnsObjectsAsFaults = false
        do {
            result = try self.context.fetch(request) as! [NSManagedObject]
        } catch {
            result = []
        }
        return result
    }
    
    public func getDataFromProductList_Offline(for hotelId: Int64) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityList.productList.rawValue)
        var result: [NSManagedObject] = []
        request.predicate = NSPredicate(format: "hotelId = %d", hotelId)
        request.returnsObjectsAsFaults = false
        do {
            result = try self.context.fetch(request) as! [NSManagedObject]
        } catch {
            result = []
        }
        return result
    }
    
    public func deleteProductListData(ProductId productId: NSManagedObjectID) -> Bool {
        let managedObject = self.context.object(with: productId) as! ProductList
        self.context.refresh(managedObject, mergeChanges: false)
        do {
            self.context.delete(managedObject)
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
    
    public func deleteAllProductListData() {
        let resultsCart = self.showData(for: .productList) as! [ProductList]
        for object in resultsCart {
            do {
                self.context.refresh(object, mergeChanges: false)
                self.context.delete(object)
                try self.context.save()
            } catch {
                print("Error to Remove Cart Data, ID: \(object.objectID)")
            }
        }
    }
    
    public func saveDataToCart(with hotelId: Int64, hotelName: String?, itemId: Int64, itemMargin: Double, itemName: String, itemPerBagQuantity: String, itemProductionCost: Double, itemQuantity: Int64, itemSubTotal: Double, itemTitle: String?, itemUnitPrice: Double, toppingId: Int64! = 0, toppingName: String? = "", toppingPrice: Double! = 0.0) -> Bool {

        let newUser = NSManagedObject(entity: self.entityCart!, insertInto: self.context)
        newUser.setValue(hotelId, forKey: self.attributeHotelId)
        newUser.setValue(hotelName, forKey: self.attributeHotelName)
        newUser.setValue(itemId, forKey: self.attributeItemId)
        newUser.setValue(itemMargin, forKey: self.attributeItemMargin)
        newUser.setValue(itemName, forKey: self.attributeItemName)
        newUser.setValue(itemPerBagQuantity, forKey: self.attributeItemPerBagQuantity)
        newUser.setValue(itemProductionCost, forKey: self.attributeItemProductionCost)
        newUser.setValue(itemQuantity, forKey: self.attributeItemQuantity)
        newUser.setValue(itemSubTotal, forKey: self.attributeItemSubTotal)
        newUser.setValue(itemTitle, forKey: self.attributeItemTitle)
        newUser.setValue(itemUnitPrice, forKey: self.attributeItemUnitPrice)
        
        let newToppings = NSManagedObject(entity: self.entityToppings!, insertInto: self.context)
        newToppings.setValue(toppingId, forKey: self.attributeToppingId)
        newToppings.setValue(toppingName, forKey: self.attributeToppingName)
        newToppings.setValue(toppingPrice, forKey: self.attributeToppingPrice)
        
        newUser.setValue(newToppings, forKey: self.attributeToppings)
        
        do {
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
    
    public func showData(for entityName: CoreDataEntityList) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue)
        var result: [NSManagedObject] = []
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
             result = try self.context.fetch(request) as! [NSManagedObject]
        } catch {
            result = []
        }
        return result
    }
    
    public func filteredData(for entityName: CoreDataEntityList, withFilter name: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue)
        var result: [NSManagedObject] = []
        request.predicate = NSPredicate(format: "name contains %@", name)
        request.returnsObjectsAsFaults = false
        do {
            result = try self.context.fetch(request) as! [NSManagedObject]
        } catch {
            result = []
        }
        return result
    }
    
    public func updateCartData(with hotelId: Int64, hotelName: String?, itemId: Int64, itemMargin: Double, itemName: String, itemPerBagQuantity: String, itemProductionCost: Double, itemQuantity: Int64, itemSubTotal: Double, itemTitle: String?, itemUnitPrice: Double, toppingId: Int64! = 0, toppingName: String? = "", toppingPrice: Double! = 0.0, toOrderID orderId: NSManagedObjectID) -> Bool {
        let managedObject = self.context.object(with: orderId) as! Cart
        self.context.refresh(managedObject, mergeChanges: false)
        managedObject.hotelId = hotelId
        managedObject.hotelName = hotelName
        managedObject.itemId = itemId
        managedObject.itemName = itemName
        managedObject.itemPerBagQuantity = itemPerBagQuantity
        managedObject.itemProductionCost = itemProductionCost
        managedObject.itemQuantity = itemQuantity
        managedObject.itemSubTotal = itemSubTotal
        managedObject.itemTitle = itemTitle
        managedObject.itemUnitPrice = itemUnitPrice
        managedObject.toppings?.toppingId = toppingId
        managedObject.toppings?.toppingName = toppingName
        managedObject.toppings?.toppingPrice = toppingPrice
        
        do {
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
    public func deleteCartData(OrderId orderId: NSManagedObjectID) -> Bool {
        let managedObject = self.context.object(with: orderId) as! Cart
        self.context.refresh(managedObject, mergeChanges: false)
        do {
            self.context.delete(managedObject)
            try self.context.save()
            return true
        } catch {
            return false
        }
    }
    
    public func deleteAllCartData() {
        let resultsCart = self.showData(for: .cart) as! [Cart]
        for object in resultsCart {
            do {
                self.context.refresh(object, mergeChanges: false)
                self.context.delete(object)
                try self.context.save()
            } catch {
                print("Error to Remove Cart Data, ID: \(object.objectID)")
            }
        }
        
        let resultsToppings = self.showData(for: .toppings) as! [Toppings]
        for object in resultsToppings {
            do {
                self.context.refresh(object, mergeChanges: false)
                self.context.delete(object)
                try self.context.save()
            } catch {
                print("Error to Remove Toppings Data, ID: \(object.objectID)")
            }
        }
    }
    
    public func deleteAllCartData(for entity: CoreDataEntityList) {
        let resultsCart = self.showData(for: entity)
        for object in resultsCart {
            do {
                self.context.refresh(object, mergeChanges: false)
                self.context.delete(object)
                try self.context.save()
            } catch {
                print("Error to Remove Cart Data, ID: \(object.objectID)")
            }
        }
    }
    public func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try self.context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                self.context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func getAutoIncremenet(managedObject: NSManagedObjectID) -> Int64 {
        let url = managedObject.uriRepresentation()
        let urlString = url.absoluteString
        if let pN = urlString.components(separatedBy: "/").last {
            let numberPart = pN.replacingOccurrences(of: "p", with: "")
            if let number = Int64(numberPart) {
                return number
            }
        }
        return 0
    }
}
