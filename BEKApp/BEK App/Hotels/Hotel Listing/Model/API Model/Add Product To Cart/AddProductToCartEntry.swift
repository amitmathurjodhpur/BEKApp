//
//	AddProductToCartEntry.swift
//
//	Create by Bhavik on 11/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class AddProductToCartEntry : NSObject, NSCoding, Mappable{

	var configurationInfos : [AnyObject]?
	var entryNumber : Int?
	var product : AddProductToCartProduct?
	var quantity : Int?
	var totalPrice : AddProductToCartTotalPrice?


	class func newInstance(map: Map) -> Mappable?{
		return AddProductToCartEntry()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		configurationInfos <- map["configurationInfos"]
		entryNumber <- map["entryNumber"]
		product <- map["product"]
		quantity <- map["quantity"]
		totalPrice <- map["totalPrice"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         configurationInfos = aDecoder.decodeObject(forKey: "configurationInfos") as? [AnyObject]
         entryNumber = aDecoder.decodeObject(forKey: "entryNumber") as? Int
         product = aDecoder.decodeObject(forKey: "product") as? AddProductToCartProduct
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         totalPrice = aDecoder.decodeObject(forKey: "totalPrice") as? AddProductToCartTotalPrice

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if configurationInfos != nil{
			aCoder.encode(configurationInfos, forKey: "configurationInfos")
		}
		if entryNumber != nil{
			aCoder.encode(entryNumber, forKey: "entryNumber")
		}
		if product != nil{
			aCoder.encode(product, forKey: "product")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if totalPrice != nil{
			aCoder.encode(totalPrice, forKey: "totalPrice")
		}

	}

}