//
//	ProductListOwner.swift
//
//	Create by Bhavik on 10/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class ProductListOwner : NSObject, NSCoding, Mappable{

	var name : String?
	var uid : String?


	class func newInstance(map: Map) -> Mappable?{
		return ProductListOwner()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		name <- map["name"]
		uid <- map["uid"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         name = aDecoder.decodeObject(forKey: "name") as? String
         uid = aDecoder.decodeObject(forKey: "uid") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if uid != nil{
			aCoder.encode(uid, forKey: "uid")
		}

	}

}