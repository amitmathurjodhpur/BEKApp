//
//	SearchProductProduct.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductProduct : NSObject, NSCoding, Mappable{

	var code : String?
	var configurable : Bool?
	var configuratorType : String?
	var firstVariantImage : String?
	var images : [SearchProductImage]?
	var manufacturer : String?
	var multidimensional : Bool?
	var name : String?
	var price : SearchProductPrice?
	var priceRange : SearchProductPriceRange?
	var stock : SearchProductStock?
	var summary : String?
	var url : String?
	var volumePricesFlag : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return SearchProductProduct()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		code <- map["code"]
		configurable <- map["configurable"]
		configuratorType <- map["configuratorType"]
		firstVariantImage <- map["firstVariantImage"]
		images <- map["images"]
		manufacturer <- map["manufacturer"]
		multidimensional <- map["multidimensional"]
		name <- map["name"]
		price <- map["price"]
		priceRange <- map["priceRange"]
		stock <- map["stock"]
		summary <- map["summary"]
		url <- map["url"]
		volumePricesFlag <- map["volumePricesFlag"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         configurable = aDecoder.decodeObject(forKey: "configurable") as? Bool
         configuratorType = aDecoder.decodeObject(forKey: "configuratorType") as? String
         firstVariantImage = aDecoder.decodeObject(forKey: "firstVariantImage") as? String
         images = aDecoder.decodeObject(forKey: "images") as? [SearchProductImage]
         manufacturer = aDecoder.decodeObject(forKey: "manufacturer") as? String
         multidimensional = aDecoder.decodeObject(forKey: "multidimensional") as? Bool
         name = aDecoder.decodeObject(forKey: "name") as? String
         price = aDecoder.decodeObject(forKey: "price") as? SearchProductPrice
         priceRange = aDecoder.decodeObject(forKey: "priceRange") as? SearchProductPriceRange
         stock = aDecoder.decodeObject(forKey: "stock") as? SearchProductStock
         summary = aDecoder.decodeObject(forKey: "summary") as? String
         url = aDecoder.decodeObject(forKey: "url") as? String
         volumePricesFlag = aDecoder.decodeObject(forKey: "volumePricesFlag") as? Bool

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
		if configurable != nil{
			aCoder.encode(configurable, forKey: "configurable")
		}
		if configuratorType != nil{
			aCoder.encode(configuratorType, forKey: "configuratorType")
		}
		if firstVariantImage != nil{
			aCoder.encode(firstVariantImage, forKey: "firstVariantImage")
		}
		if images != nil{
			aCoder.encode(images, forKey: "images")
		}
		if manufacturer != nil{
			aCoder.encode(manufacturer, forKey: "manufacturer")
		}
		if multidimensional != nil{
			aCoder.encode(multidimensional, forKey: "multidimensional")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}
		if priceRange != nil{
			aCoder.encode(priceRange, forKey: "priceRange")
		}
		if stock != nil{
			aCoder.encode(stock, forKey: "stock")
		}
		if summary != nil{
			aCoder.encode(summary, forKey: "summary")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}
		if volumePricesFlag != nil{
			aCoder.encode(volumePricesFlag, forKey: "volumePricesFlag")
		}

	}

}