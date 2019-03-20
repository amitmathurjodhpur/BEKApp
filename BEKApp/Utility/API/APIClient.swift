//
//  LoginService.swift
//  Arya
//
//  Created by Bhavik Barot on 27/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import ObjectMapper

/**
 This custom object is having the methods which is having the different different API Calling function from the api is called.
 - Authors:
 - Created By - Bhavik Barot
 - Modified By - Bhavik Barot
 - Date:
 - Created At - 26/07/18
 - Modified At - date
 - Version: 1.0
 - Remark: nil.
 */
class APIClient: NSObject {
    
    typealias successCompletion = (_ resData: Any?,_ message: String) -> Void
    typealias errorCompletion = (_ isNetOn: Bool, _ message: String) -> Void
    
    public static let shared: APIClient = {
        return APIClient()
    }()
    
    private func postProcess<T: Mappable>(IsPostAPI isPostAPI: Bool! = true, RequestDic reqDic: [String:Any], URL url: String, HTTPHeaders headers: HTTPHeaders? = nil, IsHeaderWithAuth isAuth: Bool, ModelClass mapper: T.Type, onSuccess success: @escaping successCompletion, onError error: @escaping errorCompletion) {
        
        if isPostAPI {
            APICalling.shared.callPostAPI(RequestDic: reqDic, URL: url, HTTPHeaders: headers, IsHeaderWithAuth: isAuth, ModelClass: T.self, onSuccess: { (dataObj, message) in
                success(dataObj as! T, message)
            }) { (isNetOn, message) in
                error(isNetOn, message)
            }
        }
        else {
            APICalling.shared.callGetAPI(RequestDic: reqDic, URL: url, HTTPHeaders: headers, IsHeaderWithAuth: isAuth, ModelClass: T.self, onSuccess: { (dataObj, message) in
                success(dataObj, message)
            }) { (isNetOn, message) in
                error(isNetOn, message)
            }
        }
    }
    
    // MARK: - User Specific API
    
    func loginApiCall(Email email: String, withPassword pass: String, withDeviceType deviceType: String, withPushToken pushToken: String, andDeviceID deviceID: String, onSuccess success: @escaping (_ resObj: LoginData?,_ message: String) -> (), onError error: @escaping errorCompletion) {
        var reqDic = [String:Any]()
        reqDic[APIKeyConstant.kEmail] = email
        reqDic[APIKeyConstant.kPassword] = pass
        
        APICalling.shared.callPostAPI(RequestDic: reqDic, URL: HTTPClient().createEndPoint(endPoint: HTTPClient.APIEndPoint.LoginApi), HTTPHeaders: nil, IsHeaderWithAuth: false, ModelClass: LoginRequest.self, onSuccess: { (dataObj, message) in
            success(dataObj as? LoginData, message)
        }) { (isNetOn, message) in
            error(isNetOn, message)
        }
    }
}
