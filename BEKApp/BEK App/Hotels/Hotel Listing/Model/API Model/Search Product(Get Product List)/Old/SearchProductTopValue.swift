//
//	SearchProductTopValue.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductTopValue : NSObject, NSCoding, Mappable{

	var count : Int?
	var name : String?
	var query : SearchProductQuery?
	var selected : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return SearchProductTopValue()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		count <- map["count"]
		name <- map["name"]
		query <- map["query"]
		selected <- map["selected"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         count = aDecoder.decodeObject(forKey: "count") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         query = aDecoder.decodeObject(forKey: "query") as? SearchProductQuery
         selected = aDecoder.decodeObject(forKey: "selected") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if count != nil{
			aCoder.encode(count, forKey: "count")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if query != nil{
			aCoder.encode(query, forKey: "query")
		}
		if selected != nil{
			aCoder.encode(selected, forKey: "selected")
		}

	}

}