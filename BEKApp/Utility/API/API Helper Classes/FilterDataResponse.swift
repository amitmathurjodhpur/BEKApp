//
//  FilterDataResponse.swift
//
//  Created by Bhavik Barot on 29/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper


/**
 This custom object is used for filtering the errors and objects and data response and give back as error completion or success completion with the proper message and data object dynamicaly.
 - Authors:
 - Created By - Bhavik Barot
 - Modified By - Bhavik Barot
 - Date:
 - Created At - 29/08/18
 - Modified At - date
 - Version: 1.0
 - Remark: nil.
 */
class FilterDataResponse: NSObject {
    
    public static let shared: FilterDataResponse = {
        return FilterDataResponse()
    }()
    
    func filterData<T: Mappable>(mapper: T.Type, ResObj resObj: Any?,IsError isError: Bool,IsNetOn isNetOn: Bool, onSuccess success: @escaping (_ resData: Any?,_ message: String) -> (), onError error: @escaping (_ isNetOn: Bool, _ message: String) -> ()) {
        self.filterDataPostProcess(mapper: T.self, ResObj: resObj, IsError: isError,   IsNetOn: isNetOn, onSuccess: { (responseData, message) in
            success(responseData, message)
        }, onError: { (isNetOn, message) in
            error(isNetOn, message)
        })
    }
    
    private func filterDataPostProcess<T>(mapper: T.Type, ResObj resObj: Any?,IsError isError: Bool,IsNetOn isNetOn: Bool, onSuccess success: @escaping (_ resData: Any?,_ message: String) -> (), onError error: @escaping (_ isNetOn: Bool, _ message: String) -> ()) {
        let baseStructure = BaseAPIStructureModel()
        if isNetOn {
            if isError {
                if resObj == nil {
                    error(isNetOn,Constants.kUnknownWarning)
                }
                else {
                    let obj = resObj as! T
                    let objMirror = Mirror(reflecting: obj)
                    for case let (label?, value) in objMirror.children {
                        if label == APIKeyConstant.kSuccess {
                            baseStructure.success = value as? String
                        }
                        else if label == APIKeyConstant.kData {
                            baseStructure.data = value
                        }
                        else {
                            baseStructure.message = value as? String
                        }
                    }
                    error(isNetOn,baseStructure.message!)
                }
            }
            else {
                let obj = resObj as! T
                let objMirror = Mirror(reflecting: obj)
                for case let (label?, value) in objMirror.children {
                    if label == APIKeyConstant.kSuccess {
                        baseStructure.success = value as? String
                    }
                    else if label == APIKeyConstant.kData {
                        baseStructure.data = value
                    }
                    else {
                        baseStructure.message = value as? String
                    }
                }
                success(baseStructure.data,baseStructure.message!)
            }
        }
        else {
            error(isNetOn,Constants.kInternetWarning)
        }
    }
}
