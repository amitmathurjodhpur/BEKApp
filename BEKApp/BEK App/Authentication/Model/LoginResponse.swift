//
//	LoginResponse.swift
//
//	Create by Bhavik on 9/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class LoginResponse : NSObject, NSCoding, Mappable{

	var accessToken : String?
	var expiresIn : Int?
	var scope : String?
	var tokenType : String?


	class func newInstance(map: Map) -> Mappable?{
		return LoginResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		accessToken <- map["access_token"]
		expiresIn <- map["expires_in"]
		scope <- map["scope"]
		tokenType <- map["token_type"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         accessToken = aDecoder.decodeObject(forKey: "access_token") as? String
         expiresIn = aDecoder.decodeObject(forKey: "expires_in") as? Int
         scope = aDecoder.decodeObject(forKey: "scope") as? String
         tokenType = aDecoder.decodeObject(forKey: "token_type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if accessToken != nil{
			aCoder.encode(accessToken, forKey: "access_token")
		}
		if expiresIn != nil{
			aCoder.encode(expiresIn, forKey: "expires_in")
		}
		if scope != nil{
			aCoder.encode(scope, forKey: "scope")
		}
		if tokenType != nil{
			aCoder.encode(tokenType, forKey: "token_type")
		}

	}

}