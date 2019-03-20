//
//	GetProductListSearchResponse.swift
//
//	Create by Bhavik on 18/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class GetProductListSearchResponse : NSObject, NSCoding, Mappable{

	var breadcrumbs : [AnyObject]?
	var categoryCode : String?
	var currentQuery : GetProductListSearchCurrentQuery?
	var facets : [GetProductListSearchFacet]?
	var freeTextSearch : String?
	var pagination : GetProductListSearchPagination?
	var products : [GetProductListSearchProduct]?
	var sorts : [GetProductListSearchSort]?
	var type : String?


	class func newInstance(map: Map) -> Mappable?{
		return GetProductListSearchResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		breadcrumbs <- map["breadcrumbs"]
		categoryCode <- map["categoryCode"]
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
         categoryCode = aDecoder.decodeObject(forKey: "categoryCode") as? String
         currentQuery = aDecoder.decodeObject(forKey: "currentQuery") as? GetProductListSearchCurrentQuery
         facets = aDecoder.decodeObject(forKey: "facets") as? [GetProductListSearchFacet]
         freeTextSearch = aDecoder.decodeObject(forKey: "freeTextSearch") as? String
         pagination = aDecoder.decodeObject(forKey: "pagination") as? GetProductListSearchPagination
         products = aDecoder.decodeObject(forKey: "products") as? [GetProductListSearchProduct]
         sorts = aDecoder.decodeObject(forKey: "sorts") as? [GetProductListSearchSort]
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
		if categoryCode != nil{
			aCoder.encode(categoryCode, forKey: "categoryCode")
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