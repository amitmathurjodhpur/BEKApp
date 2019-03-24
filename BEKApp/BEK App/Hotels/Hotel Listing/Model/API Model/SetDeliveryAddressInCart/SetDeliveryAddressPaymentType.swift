//
//	SetDeliveryAddressPaymentType.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SetDeliveryAddressPaymentType : NSObject, NSCoding, Mappable{

	var code : String?
	var displayName : String?


	class func newInstance(map: Map) -> Mappable?{
		return SetDeliveryAddressPaymentType()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		code <- map["code"]
		displayName <- map["displayName"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         displayName = aDecoder.decodeObject(forKey: "displayName") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if displayName != nil{
			aCoder.encode(displayName, forKey: "displayName")
		}

	}

}