//
//	GetProductListSearchProduct.swift
//
//	Create by Bhavik on 18/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class GetProductListSearchProduct : NSObject, NSCoding, Mappable{

	var code : String?
	var configurable : Bool?
	var configuratorType : String?
	var cost : Float?
	var firstVariantImage : String?
	var images : [GetProductListSearchImage]?
	var manufacturer : String?
	var multidimensional : Bool?
	var name : String?
	var pack : Int?
	var packageSize : String?
	var price : GetProductListSearchPrice?
	var priceRange : GetProductListSearchPriceRange?
	var stock : GetProductListSearchStock?
	var summary : String?
	var url : String?
	var volumePricesFlag : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return GetProductListSearchProduct()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		code <- map["code"]
		configurable <- map["configurable"]
		configuratorType <- map["configuratorType"]
		cost <- map["cost"]
		firstVariantImage <- map["firstVariantImage"]
		images <- map["images"]
		manufacturer <- map["manufacturer"]
		multidimensional <- map["multidimensional"]
		name <- map["name"]
		pack <- map["pack"]
		packageSize <- map["packageSize"]
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
         cost = aDecoder.decodeObject(forKey: "cost") as? Float
         firstVariantImage = aDecoder.decodeObject(forKey: "firstVariantImage") as? String
         images = aDecoder.decodeObject(forKey: "images") as? [GetProductListSearchImage]
         manufacturer = aDecoder.decodeObject(forKey: "manufacturer") as? String
         multidimensional = aDecoder.decodeObject(forKey: "multidimensional") as? Bool
         name = aDecoder.decodeObject(forKey: "name") as? String
         pack = aDecoder.decodeObject(forKey: "pack") as? Int
         packageSize = aDecoder.decodeObject(forKey: "packageSize") as? String
         price = aDecoder.decodeObject(forKey: "price") as? GetProductListSearchPrice
         priceRange = aDecoder.decodeObject(forKey: "priceRange") as? GetProductListSearchPriceRange
         stock = aDecoder.decodeObject(forKey: "stock") as? GetProductListSearchStock
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
		if cost != nil{
			aCoder.encode(cost, forKey: "cost")
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
		if pack != nil{
			aCoder.encode(pack, forKey: "pack")
		}
		if packageSize != nil{
			aCoder.encode(packageSize, forKey: "packageSize")
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