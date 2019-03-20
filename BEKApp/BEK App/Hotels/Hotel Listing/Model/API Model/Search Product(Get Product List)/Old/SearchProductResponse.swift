//
//	SearchProductResponse.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductResponse : NSObject, NSCoding, Mappable{

	var breadcrumbs : [AnyObject]?
	var currentQuery : SearchProductCurrentQuery?
	var facets : [SearchProductFacet]?
	var freeTextSearch : String?
	var pagination : SearchProductPagination?
	var products : [SearchProductProduct]?
	var sorts : [SearchProductSort]?
	var type : String?


	class func newInstance(map: Map) -> Mappable?{
		return SearchProductResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		breadcrumbs <- map["breadcrumbs"]
		currentQuery <- map["currentQuery"]
		facets <- map["facets"]
		freeTextSearch <- map["freeTextSearch"]
		pagination <- map["pagination"]
		products <- map["products"]
		sorts <- map["sorts"]
		type <- map["type"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         breadcrumbs = aDecoder.decodeObject(forKey: "breadcrumbs") as? [AnyObject]
         currentQuery = aDecoder.decodeObject(forKey: "currentQuery") as? SearchProductCurrentQuery
         facets = aDecoder.decodeObject(forKey: "facets") as? [SearchProductFacet]
         freeTextSearch = aDecoder.decodeObject(forKey: "freeTextSearch") as? String
         pagination = aDecoder.decodeObject(forKey: "pagination") as? SearchProductPagination
         products = aDecoder.decodeObject(forKey: "products") as? [SearchProductProduct]
         sorts = aDecoder.decodeObject(forKey: "sorts") as? [SearchProductSort]
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if breadcrumbs != nil{
			aCoder.encode(breadcrumbs, forKey: "breadcrumbs")
		}
		if currentQuery != nil{
			aCoder.encode(currentQuery, forKey: "currentQuery")
		}
		if facets != nil{
			aCoder.encode(facets, forKey: "facets")
		}
		if freeTextSearch != nil{
			aCoder.encode(freeTextSearch, forKey: "freeTextSearch")
		}
		if pagination != nil{
			aCoder.encode(pagination, forKey: "pagination")
		}
		if products != nil{
			aCoder.encode(products, forKey: "products")
		}
		if sorts != nil{
			aCoder.encode(sorts, forKey: "sorts")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}