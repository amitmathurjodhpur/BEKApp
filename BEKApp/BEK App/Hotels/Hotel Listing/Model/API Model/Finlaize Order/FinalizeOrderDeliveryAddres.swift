//
//	FinalizeOrderDeliveryAddres.swift
//
//	Create by Bhavik on 15/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class FinalizeOrderDeliveryAddres : NSObject, NSCoding, Mappable{

	var country : FinalizeOrderCountry?
	var defaultAddress : Bool?
	var firstName : String?
	var formattedAddress : String?
	var id : String?
	var lastName : String?
	var line1 : String?
	var postalCode : String?
	var region : FinalizeOrderCountry?
	var town : String?


	class func newInstance(map: Map) -> Mappable?{
		return FinalizeOrderDeliveryAddres()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		country <- map["country"]
		defaultAddress <- map["defaultAddress"]
		firstName <- map["firstName"]
		formattedAddress <- map["formattedAddress"]
		id <- map["id"]
		lastName <- map["lastName"]
		line1 <- map["line1"]
		postalCode <- map["postalCode"]
		region <- map["region"]
		town <- map["town"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         country = aDecoder.decodeObject(forKey: "country") as? FinalizeOrderCountry
         defaultAddress = aDecoder.decodeObject(forKey: "defaultAddress") as? Bool
         firstName = aDecoder.decodeObject(forKey: "firstName") as? String
         formattedAddress = aDecoder.decodeObject(forKey: "formattedAddress") as? String
         id = aDecoder.decodeObject(forKey: "id") as? String
         lastName = aDecoder.decodeObject(forKey: "lastName") as? String
         line1 = aDecoder.decodeObject(forKey: "line1") as? String
         postalCode = aDecoder.decodeObject(forKey: "postalCode") as? String
         region = aDecoder.decodeObject(forKey: "region") as? FinalizeOrderCountry
         town = aDecoder.decodeObject(forKey: "town") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if country != nil{
			aCoder.encode(country, forKey: "country")
		}
		if defaultAddress != nil{
			aCoder.encode(defaultAddress, forKey: "defaultAddress")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "firstName")
		}
		if formattedAddress != nil{
			aCoder.encode(formattedAddress, forKey: "formattedAddress")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "lastName")
		}
		if line1 != nil{
			aCoder.encode(line1, forKey: "line1")
		}
		if postalCode != nil{
			aCoder.encode(postalCode, forKey: "postalCode")
		}
		if region != nil{
			aCoder.encode(region, forKey: "region")
		}
		if town != nil{
			aCoder.encode(town, forKey: "town")
		}

	}

}