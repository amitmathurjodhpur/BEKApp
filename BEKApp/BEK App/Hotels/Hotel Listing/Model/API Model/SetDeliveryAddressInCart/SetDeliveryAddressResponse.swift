//
//	SetDeliveryAddressResponse.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SetDeliveryAddressResponse : NSObject, NSCoding, Mappable{

	var code : String?
	var entries : [SetDeliveryAddressEntry]?
	var guid : String?
	var paymentType : SetDeliveryAddressPaymentType?
	var subTotal : SetDeliveryAddressSubTotal?
	var totalDiscounts : SetDeliveryAddressTotalDiscount?
	var totalItems : Int?
	var totalPrice : SetDeliveryAddressTotalPrice?
	var totalPriceWithTax : SetDeliveryAddressTotalPrice?
	var totalTax : SetDeliveryAddressTotalDiscount?
	var totalUnitCount : Int?
	var type : String?


	class func newInstance(map: Map) -> Mappable?{
		return SetDeliveryAddressResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		code <- map["code"]
		entries <- map["entries"]
		guid <- map["guid"]
		paymentType <- map["paymentType"]
		subTotal <- map["subTotal"]
		totalDiscounts <- map["totalDiscounts"]
		totalItems <- map["totalItems"]
		totalPrice <- map["totalPrice"]
		totalPriceWithTax <- map["totalPriceWithTax"]
		totalTax <- map["totalTax"]
		totalUnitCount <- map["totalUnitCount"]
		type <- map["type"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         entries = aDecoder.decodeObject(forKey: "entries") as? [SetDeliveryAddressEntry]
         guid = aDecoder.decodeObject(forKey: "guid") as? String
         paymentType = aDecoder.decodeObject(forKey: "paymentType") as? SetDeliveryAddressPaymentType
         subTotal = aDecoder.decodeObject(forKey: "subTotal") as? SetDeliveryAddressSubTotal
         totalDiscounts = aDecoder.decodeObject(forKey: "totalDiscounts") as? SetDeliveryAddressTotalDiscount
         totalItems = aDecoder.decodeObject(forKey: "totalItems") as? Int
         totalPrice = aDecoder.decodeObject(forKey: "totalPrice") as? SetDeliveryAddressTotalPrice
         totalPriceWithTax = aDecoder.decodeObject(forKey: "totalPriceWithTax") as? SetDeliveryAddressTotalPrice
         totalTax = aDecoder.decodeObject(forKey: "totalTax") as? SetDeliveryAddressTotalDiscount
         totalUnitCount = aDecoder.decodeObject(forKey: "totalUnitCount") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if entries != nil{
			aCoder.encode(entries, forKey: "entries")
		}
		if guid != nil{
			aCoder.encode(guid, forKey: "guid")
		}
		if paymentType != nil{
			aCoder.encode(paymentType, forKey: "paymentType")
		}
		if subTotal != nil{
			aCoder.encode(subTotal, forKey: "subTotal")
		}
		if totalDiscounts != nil{
			aCoder.encode(totalDiscounts, forKey: "totalDiscounts")
		}
		if totalItems != nil{
			aCoder.encode(totalItems, forKey: "totalItems")
		}
		if totalPrice != nil{
			aCoder.encode(totalPrice, forKey: "totalPrice")
		}
		if totalPriceWithTax != nil{
			aCoder.encode(totalPriceWithTax, forKey: "totalPriceWithTax")
		}
		if totalTax != nil{
			aCoder.encode(totalTax, forKey: "totalTax")
		}
		if totalUnitCount != nil{
			aCoder.encode(totalUnitCount, forKey: "totalUnitCount")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}