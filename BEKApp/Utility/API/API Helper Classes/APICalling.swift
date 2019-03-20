//
//  APICalling.swift
//
//  Created by Bhavik Barot on 03/09/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import ObjectMapper


/**
 This custom object is having the methods which is used for the calling the POST and GET APIs.
 - Authors:
 - Created By - Bhavik Barot
 - Modified By - Bhavik Barot
 - Date:
 - Created At - 26/07/18
 - Modified At - date
 - Version: 1.0
 - Remark: nil.
 */

enum MultipartFormType {
    case multipartUploadWithPost
    case multipartUploadWithGet
    case multipartUploadWithPut
    case multipartUploadWithDelete
    case multipartDownloadWithPost
    case multipartDownloadWithGet
    case multipartDownloadWithPut
    case multipartDownloadWithDelete
}

class APICalling: NSObject {
    
    typealias successCompletion = (_ responseData: Any?,_ message: String) -> Void
    typealias errorCompletion = (_ isNetOn: Bool, _ message: String) -> Void
    typealias progressCompltetion = (_ progress: Double) -> Void
    
    public static let shared: APICalling = {
        return APICalling()
    }()
    
    func callPostAPI<T: Mappable>(RequestDic reqDic: [String:Any], URL url: String, HTTPHeaders headers: HTTPHeaders? = nil, IsHeaderWithAuth isAuth: Bool, ModelClass mapper: T.Type, onSuccess success: @escaping successCompletion, onError error: @escaping errorCompletion) {
        if isAuth {
            var header: HTTPHeaders?
            if headers == nil {
                header = [
                    APIKeyConstant.kAuthorization : "Bearer \(UserDefaultsManager.shardInstance.authToken)",
                    "Content-Type": "application/json"
                ]
            }
            else {
                 header = headers
            }
            print("request dictionary : \(reqDic)\nURL : \(url)")
            APIHelperWithAuth.APICall(reqDic: reqDic, url: url, headers: header) { (resObj, isError, isNetOn) in
                print("response : \(String(describing: resObj))")
                self.postProcess(ResponseObj: resObj, Mapper: T.self, IsError: isError, IsNetOn: isNetOn, Success: success, Error: error)
            }
        }
        else {
            let header: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            print("request dictionary : \(reqDic)\nURL : \(url)")

            APIHelper.APICall(reqDic: reqDic, url: url, headers: header) { (resObj, isError, isNetOn) in
                print("response : \(String(describing: resObj))")
                self.postProcess(ResponseObj: resObj, Mapper: T.self, IsError: isError, IsNetOn: isNetOn, Success: success, Error: error)
            }
        }
    }
    
    func callGetAPI<T: Mappable>(RequestDic reqDic: [String:Any], URL url: String, HTTPHeaders headers: HTTPHeaders? = nil, IsHeaderWithAuth isAuth: Bool, ModelClass mapper: T.Type, onSuccess success: @escaping successCompletion, onError error: @escaping errorCompletion) {
        
        var urlStringForGet = String()

        var urlComponentArr:[String] = []
        urlComponentArr.append(url)
        for item in reqDic {
            if urlComponentArr.count == 1 {                
                urlComponentArr.append("?\(item.key)=\(item.value)")
            }
            else {
                urlComponentArr.append("&\(item.key)=\(item.value)")
            }
        }
        
        for item in urlComponentArr {
            urlStringForGet = urlStringForGet + "\(item)"
        }
        
        if isAuth {
            var header: HTTPHeaders?
            if headers == nil {
                header = [
                    APIKeyConstant.kAuthorization : "Bearer \(UserDefaultsManager.shardInstance.authToken)",
                    "Content-Type": "application/json"
                ]
            }
            else {
                header = headers
            }
            print("request dictionary : \(reqDic)\nURL : \(urlStringForGet)")
            APIHelperWithAuth.GetAPICall(reqDic: reqDic, url: urlStringForGet, headers: header) { (resObj, isError, isNetOn) in
                print("response : \(String(describing: resObj))")
                self.postProcess(ResponseObj: resObj, Mapper: T.self, IsError: isError, IsNetOn: isNetOn, Success: success, Error: error)
            }
        }
        else {
            let header: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            print("request dictionary : \(reqDic)\nURL : \(urlStringForGet)")
            APIHelper.GetAPICall(reqDic: reqDic, url: urlStringForGet, headers: header) { (resObj, isError, isNetOn) in
                print("response : \(String(describing: resObj))")
                self.postProcess(ResponseObj: resObj, Mapper: T.self, IsError: isError, IsNetOn: isNetOn, Success: success, Error: error)
            }
        }
    }
    
