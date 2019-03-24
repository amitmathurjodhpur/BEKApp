//
//  DSRCartItemListModel.swift
//  BEKApp
//
//  Created by Bhavik Barot on 07/03/19.
//  Copyright © 2019 Bhavik Barot. All rights reserved.
//

import UIKit

class DSRCartItemListModel: NSObject {
    var hotelId: Int64!
    var hotelName: String?
    var itemId: Int64!
    var itemMargin: Double!
    var itemName: String!
    var itemPerBagQuantity: String!
    var itemProductionCost: Double!
    var itemQuantity: Int64!
    var itemSubTotal: Double!
    var itemTitle: String?
    var itemUnitPrice: Double!
    var toppingId: Int64!
    var toppingName: String?
    var itemSummary: String?
    var toppingPrice: Double!
    
    init(with hotelId: Int64, hotelName: String?, itemId: Int64, itemMargin: Double, itemName: String, itemPerBagQuantity: String, itemProductionCost: Double, itemQuantity: Int64, itemSubTotal: Double, itemTitle: String?, itemUnitPrice: Double, toppingId: Int64! = 0, toppingName: String? = "", toppingPrice: Double! = 0.0, summary: String? = "") {
        self.hotelId = hotelId
        self.hotelName = hotelName
        self.itemId = itemId
        self.itemMargin = itemMargin
        self.itemName = itemName
        self.itemPerBagQuantity = itemPerBagQuantity
        self.itemProductionCost = itemProductionCost
        self.itemQuantity = itemQuantity
        self.itemSubTotal = itemSubTotal
        self.itemTitle = itemTitle
        self.itemUnitPrice = itemUnitPrice
        self.toppingId = toppingId
        self.toppingName = toppingName
        self.itemSummary = summary
        self.toppingPrice = toppingPrice
    }
    
    class func calculateCostSubtotal(_ model: DSRCartItemListModel) -> DSRCartItemListModel {
        let costProduction = model.itemProductionCost
        let margin = model.itemMargin
        let qty = model.itemQuantity
        
        let costPrice = (costProduction! + ((costProduction! * margin!)/100)).rounded(toPlaces: 2)
        let subTotal = (costPrice * Double(qty!)).rounded(toPlaces: 2)
        model.itemSubTotal = subTotal
        model.itemUnitPrice = costPrice
        return model
    }
    
    class func calculateCostMargin(_ model: DSRCartItemListModel) -> DSRCartItemListModel {
        let costProduction = model.itemProductionCost
        let unitPrice = model.itemUnitPrice
        let qty = model.itemQuantity
        
//        let margin = (((unitPrice! - costProduction!) / unitPrice!) * 100).rounded(toPlaces: 2)
        let margin = (((unitPrice! - costProduction!) / costProduction!) * 100).rounded(toPlaces: 2)
        let subTotal = (unitPrice! * Double(qty!)).rounded(toPlaces: 2)
        model.itemMargin = margin
        model.itemSubTotal = subTotal
        return model
    }
    
}
