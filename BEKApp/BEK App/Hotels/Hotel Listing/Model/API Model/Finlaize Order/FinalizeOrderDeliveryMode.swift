//
//	FinalizeOrderDeliveryMode.swift
//
//	Create by Bhavik on 15/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class FinalizeOrderDeliveryMode : NSObject, NSCoding, Mappable{

	var code : String?
	var deliveryCost : FinalizeOrderDeliveryCost?
	var descriptionField : String?
	var name : String?


	class func newInstance(map: Map) -> Mappable?{
		return FinalizeOrderDeliveryMode()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		code <- map["code"]
		deliveryCost <- map["deliveryCost"]
		descriptionField <- map["description"]
		name <- map["name"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         code = aDecoder.decodeObject(forKey: "code") as? String
         deliveryCost = aDecoder.decodeObject(forKey: "deliveryCost") as? FinalizeOrderDeliveryCost
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String

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
		if deliveryCost != nil{
			aCoder.encode(deliveryCost, forKey: "deliveryCost")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}