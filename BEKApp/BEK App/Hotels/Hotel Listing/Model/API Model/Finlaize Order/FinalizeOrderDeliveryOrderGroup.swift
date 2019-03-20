//
//	FinalizeOrderDeliveryOrderGroup.swift
//
//	Create by Bhavik on 15/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class FinalizeOrderDeliveryOrderGroup : NSObject, NSCoding, Mappable{

	var entries : [FinalizeOrderEntry]?
	var totalPriceWithTax : FinalizeOrderDeliveryCost?


	class func newInstance(map: Map) -> Mappable?{
		return FinalizeOrderDeliveryOrderGroup()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		entries <- map["entries"]
		totalPriceWithTax <- map["totalPriceWithTax"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         entries = aDecoder.decodeObject(forKey: "entries") as? [FinalizeOrderEntry]
         totalPriceWithTax = aDecoder.decodeObject(forKey: "totalPriceWithTax") as? FinalizeOrderDeliveryCost

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
		if totalPriceWithTax != nil{
			aCoder.encode(totalPriceWithTax, forKey: "totalPriceWithTax")
		}

	}

}