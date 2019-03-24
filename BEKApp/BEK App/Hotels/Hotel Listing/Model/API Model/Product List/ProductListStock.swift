//
//	ProductListStock.swift
//
//	Create by Bhavik on 10/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ProductListStock : NSObject, NSCoding, Mappable{

	var stockLevel : Int?
	var stockLevelStatus : String?


	class func newInstance(map: Map) -> Mappable?{
		return ProductListStock()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		stockLevel <- map["stockLevel"]
		stockLevelStatus <- map["stockLevelStatus"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         stockLevel = aDecoder.decodeObject(forKey: "stockLevel") as? Int
         stockLevelStatus = aDecoder.decodeObject(forKey: "stockLevelStatus") as? String

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
		if stockLevelStatus != nil{
			aCoder.encode(stockLevelStatus, forKey: "stockLevelStatus")
		}

	}

}