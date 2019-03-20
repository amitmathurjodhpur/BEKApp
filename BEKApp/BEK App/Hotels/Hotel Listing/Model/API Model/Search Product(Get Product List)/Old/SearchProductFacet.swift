//
//	SearchProductFacet.swift
//
//	Create by Bhavik on 14/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class SearchProductFacet : NSObject, NSCoding, Mappable{

	var category : Bool?
	var multiSelect : Bool?
	var name : String?
	var priority : Int?
	var topValues : [SearchProductTopValue]?
	var values : [SearchProductTopValue]?
	var visible : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return SearchProductFacet()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		category <- map["category"]
		multiSelect <- map["multiSelect"]
		name <- map["name"]
		priority <- map["priority"]
		topValues <- map["topValues"]
		values <- map["values"]
		visible <- map["visible"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         category = aDecoder.decodeObject(forKey: "category") as? Bool
         multiSelect = aDecoder.decodeObject(forKey: "multiSelect") as? Bool
         name = aDecoder.decodeObject(forKey: "name") as? String
         priority = aDecoder.decodeObject(forKey: "priority") as? Int
         topValues = aDecoder.decodeObject(forKey: "topValues") as? [SearchProductTopValue]
         values = aDecoder.decodeObject(forKey: "values") as? [SearchProductTopValue]
         visible = aDecoder.decodeObject(forKey: "visible") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if category != nil{
			aCoder.encode(category, forKey: "category")
		}
		if multiSelect != nil{
			aCoder.encode(multiSelect, forKey: "multiSelect")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if priority != nil{
			aCoder.encode(priority, forKey: "priority")
		}
		if topValues != nil{
			aCoder.encode(topValues, forKey: "topValues")
		}
		if values != nil{
			aCoder.encode(values, forKey: "values")
		}
		if visible != nil{
			aCoder.encode(visible, forKey: "visible")
		}

	}

}