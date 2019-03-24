//
//	SearchProductCurrentQuery.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductCurrentQuery : NSObject, NSCoding, Mappable{

	var query : SearchProductQuery?
	var url : String?


	class func newInstance(map: Map) -> Mappable?{
		return SearchProductCurrentQuery()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		query <- map["query"]
		url <- map["url"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         query = aDecoder.decodeObject(forKey: "query") as? SearchProductQuery
         url = aDecoder.decodeObject(forKey: "url") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if query != nil{
			aCoder.encode(query, forKey: "query")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}

	}

}