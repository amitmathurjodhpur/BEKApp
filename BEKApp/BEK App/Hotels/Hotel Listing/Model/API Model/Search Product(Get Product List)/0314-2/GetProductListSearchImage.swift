//
//	GetProductListSearchImage.swift
//
//	Create by Bhavik on 18/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class GetProductListSearchImage : NSObject, NSCoding, Mappable{

	var format : String?
	var imageType : String?
	var url : String?


	class func newInstance(map: Map) -> Mappable?{
		return GetProductListSearchImage()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		format <- map["format"]
		imageType <- map["imageType"]
		url <- map["url"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         format = aDecoder.decodeObject(forKey: "format") as? String
         imageType = aDecoder.decodeObject(forKey: "imageType") as? String
         url = aDecoder.decodeObject(forKey: "url") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if format != nil{
			aCoder.encode(format, forKey: "format")
		}
		if imageType != nil{
			aCoder.encode(imageType, forKey: "imageType")
		}
		if url != nil{
			aCoder.encode(url, forKey: "url")
		}

	}

}