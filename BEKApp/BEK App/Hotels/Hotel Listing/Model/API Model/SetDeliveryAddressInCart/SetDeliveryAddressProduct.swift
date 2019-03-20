//
//	SetDeliveryAddressProduct.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SetDeliveryAddressProduct : NSObject, NSCoding, Mappable{

	var availableForPickup : Bool?
	var code : String?
	var name : String?
	var purchasable : Bool?
	var stock : SetDeliveryAddressStock?
	var url : String?


	class func newInstance(map: Map) -> Mappable?{
		return SetDeliveryAddressProduct()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		availableForPickup <- map["availableForPickup"]
		code <- map["code"]
		name <- map["name"]
		purchasable <- map["purchasable"]
		stock <- map["stock"]
		url <- map["url"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         availableForPickup = aDecoder.decodeObject(forKey: "availableForPickup") as? Bool
         code = aDecoder.decodeObject(forKey: "code") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         purchasable = aDecoder.decodeObject(forKey: "purchasable") as? Bool
         stock = aDecoder.decodeObject(forKey: "stock") as? SetDeliveryAddressStock
         url = aDecoder.decodeObject(forKey: "url") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if availableForPickup != nil{
			aCoder.encode(availableForPickup, forKey: "availableForPickup")
		}
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if purchasable != nil{
			aCoder.encode(purchasable, forKey: "purchasable")
		}
		if stock != nil{
			aCoder.encode(stock, forKey: "stock")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}

	}

}