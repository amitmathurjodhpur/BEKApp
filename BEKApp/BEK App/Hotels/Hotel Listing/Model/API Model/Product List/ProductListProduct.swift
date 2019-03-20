//
//	ProductListProduct.swift
//
//	Create by Bhavik on 10/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ProductListProduct : NSObject, NSCoding, Mappable{

	var baseOptions : [AnyObject]?
	var categories : [ProductListCategory]?
	var code : String?
	var configurable : Bool?
	var manufacturer : String?
	var name : String?
	var price : ProductListPrice?
	var purchasable : Bool?
	var stock : ProductListStock?
	var url : String?


	class func newInstance(map: Map) -> Mappable?{
		return ProductListProduct()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		baseOptions <- map["baseOptions"]
		categories <- map["categories"]
		code <- map["code"]
		configurable <- map["configurable"]
		manufacturer <- map["manufacturer"]
		name <- map["name"]
		price <- map["price"]
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
         baseOptions = aDecoder.decodeObject(forKey: "baseOptions") as? [AnyObject]
         categories = aDecoder.decodeObject(forKey: "categories") as? [ProductListCategory]
         code = aDecoder.decodeObject(forKey: "code") as? String
         configurable = aDecoder.decodeObject(forKey: "configurable") as? Bool
         manufacturer = aDecoder.decodeObject(forKey: "manufacturer") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         price = aDecoder.decodeObject(forKey: "price") as? ProductListPrice
         purchasable = aDecoder.decodeObject(forKey: "purchasable") as? Bool
         stock = aDecoder.decodeObject(forKey: "stock") as? ProductListStock
         url = aDecoder.decodeObject(forKey: "url") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if baseOptions != nil{
			aCoder.encode(baseOptions, forKey: "baseOptions")
		}
		if categories != nil{
			aCoder.encode(categories, forKey: "categories")
		}
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if configurable != nil{
			aCoder.encode(configurable, forKey: "configurable")
		}
		if manufacturer != nil{
			aCoder.encode(manufacturer, forKey: "manufacturer")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
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