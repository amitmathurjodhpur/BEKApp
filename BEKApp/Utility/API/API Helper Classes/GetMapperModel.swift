//
//  GetMapperModel.swift
//
//  Created by Bhavik Barot on 29/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

/**
 This custom object is used for mapping json to the object of the api models.
 - Authors:
 - Created By - Bhavik Barot
 - Modified By - Bhavik Barot
 - Date:
 - Created At - 29/08/18
 - Modified At - date
 - Version: 1.0
 - Remark: nil.
 */
class GetMapperModel: NSObject {
    public static let shared: GetMapperModel = {
        return GetMapperModel()
    }()
    
    func getMapper<T: Mappable>(mapper: T.Type, _ resObj: [String: Any]?, completion:  @escaping (_ result: T?) -> Void){
        if let responseMapper = T(JSON: resObj!) {
            completion(responseMapper)
        }
        else {
            completion(nil)
        }
    }
}
