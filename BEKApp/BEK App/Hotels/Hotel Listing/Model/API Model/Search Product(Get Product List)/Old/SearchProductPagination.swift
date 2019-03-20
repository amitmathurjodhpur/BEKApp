//
//	SearchProductPagination.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductPagination : NSObject, NSCoding, Mappable{

	var currentPage : Int?
	var pageSize : Int?
	var sort : String?
	var totalPages : Int?
	var totalResults : Int?


	class func newInstance(map: Map) -> Mappable?{
		return SearchProductPagination()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		currentPage <- map["currentPage"]
		pageSize <- map["pageSize"]
		sort <- map["sort"]
		totalPages <- map["totalPages"]
		totalResults <- map["totalResults"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         currentPage = aDecoder.decodeObject(forKey: "currentPage") as? Int
         pageSize = aDecoder.decodeObject(forKey: "pageSize") as? Int
         sort = aDecoder.decodeObject(forKey: "sort") as? String
         totalPages = aDecoder.decodeObject(forKey: "totalPages") as? Int
         totalResults = aDecoder.decodeObject(forKey: "totalResults") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if currentPage != nil{
			aCoder.encode(currentPage, forKey: "currentPage")
		}
		if pageSize != nil{
			aCoder.encode(pageSize, forKey: "pageSize")
		}
		if sort != nil{
			aCoder.encode(sort, forKey: "sort")
		}
		if totalPages != nil{
			aCoder.encode(totalPages, forKey: "totalPages")
		}
		if totalResults != nil{
			aCoder.encode(totalResults, forKey: "totalResults")
		}

	}

}