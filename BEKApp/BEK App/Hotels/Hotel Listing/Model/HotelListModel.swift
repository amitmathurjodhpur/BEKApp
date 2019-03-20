//
//  HotelListModel.swift
//  BEKApp
//
//  Created by Bhavik on 04/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class HotelListModel: NSObject {
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
}
