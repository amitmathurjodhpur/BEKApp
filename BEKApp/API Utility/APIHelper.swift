//
//  APIHelper.swift
//  BEKApp
//
//  Created by Bhavik on 09/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class APIHelper: NSObject {
    
    static let shared = APIHelper()
    
    private var resDic = [String: Any]()
    
    public func post(request reqDic: [String: Any] ,to url: String,withAuth isAuth: Bool! = true, completion: @escaping (_ Response: [String: Any],_ isError: Bool, _ isNetOn: Bool) -> ()) {
        
        let parameters:Parameters = reqDic
        
        var header: HTTPHeaders?
        
        if isAuth {
            header = [
                "Authorization": "Bearer "+"\(UserDefaultsManager.shared.authToken)",
                "Content-Type": "application/json"
            ]
        }
        else {
            header = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        
        if let theJSONData = try? JSONSerialization.data(withJSONObject: reqDic, options: []) {
            let theJSONText = String(data: theJSONData,  encoding: .ascii)
            print("JSON string = \(theJSONText!)")
        }
        
        let isNetActive = CheckNetwork.checkStatus()
        if isNetActive {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(URL(string: url)!, method: .post, parameters: parameters, encoding: URLEncoding.default,headers : header).responseJSON { response in
                
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("Response: \(json)")
                }
                
                guard let dic = response.result.value as! [String:Any]! else {
                    completion(self.resDic,true,true)
                    return
                }
                self.resDic = dic
                completion(self.resDic,false,true)
            }
            
//            manager.request(
//                URL(string: url)!,
//                method: .post,
//                parameters:parameters,
//                headers : header)
//                .responseJSON { (response) -> Void in
//                    guard let dic = response.result.value as! [String:Any]! else {
//                        completion(self.resDic,true,true)
//                        return
//                    }
//                    self.resDic = dic
//                    completion(self.resDic,false,true)
//            }
            
        }
        else {
            completion(self.resDic,true,false)
        }
    }
    
    public func get(request reqDic: [String: Any] ,to url: String,withAuth isAuth: Bool! = true, completion: @escaping (_ Response: [String: Any],_ isError: Bool, _ isNetOn: Bool) -> ()) {
        
        let parameters:Parameters = reqDic
        
        var header: HTTPHeaders?
        
        if isAuth {
            header = [
                "Authorization": "Bearer "+"\(UserDefaultsManager.shared.authToken)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        else {
            header = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        
        let isNetActive = CheckNetwork.checkStatus()
        if isNetActive {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(
                URL(string: url)!,
                method: .get,
                parameters:parameters,
                headers : header)
                .responseJSON { (response) -> Void in
                    guard let dic = response.result.value as! [String:Any]! else {
                        completion(self.resDic,true,true)
                        return
                    }
                    self.resDic = dic
                    completion(self.resDic,false,true)
            }
        }
        else {
            completion(self.resDic,true,false)
        }
    }
    
    public func put(request reqDic: [String: Any] ,to url: String,withAuth isAuth: Bool! = true, completion: @escaping (_ Response: [String: Any],_ isError: Bool, _ isNetOn: Bool) -> ()) {
        
        let parameters:Parameters = reqDic
        
        var header: HTTPHeaders?
        
        if isAuth {
            header = [
                "Authorization": "Bearer "+"\(UserDefaultsManager.shared.authToken)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        else {
            header = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        
        let isNetActive = CheckNetwork.checkStatus()
        if isNetActive {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(
                URL(string: url) ?? "",
                method: .put,
                parameters:parameters,
                headers : header)
                .responseJSON { (response) -> Void in
                    if let statusCode = response.response?.statusCode, statusCode == 200 {
                        if let responseData = response.result.value as? [String:Any] {
                            self.resDic = responseData
                            completion(self.resDic,false,true)
                            return
                        } else {
                            completion([:],false,true)
                            return
                        }
                    } else {
                        completion(self.resDic,true,true)
                        return
                    }
                    /*guard let dic = response.result.value as! [String:Any]! else {
                        completion(self.resDic,true,true)
                        return
                    }
                    self.resDic = dic
                    completion(self.resDic,false,true)*/
            }
        }
        else {
            completion(self.resDic,true,false)
        }
    }
    
    public func delete(request reqDic: [String: Any] ,to url: String,withAuth isAuth: Bool! = true, completion: @escaping (_ Response: [String: Any],_ isError: Bool, _ isNetOn: Bool) -> ()) {
        
        let parameters:Parameters = reqDic
        
        var header: HTTPHeaders?
        
        if isAuth {
            header = [
                "Authorization": "Bearer "+"\(UserDefaultsManager.shared.authToken)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        else {
            header = [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        
        let isNetActive = CheckNetwork.checkStatus()
        if isNetActive {
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 300
            manager.request(
                URL(string: url)!,
                method: .delete,
                parameters:parameters,
                headers : header)
                .responseJSON { (response) -> Void in
                    guard let dic = response.result.value as! [String:Any]! else {
                        completion(self.resDic,true,true)
                        return
                    }
                    self.resDic = dic
                    completion(self.resDic,false,true)
            }
        }
        else {
            completion(self.resDic,true,false)
        }
    }
}
