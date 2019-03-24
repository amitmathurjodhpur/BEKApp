//
//	FinalizeOrderCountry.swift
//
//	Create by Bhavik on 15/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class FinalizeOrderCountry : NSObject, NSCoding, Mappable{

	var isocode : String?


	class func newInstance(map: Map) -> Mappable?{
		return FinalizeOrderCountry()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		isocode <- map["isocode"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         isocode = aDecoder.decodeObject(forKey: "isocode") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if isocode != nil{
			aCoder.encode(isocode, forKey: "isocode")
		}

	}

}