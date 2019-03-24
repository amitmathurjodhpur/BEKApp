//
//	FinalizeOrderTotalPrice.swift
//
//	Create by Bhavik on 15/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class FinalizeOrderTotalPrice : NSObject, NSCoding, Mappable{

	var currencyIso : String?
	var value : Float?


	class func newInstance(map: Map) -> Mappable?{
		return FinalizeOrderTotalPrice()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		currencyIso <- map["currencyIso"]
		value <- map["value"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         currencyIso = aDecoder.decodeObject(forKey: "currencyIso") as? String
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
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}

	}

}