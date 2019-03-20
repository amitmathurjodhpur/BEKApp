//
//  HTTPClient.swift
//  Arya
//
//  Created by Bhavik on 27/07/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation

struct HTTPClient {
    
    enum BaseURL: String {
        case Devlopment = "Development"
        case Production = "Production"
    }
    
    enum  EndPoints: String {
        case SubmitBasalTemprature = "/submit-basal-temprature"
    }
    
    /**
     Constructing API URL
     - Authors:
     - Created By - Bhavik
     - Modified By -  author name
     - Date:
     - Created At - 27/07/18
     - Modified At - date
     - Version: version
     - Remark: remark
     */
    func createEndPoint(baseURL:String = BaseURL.DevAuthencation.rawValue , endPoint: String) -> String {
        return baseURL + endPoint
    }
}
