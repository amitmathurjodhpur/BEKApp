//
//  HTTPClient.swift
//
//  Created by Bhavik Barot on 27/07/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation

struct HTTPClient {
    
//    static let urlCOMMERCE_SITENAME = "COMMERCE_SITENAME"
    enum BaseURL: String {
        case Development = "https://bek.usdemo.hybris.com"
        case Production = "Production"
    }
    
    enum  Authentication: String {
        case Login = "/authorizationserver/oauth/token"
    }
    
    enum Products: String {
//        case ProductList = "/rest/v2/powertools/products/search?fields=FULL,products(images,price,baseOptions)&query=::allCategories:BEK&pageSize=100"
        case ProductList = "/rest/v2/powertools/categories/BEK/products-cx/?fields=FULL,products(images,price,priceRange,baseOptions,categories,cost,pack,packageSize)&pageSize=100"
    }
    
//    enum Carts: String {
//        case CreateCart = "/rest/v2/powertools/users/carts/"
//    }
    
    /**
     Constructing API URL
     - Authors:
     - Created By - Bhavik Barot
     - Modified By -  author name
     - Date:
     - Created At - 27/07/18
     - Modified At - date
     - Version: version
     - Remark: remark
     */
    func createEndPoint(baseURL:String = BaseURL.Development.rawValue , endPoint: String) -> String {
        return baseURL + endPoint
    }
}
