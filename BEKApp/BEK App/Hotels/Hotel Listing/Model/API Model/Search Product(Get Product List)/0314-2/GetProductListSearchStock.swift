//
//	GetProductListSearchStock.swift
//
//	Create by Bhavik on 18/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class GetProductListSearchStock : NSObject, NSCoding, Mappable{

	var stockLevelStatus : String?


	class func newInstance(map: Map) -> Mappable?{
		return GetProductListSearchStock()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		stockLevelStatus <- map["stockLevelStatus"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         stockLevelStatus = aDecoder.decodeObject(forKey: "stockLevelStatus") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if stockLevelStatus != nil{
			aCoder.encode(stockLevelStatus, forKey: "stockLevelStatus")
		}

	}

}