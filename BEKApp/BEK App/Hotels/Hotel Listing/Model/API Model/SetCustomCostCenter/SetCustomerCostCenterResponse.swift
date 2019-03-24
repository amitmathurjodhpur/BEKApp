//
//	SetCustomerCostCenterResponse.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SetCustomerCostCenterResponse : NSObject, NSCoding, Mappable{

	var code : String?
	var entries : [SetCustomerCostCenterEntry]?
	var guid : String?
	var paymentType : SetCustomerCostCenterPaymentType?
	var subTotal : SetCustomerCostCenterSubTotal?
	var totalDiscounts : SetCustomerCostCenterTotalDiscount?
	var totalItems : Int?
	var totalPrice : SetCustomerCostCenterTotalPrice?
	var totalPriceWithTax : SetCustomerCostCenterTotalPrice?
	var totalTax : SetCustomerCostCenterTotalDiscount?
	var totalUnitCount : Int?
	var type : String?


	class func newInstance(map: Map) -> Mappable?{
		return SetCustomerCostCenterResponse()
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
         entries = aDecoder.decodeObject(forKey: "entries") as? [SetCustomerCostCenterEntry]
         guid = aDecoder.decodeObject(forKey: "guid") as? String
         paymentType = aDecoder.decodeObject(forKey: "paymentType") as? SetCustomerCostCenterPaymentType
         subTotal = aDecoder.decodeObject(forKey: "subTotal") as? SetCustomerCostCenterSubTotal
         totalDiscounts = aDecoder.decodeObject(forKey: "totalDiscounts") as? SetCustomerCostCenterTotalDiscount
         totalItems = aDecoder.decodeObject(forKey: "totalItems") as? Int
         totalPrice = aDecoder.decodeObject(forKey: "totalPrice") as? SetCustomerCostCenterTotalPrice
         totalPriceWithTax = aDecoder.decodeObject(forKey: "totalPriceWithTax") as? SetCustomerCostCenterTotalPrice
         totalTax = aDecoder.decodeObject(forKey: "totalTax") as? SetCustomerCostCenterTotalDiscount
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