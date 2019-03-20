//
//	ProductListFavouriteList.swift
//
//	Create by Bhavik on 10/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ProductListFavouriteList : NSObject, NSCoding, Mappable{

	var entries : [ProductListEntry]?
	var name : String?
	var owner : ProductListOwner?
	var sharedWithPrincipals : [AnyObject]?


	class func newInstance(map: Map) -> Mappable?{
		return ProductListFavouriteList()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		entries <- map["entries"]
		name <- map["name"]
		owner <- map["owner"]
		sharedWithPrincipals <- map["sharedWithPrincipals"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         entries = aDecoder.decodeObject(forKey: "entries") as? [ProductListEntry]
         name = aDecoder.decodeObject(forKey: "name") as? String
         owner = aDecoder.decodeObject(forKey: "owner") as? ProductListOwner
         sharedWithPrincipals = aDecoder.decodeObject(forKey: "sharedWithPrincipals") as? [AnyObject]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if entries != nil{
			aCoder.encode(entries, forKey: "entries")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if owner != nil{
			aCoder.encode(owner, forKey: "owner")
		}
		if sharedWithPrincipals != nil{
			aCoder.encode(sharedWithPrincipals, forKey: "sharedWithPrincipals")
		}

	}

}