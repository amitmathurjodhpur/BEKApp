//
//	SetCustomerPaymentTypeEntry.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SetCustomerPaymentTypeEntry : NSObject, NSCoding, Mappable{

	var configurationInfos : [AnyObject]?
	var entryNumber : Int?
	var product : SetCustomerPaymentTypeProduct?
	var quantity : Int?
	var totalPrice : SetCustomerPaymentTypeTotalPrice?


	class func newInstance(map: Map) -> Mappable?{
		return SetCustomerPaymentTypeEntry()
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
         product = aDecoder.decodeObject(forKey: "product") as? SetCustomerPaymentTypeProduct
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         totalPrice = aDecoder.decodeObject(forKey: "totalPrice") as? SetCustomerPaymentTypeTotalPrice

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