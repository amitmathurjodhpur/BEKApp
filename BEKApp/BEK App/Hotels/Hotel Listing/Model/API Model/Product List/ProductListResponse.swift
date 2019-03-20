//
//	ProductListResponse.swift
//
//	Create by Bhavik on 10/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ProductListResponse : NSObject, NSCoding, Mappable{

	var favouriteList : ProductListFavouriteList?
	var productLists : [ProductListFavouriteList]?


	class func newInstance(map: Map) -> Mappable?{
		return ProductListResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		favouriteList <- map["favouriteList"]
		productLists <- map["productLists"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         favouriteList = aDecoder.decodeObject(forKey: "favouriteList") as? ProductListFavouriteList
         productLists = aDecoder.decodeObject(forKey: "productLists") as? [ProductListFavouriteList]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if favouriteList != nil{
			aCoder.encode(favouriteList, forKey: "favouriteList")
		}
		if productLists != nil{
			aCoder.encode(productLists, forKey: "productLists")
		}

	}

}