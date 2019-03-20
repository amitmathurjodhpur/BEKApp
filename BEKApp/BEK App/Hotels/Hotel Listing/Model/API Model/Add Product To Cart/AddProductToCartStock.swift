//
//	AddProductToCartStock.swift
//
//	Create by Bhavik on 11/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class AddProductToCartStock : NSObject, NSCoding, Mappable{

	var stockLevel : Int?


	class func newInstance(map: Map) -> Mappable?{
		return AddProductToCartStock()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		stockLevel <- map["stockLevel"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         stockLevel = aDecoder.decodeObject(forKey: "stockLevel") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if stockLevel != nil{
			aCoder.encode(stockLevel, forKey: "stockLevel")
		}

	}

}