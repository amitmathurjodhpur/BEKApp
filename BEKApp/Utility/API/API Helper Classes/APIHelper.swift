//
//  APIHelper.swift
//
//  Created by Bhavik Barot on 26/07/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class APIHelper: NSObject {
    /**
     This method used for getting response from the service and call back to the controller and provide the response object.
     - Authors:
     - Created By - Bhavik Barot
     - Modified By - nil
     - Date:
     - Created At - 26/07/2018
     - Modified At - nil
     - Version: 1.0
     - Remark: nil
     */
    
    
    //MARK:- Post API Call
    class func APICall(reqDic: [String:Any] ,url: String,headers:HTTPHeaders? = nil, completion: @escaping (_ Response: [String:Any]?,_ isError: Bool, _ isNetOn: Bool) -> ()) {
        var resDic: [String:Any]?
        let parameters:Parameters = reqDic
        print(parameters)
        let checkNet = CheckNetworkUtility()
        let isNetActive = checkNet.checkStatus()
        if isNetActive {
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(
                URL(string: url)!,
                method: .post,
                parameters:parameters,
                encoding: JSONEncoding.default,
                headers : headers)
                .validate(statusCode: 200..<600)
                .responseJSON { (response) -> Void in
                    switch response.result {
                    case .success:
                        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300 {
                            guard let dic = response.result.value as! [String:Any]? else {
                                completion(nil,true,true)
                                return
                            }
                            switch response.result {
                            case .success:
                                resDic = dic
                                completion(resDic,false,true)
                            case .failure:
                                completion(nil,true,true)
                            }
                        }
                        else {
                            switch response.result {
                            case .success:
                                break
                            case .failure:
                                completion(nil,true,true)
                            }
                            guard let dic = response.result.value as! [String:AnyObject]? else {
                                completion(nil,true,true)
                                return
                            }
                            resDic = dic
                            completion(resDic,true,true)
                        }
                    case .failure(let error):
                        let dic: [String:Any] = [:]
                        var resDicError: [String:Any] = [:]
                        resDicError[APIKeyConstant.kSuccess] = "false"
                        resDicError[APIKeyConstant.kData] = dic
                        resDicError[APIKeyConstant.kMessage] = error.localizedDescription
                        completion(resDicError,true,true)
                    }
            }
        }
        else {
            completion(nil,true,false)
        }
    }
    
    //MARK:- Get API Call
    class func GetAPICall(reqDic: [String:Any] ,url: String,headers:HTTPHeaders? = nil, completion: @escaping (_ Response: [String:Any]?,_ isError: Bool, _ isNetOn: Bool) -> ()) {
        
        var resDic: [String:Any]?
        let parameters:Parameters = reqDic
        print(parameters)
        let checkNet = CheckNetworkUtility()
        let isNetActive = checkNet.checkStatus()
        if isNetActive {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(
                URL(string: url)!,
                method: .get,
                parameters:nil,
                encoding: JSONEncoding.default,
                headers : headers)
                .validate(statusCode: 200..<600)
                .responseJSON { (response) -> Void in
                    switch response.result {
                    case .success:
                        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300 {
                            guard let dic = response.result.value as! [String:Any]? else {
                                completion(nil,true,true)
                                return
                            }
                            switch response.result {
                            case .success:
                                resDic = dic
                                completion(resDic,false,true)
                            case .failure:
                                completion(nil,true,true)
                            }
                        }
                        else {
                            switch response.result {
                            case .success:
                                break
                            case .failure:
                                completion(nil,true,true)
                            }
                            guard let dic = response.result.value as! [String:AnyObject]? else {
                                completion(nil,true,true)
                                return
                            }
                            resDic = dic
                            completion(resDic,true,true)
                        }
                    case .failure(let error):
                        let dic: [String:Any] = [:]
                        var resDicError: [String:Any] = [:]
                        resDicError[APIKeyConstant.kSuccess] = "false"
                        resDicError[APIKeyConstant.kData] = dic
                        resDicError[APIKeyConstant.kMessage] = error.localizedDescription
                        completion(resDicError,true,true)
                    }
            }
        }
        else {
            completion(nil,true,false)
        }
    }
    
    //MARK:- Put API Call
    class func PutAPICall(reqDic: [String:Any] ,url: String,headers:HTTPHeaders? = nil, completion: @escaping (_ Response: [String:Any]?,_ isError: Bool, _ isNetOn: Bool) -> ()) {
        
        var resDic: [String:Any]?
        let parameters:Parameters = reqDic
        print(parameters)
        let checkNet = CheckNetworkUtility()
        let isNetActive = checkNet.checkStatus()
        if isNetActive {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(
                URL(string: url)!,
                method: .put,
                parameters:nil,
                encoding: JSONEncoding.default,
                headers : headers)
                .validate(statusCode: 200..<600)
                .responseJSON { (response) -> Void in
                    switch response.result {
                    case .success:
                        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300 {
                            guard let dic = response.result.value as! [String:Any]? else {
                                completion(nil,true,true)
                                return
                            }
                            switch response.result {
                            case .success:
                                resDic = dic
                                completion(resDic,false,true)
                            case .failure:
                                completion(nil,true,true)
                            }
                        }
                        else {
                            switch response.result {
                            case .success: break
                            case .failure:
                                completion(nil,true,true)
                            }
                            guard let dic = response.result.value as! [String:AnyObject]? else {
                                completion(nil,true,true)
                                return
                            }
                            resDic = dic
                            completion(resDic,true,true)
                        }
                    case .failure(let error):
                        let dic: [String:Any] = [:]
                        var resDicError: [String:Any] = [:]
                        resDicError[APIKeyConstant.kSuccess] = "false"
                        resDicError[APIKeyConstant.kData] = dic
                        resDicError[APIKeyConstant.kMessage] = error.localizedDescription
                        completion(resDicError,true,true)
                    }
            }
        }
        else {
            completion(nil,true,false)
        }
    }
    
    //MARK:- Delete API Call
    class func DeleteAPICall(reqDic: [String:Any] ,url: String,headers:HTTPHeaders? = nil, completion: @escaping (_ Response: [String:Any]?,_ isError: Bool, _ isNetOn: Bool) -> ()) {
        
        var resDic: [String:Any]?
        let parameters:Parameters = reqDic
        print(parameters)
        let checkNet = CheckNetworkUtility()
        let isNetActive = checkNet.checkStatus()
        if isNetActive {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(
                URL(string: url)!,
                method: .delete,
                parameters:nil,
                encoding: JSONEncoding.default,
                headers : headers)
                .validate(statusCode: 200..<600)
                .responseJSON { (response) -> Void in
                    switch response.result {
                    case .success:
                        if (response.response?.statusCode)! >= 200 && (response.response?.statusCode)! < 300 {
                            guard let dic = response.result.value as! [String:Any]? else {
                                completion(nil,true,true)
                                return
                            }
                            switch response.result {
                            case .success:
                                resDic = dic
                                completion(resDic,false,true)
                            case .failure:
                                completion(nil,true,true)
                            }
                        }
                        else {
                            switch response.result {
                            case .success: break
                            case .failure:
                                completion(nil,true,true)
                            }
                            guard let dic = response.result.value as! [String:AnyObject]? else {
                                completion(nil,true,true)
                                return
                            }
                            resDic = dic
                            completion(resDic,true,true)
                        }
                    case .failure(let error):
                        let dic: [String:Any] = [:]
                        var resDicError: [String:Any] = [:]
                        resDicError[APIKeyConstant.kSuccess] = "false"
                        resDicError[APIKeyConstant.kData] = dic
                        resDicError[APIKeyConstant.kMessage] = error.localizedDescription
                        completion(resDicError,true,true)
                    }
            }
        }
        else {
            completion(nil,true,false)
        }
    }
}
