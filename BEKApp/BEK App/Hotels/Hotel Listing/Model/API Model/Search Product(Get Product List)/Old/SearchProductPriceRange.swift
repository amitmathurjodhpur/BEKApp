//
//	SearchProductPriceRange.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductPriceRange : NSObject, NSCoding, Mappable{



	class func newInstance(map: Map) -> Mappable?{
		return SearchProductPriceRange()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{

	}

}