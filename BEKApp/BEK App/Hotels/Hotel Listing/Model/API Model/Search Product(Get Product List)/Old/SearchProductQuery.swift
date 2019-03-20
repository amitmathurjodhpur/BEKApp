//
//	SearchProductQuery.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductQuery : NSObject, NSCoding, Mappable{

	var value : String?
	var query : SearchProductQuery?
	var url : String?


	class func newInstance(map: Map) -> Mappable?{
		return SearchProductQuery()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		value <- map["value"]
		query <- map["query"]
		url <- map["url"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         value = aDecoder.decodeObject(forKey: "value") as? String
         query = aDecoder.decodeObject(forKey: "query") as? SearchProductQuery
         url = aDecoder.decodeObject(forKey: "url") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if value != nil{
			aCoder.encode(value, forKey: "value")
		}
		if query != nil{
			aCoder.encode(query, forKey: "query")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}

	}

}