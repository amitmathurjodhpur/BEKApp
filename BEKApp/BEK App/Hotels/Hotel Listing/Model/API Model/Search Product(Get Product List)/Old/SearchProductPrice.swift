//
//	SearchProductPrice.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductPrice : NSObject, NSCoding, Mappable{

	var currencyIso : String?
	var formattedValue : String?
	var priceType : String?
	var value : Float?


	class func newInstance(map: Map) -> Mappable?{
		return SearchProductPrice()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		currencyIso <- map["currencyIso"]
		formattedValue <- map["formattedValue"]
		priceType <- map["priceType"]
		value <- map["value"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         currencyIso = aDecoder.decodeObject(forKey: "currencyIso") as? String
         formattedValue = aDecoder.decodeObject(forKey: "formattedValue") as? String
         priceType = aDecoder.decodeObject(forKey: "priceType") as? String
         value = aDecoder.decodeObject(forKey: "value") as? Float

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if currencyIso != nil{
			aCoder.encode(currencyIso, forKey: "currencyIso")
		}
		if formattedValue != nil{
			aCoder.encode(formattedValue, forKey: "formattedValue")
		}
		if priceType != nil{
			aCoder.encode(priceType, forKey: "priceType")
		}
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}

	}

}