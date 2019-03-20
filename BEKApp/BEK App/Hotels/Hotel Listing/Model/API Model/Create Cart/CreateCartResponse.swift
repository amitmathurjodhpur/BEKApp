//
//	CreateCartResponse.swift
//
//	Create by Bhavik on 10/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class CreateCartResponse : NSObject, NSCoding, Mappable{

	var code : String?
	var entries : [AnyObject]?
	var guid : String?
	var subTotal : CreateCartSubTotal?
	var totalDiscounts : CreateCartSubTotal?
	var totalItems : Int?
	var totalPrice : CreateCartSubTotal?
	var totalPriceWithTax : CreateCartSubTotal?
	var totalTax : CreateCartSubTotal?
	var totalUnitCount : Int?
	var type : String?


	class func newInstance(map: Map) -> Mappable?{
		return CreateCartResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		code <- map["code"]
		entries <- map["entries"]
		guid <- map["guid"]
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
         entries = aDecoder.decodeObject(forKey: "entries") as? [AnyObject]
         guid = aDecoder.decodeObject(forKey: "guid") as? String
         subTotal = aDecoder.decodeObject(forKey: "subTotal") as? CreateCartSubTotal
         totalDiscounts = aDecoder.decodeObject(forKey: "totalDiscounts") as? CreateCartSubTotal
         totalItems = aDecoder.decodeObject(forKey: "totalItems") as? Int
         totalPrice = aDecoder.decodeObject(forKey: "totalPrice") as? CreateCartSubTotal
         totalPriceWithTax = aDecoder.decodeObject(forKey: "totalPriceWithTax") as? CreateCartSubTotal
         totalTax = aDecoder.decodeObject(forKey: "totalTax") as? CreateCartSubTotal
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