//
//	AddProductToCartResponse.swift
//
//	Create by Bhavik on 11/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class AddProductToCartResponse : NSObject, NSCoding, Mappable{

	var entry : AddProductToCartEntry?
	var quantity : Int?
	var quantityAdded : Int?
	var statusCode : String?


	class func newInstance(map: Map) -> Mappable?{
		return AddProductToCartResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		entry <- map["entry"]
		quantity <- map["quantity"]
		quantityAdded <- map["quantityAdded"]
		statusCode <- map["statusCode"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         entry = aDecoder.decodeObject(forKey: "entry") as? AddProductToCartEntry
         quantity = aDecoder.decodeObject(forKey: "quantity") as? Int
         quantityAdded = aDecoder.decodeObject(forKey: "quantityAdded") as? Int
         statusCode = aDecoder.decodeObject(forKey: "statusCode") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if entry != nil{
			aCoder.encode(entry, forKey: "entry")
		}
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if quantityAdded != nil{
			aCoder.encode(quantityAdded, forKey: "quantityAdded")
		}
		if statusCode != nil{
			aCoder.encode(statusCode, forKey: "statusCode")
		}

	}

}