    func callPutAPI<T: Mappable>(RequestDic reqDic: [String:Any], URL url: String, HTTPHeaders headers: HTTPHeaders? = nil, IsHeaderWithAuth isAuth: Bool, ModelClass mapper: T.Type, onSuccess success: @escaping successCompletion, onError error: @escaping errorCompletion) {
        if isAuth {
            var header: HTTPHeaders?
            if headers == nil {
                header = [
                    APIKeyConstant.kAuthorization : "Bearer \(UserDefaultsManager.shardInstance.authToken)",
                    "Content-Type": "application/json"
                ]
            }
            else {
                header = headers
            }

            APIHelperWithAuth.PutAPICall(reqDic: reqDic, url: url, headers: header) { (resObj, isError, isNetOn) in
                print("request dictionary : \(reqDic)\nURL : \(url)")
                print("response : \(String(describing: resObj))")

                self.postProcess(ResponseObj: resObj, Mapper: T.self, IsError: isError, IsNetOn: isNetOn, Success: success, Error: error)
            }
        }
        else {
            let header: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            APIHelper.PutAPICall(reqDic: reqDic, url: url, headers: header) { (resObj, isError, isNetOn) in
                print("request dictionary : \(reqDic)\nURL : \(url)")
                print("response : \(String(describing: resObj))")
                self.postProcess(ResponseObj: resObj, Mapper: T.self, IsError: isError, IsNetOn: isNetOn, Success: success, Error: error)
            }
        }
    }
    
    func callDeleteAPI<T: Mappable>(RequestDic reqDic: [String:Any], URL url: String, HTTPHeaders headers: HTTPHeaders? = nil, IsHeaderWithAuth isAuth: Bool, ModelClass mapper: T.Type, onSuccess success: @escaping successCompletion, onError error: @escaping errorCompletion) {
        if isAuth {
            var header: HTTPHeaders?
            if headers == nil {
                header = [
                    APIKeyConstant.kAuthorization : "Bearer \(UserDefaultsManager.shardInstance.authToken)",
                    "Content-Type": "application/json"
                ]
            }
            else {
                header = headers
            }
            
            APIHelperWithAuth.DeleteAPICall(reqDic: reqDic, url: url, headers: header) { (resObj, isError, isNetOn) in
                print("request dictionary : \(reqDic)\nURL : \(url)")
                print("response : \(String(describing: resObj))")
                self.postProcess(ResponseObj: resObj, Mapper: T.self, IsError: isError, IsNetOn: isNetOn, Success: success, Error: error)
            }
        }
        else {
            let header: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            APIHelper.DeleteAPICall(reqDic: reqDic, url: url, headers: header) { (resObj, isError, isNetOn) in
                print("request dictionary : \(reqDic)\nURL : \(url)")
                print("response : \(String(describing: resObj))")
                self.postProcess(ResponseObj: resObj, Mapper: T.self, IsError: isError, IsNetOn: isNetOn, Success: success, Error: error)
            }
        }
    }
    
    private func postProcess<T: Mappable>(ResponseObj resObj: [String:Any]?,Mapper mapper: T.Type, IsError isError: Bool, IsNetOn isNetOn: Bool,Success success: @escaping successCompletion, Error error: @escaping errorCompletion) {
        if resObj == nil {
            error(isNetOn,Constants.kUnknownWarning)
        }
        else {
            GetMapperModel.shared.getMapper(mapper: T.self, resObj, completion: { (resObj) in
                FilterDataResponse.shared.filterData(mapper: T.self, ResObj: resObj, IsError: isError, IsNetOn: isNetOn, onSuccess: { (dataObj, message) in
                    success(dataObj,message)
                }, onError: { (isNetOn, message) in
                    error(isNetOn, message)
                })
            })
        }
    }
}
