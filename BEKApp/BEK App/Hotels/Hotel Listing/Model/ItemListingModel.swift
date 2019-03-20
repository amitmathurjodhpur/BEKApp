//
//  ItemListingModel.swift
//  BEKApp
//
//  Created by Bhavik on 06/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class ItemListingModel: NSObject {
    var itemId: String!
    var itemTitle: String!
    var itemName: String!
    var itemQuantityPerPack: String!
    var itemProductionCost: String!
    var itemUnitPrice: String!
    var itemMargin: String!
    var itemQunatity: String!
    var itemSubTotalPrice: String!
    
    init(with itemId: String!, itemTitle: String!, itemName: String!, itemQuantityPerPack: String!, itemQunatity: String!, itemUnitPrice: String!, itemProductionCost: String! = "", itemMargin: String! = "", itemSubTotalPrice: String! = "") {
        self.itemId = itemId
        self.itemTitle = itemTitle
        self.itemName = itemName
        self.itemQuantityPerPack = itemQuantityPerPack
        self.itemProductionCost = itemProductionCost
        self.itemUnitPrice = itemUnitPrice
        self.itemMargin = itemMargin
        self.itemQunatity = itemQunatity
        self.itemSubTotalPrice = itemSubTotalPrice
    }
}
