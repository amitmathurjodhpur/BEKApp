//
//  HotelListModel.swift
//  BEKApp
//
//  Created by Bhavik on 04/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class HotelListModel: NSObject, NSCoding {
    var hotelId: String!
    var hotelName: String!
    var hotelPhone: String!
    var hotelAddress: String!
    var hotelEmailId: String!
    
    init(with hotelId: String, hotelName: String, hotelPhone: String, hotelAddress: String, hotelEmailId: String) {
        self.hotelId = hotelId
        self.hotelName = hotelName
        self.hotelPhone = hotelPhone
        self.hotelAddress = hotelAddress
        self.hotelEmailId = hotelEmailId
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let hotelId = aDecoder.decodeObject(forKey: "hotelId") as! String
        let hotelName = aDecoder.decodeObject(forKey: "hotelName") as! String
        let hotelPhone = aDecoder.decodeObject(forKey: "hotelPhone") as! String
        let hotelAddress = aDecoder.decodeObject(forKey: "hotelAddress") as! String
        let hotelEmailId = aDecoder.decodeObject(forKey: "hotelEmailId") as! String
        self.init(with: hotelId, hotelName: hotelName, hotelPhone: hotelPhone, hotelAddress: hotelAddress, hotelEmailId: hotelEmailId)
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(hotelId, forKey: "hotelId")
        aCoder.encode(hotelName, forKey: "hotelName")
        aCoder.encode(hotelPhone, forKey: "hotelPhone")
        aCoder.encode(hotelAddress, forKey: "hotelAddress")
        aCoder.encode(hotelEmailId, forKey: "hotelEmailId")
    }
    public func setHotelData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: appDelegate.hotelDetails)
        userDefaults.set(encodedData, forKey: "hotelData")
        userDefaults.synchronize()
    }
    
    public func getHotelData() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let data = UserDefaults.standard.object(forKey: "hotelData") as? NSData, let decodedData = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? HotelListModel {
            appDelegate.hotelDetails = decodedData
            return true
        }
        return false
    }
}
