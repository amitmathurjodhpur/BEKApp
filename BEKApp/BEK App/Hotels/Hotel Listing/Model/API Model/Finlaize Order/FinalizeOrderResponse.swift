//
//	FinalizeOrderResponse.swift
//
//	Create by Bhavik on 15/3/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class FinalizeOrderResponse : NSObject, NSCoding, Mappable{

	var appliedOrderPromotions : [AnyObject]?
	var appliedProductPromotions : [AnyObject]?
	var appliedVouchers : [AnyObject]?
	var calculated : Bool?
	var code : String?
	var consignments : [AnyObject]?
	var created : String?
	var deliveryAddress : FinalizeOrderDeliveryAddres?
	var deliveryCost : FinalizeOrderDeliveryCost?
	var deliveryItemsQuantity : Int?
	var deliveryMode : FinalizeOrderDeliveryMode?
	var deliveryOrderGroups : [FinalizeOrderDeliveryOrderGroup]?
	var entries : [FinalizeOrderEntry]?
	var guestCustomer : Bool?
	var guid : String?
	var net : Bool?
	var orderDiscounts : FinalizeOrderOrderDiscount?
	var pickupItemsQuantity : Int?
	var pickupOrderGroups : [AnyObject]?
	var productDiscounts : FinalizeOrderOrderDiscount?
	var site : String?
	var status : String?
	var statusDisplay : String?
	var store : String?
	var subTotal : FinalizeOrderDeliveryCost?
	var totalDiscounts : FinalizeOrderOrderDiscount?
	var totalItems : Int?
	var totalPrice : FinalizeOrderDeliveryCost?
	var totalPriceWithTax : FinalizeOrderDeliveryCost?
	var totalTax : FinalizeOrderOrderDiscount?
	var type : String?
	var unconsignedEntries : [FinalizeOrderEntry]?
	var user : FinalizeOrderUser?


	class func newInstance(map: Map) -> Mappable?{
        return FinalizeOrderResponse()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		appliedOrderPromotions <- map["appliedOrderPromotions"]
		appliedProductPromotions <- map["appliedProductPromotions"]
		appliedVouchers <- map["appliedVouchers"]
		calculated <- map["calculated"]
		code <- map["code"]
		consignments <- map["consignments"]
		created <- map["created"]
		deliveryAddress <- map["deliveryAddress"]
		deliveryCost <- map["deliveryCost"]
		deliveryItemsQuantity <- map["deliveryItemsQuantity"]
		deliveryMode <- map["deliveryMode"]
		deliveryOrderGroups <- map["deliveryOrderGroups"]
		entries <- map["entries"]
		guestCustomer <- map["guestCustomer"]
		guid <- map["guid"]
		net <- map["net"]
		orderDiscounts <- map["orderDiscounts"]
		pickupItemsQuantity <- map["pickupItemsQuantity"]
		pickupOrderGroups <- map["pickupOrderGroups"]
		productDiscounts <- map["productDiscounts"]
		site <- map["site"]
		status <- map["status"]
		statusDisplay <- map["statusDisplay"]
		store <- map["store"]
		subTotal <- map["subTotal"]
		totalDiscounts <- map["totalDiscounts"]
		totalItems <- map["totalItems"]
		totalPrice <- map["totalPrice"]
		totalPriceWithTax <- map["totalPriceWithTax"]
		totalTax <- map["totalTax"]
		type <- map["type"]
		unconsignedEntries <- map["unconsignedEntries"]
		user <- map["user"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         appliedOrderPromotions = aDecoder.decodeObject(forKey: "appliedOrderPromotions") as? [AnyObject]
         appliedProductPromotions = aDecoder.decodeObject(forKey: "appliedProductPromotions") as? [AnyObject]
         appliedVouchers = aDecoder.decodeObject(forKey: "appliedVouchers") as? [AnyObject]
         calculated = aDecoder.decodeObject(forKey: "calculated") as? Bool
         code = aDecoder.decodeObject(forKey: "code") as? String
         consignments = aDecoder.decodeObject(forKey: "consignments") as? [AnyObject]
         created = aDecoder.decodeObject(forKey: "created") as? String
         deliveryAddress = aDecoder.decodeObject(forKey: "deliveryAddress") as? FinalizeOrderDeliveryAddres
         deliveryCost = aDecoder.decodeObject(forKey: "deliveryCost") as? FinalizeOrderDeliveryCost
         deliveryItemsQuantity = aDecoder.decodeObject(forKey: "deliveryItemsQuantity") as? Int
         deliveryMode = aDecoder.decodeObject(forKey: "deliveryMode") as? FinalizeOrderDeliveryMode
         deliveryOrderGroups = aDecoder.decodeObject(forKey: "deliveryOrderGroups") as? [FinalizeOrderDeliveryOrderGroup]
         entries = aDecoder.decodeObject(forKey: "entries") as? [FinalizeOrderEntry]
         guestCustomer = aDecoder.decodeObject(forKey: "guestCustomer") as? Bool
         guid = aDecoder.decodeObject(forKey: "guid") as? String
         net = aDecoder.decodeObject(forKey: "net") as? Bool
         orderDiscounts = aDecoder.decodeObject(forKey: "orderDiscounts") as? FinalizeOrderOrderDiscount
         pickupItemsQuantity = aDecoder.decodeObject(forKey: "pickupItemsQuantity") as? Int
         pickupOrderGroups = aDecoder.decodeObject(forKey: "pickupOrderGroups") as? [AnyObject]
         productDiscounts = aDecoder.decodeObject(forKey: "productDiscounts") as? FinalizeOrderOrderDiscount
         site = aDecoder.decodeObject(forKey: "site") as? String
         status = aDecoder.decodeObject(forKey: "status") as? String
         statusDisplay = aDecoder.decodeObject(forKey: "statusDisplay") as? String
         store = aDecoder.decodeObject(forKey: "store") as? String
         subTotal = aDecoder.decodeObject(forKey: "subTotal") as? FinalizeOrderDeliveryCost
         totalDiscounts = aDecoder.decodeObject(forKey: "totalDiscounts") as? FinalizeOrderOrderDiscount
         totalItems = aDecoder.decodeObject(forKey: "totalItems") as? Int
         totalPrice = aDecoder.decodeObject(forKey: "totalPrice") as? FinalizeOrderDeliveryCost
         totalPriceWithTax = aDecoder.decodeObject(forKey: "totalPriceWithTax") as? FinalizeOrderDeliveryCost
         totalTax = aDecoder.decodeObject(forKey: "totalTax") as? FinalizeOrderOrderDiscount
         type = aDecoder.decodeObject(forKey: "type") as? String
         unconsignedEntries = aDecoder.decodeObject(forKey: "unconsignedEntries") as? [FinalizeOrderEntry]
         user = aDecoder.decodeObject(forKey: "user") as? FinalizeOrderUser

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if appliedOrderPromotions != nil{
			aCoder.encode(appliedOrderPromotions, forKey: "appliedOrderPromotions")
		}
		if appliedProductPromotions != nil{
			aCoder.encode(appliedProductPromotions, forKey: "appliedProductPromotions")
		}
		if appliedVouchers != nil{
			aCoder.encode(appliedVouchers, forKey: "appliedVouchers")
		}
		if calculated != nil{
			aCoder.encode(calculated, forKey: "calculated")
		}
		if code != nil{
			aCoder.encode(code, forKey: "code")
		}
		if consignments != nil{
			aCoder.encode(consignments, forKey: "consignments")
		}
		if created != nil{
			aCoder.encode(created, forKey: "created")
		}
		if deliveryAddress != nil{
			aCoder.encode(deliveryAddress, forKey: "deliveryAddress")
		}
		if deliveryCost != nil{
			aCoder.encode(deliveryCost, forKey: "deliveryCost")
		}
		if deliveryItemsQuantity != nil{
			aCoder.encode(deliveryItemsQuantity, forKey: "deliveryItemsQuantity")
		}
		if deliveryMode != nil{
			aCoder.encode(deliveryMode, forKey: "deliveryMode")
		}
		if deliveryOrderGroups != nil{
			aCoder.encode(deliveryOrderGroups, forKey: "deliveryOrderGroups")
		}
		if entries != nil{
			aCoder.encode(entries, forKey: "entries")
		}
		if guestCustomer != nil{
			aCoder.encode(guestCustomer, forKey: "guestCustomer")
		}
		if guid != nil{
			aCoder.encode(guid, forKey: "guid")
		}
		if net != nil{
			aCoder.encode(net, forKey: "net")
		}
		if orderDiscounts != nil{
			aCoder.encode(orderDiscounts, forKey: "orderDiscounts")
		}
		if pickupItemsQuantity != nil{
			aCoder.encode(pickupItemsQuantity, forKey: "pickupItemsQuantity")
		}
		if pickupOrderGroups != nil{
			aCoder.encode(pickupOrderGroups, forKey: "pickupOrderGroups")
		}
		if productDiscounts != nil{
			aCoder.encode(productDiscounts, forKey: "productDiscounts")
		}
		if site != nil{
			aCoder.encode(site, forKey: "site")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if statusDisplay != nil{
			aCoder.encode(statusDisplay, forKey: "statusDisplay")
		}
		if store != nil{
			aCoder.encode(store, forKey: "store")
		}
		if subTotal != nil{
			aCoder.encode(subTotal, forKey: "subTotal")
		}
		if totalDiscounts != nil{
			aCoder.encode(totalDiscounts, forKey: "totalDiscounts")
		}
		if totalItems != nil{
			aCoder.encode(totalItems, forKey: "totalItems")
		}
		if totalPrice != nil{
			aCoder.encode(totalPrice, forKey: "totalPrice")
		}
		if totalPriceWithTax != nil{
			aCoder.encode(totalPriceWithTax, forKey: "totalPriceWithTax")
		}
		if totalTax != nil{
			aCoder.encode(totalTax, forKey: "totalTax")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}
		if unconsignedEntries != nil{
			aCoder.encode(unconsignedEntries, forKey: "unconsignedEntries")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}
