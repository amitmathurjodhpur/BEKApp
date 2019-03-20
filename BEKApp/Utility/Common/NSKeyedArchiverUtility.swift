//
//  NSKeyedArchiverUtility.swift
//
//  Created by Bhavik Barot on 26/07/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit

/**
 This custom object is having the methods which is used for the archiving encode and decode operations.
 - Authors:
 - Created By - Bhavik Barot
 - Modified By - Bhavik Barot
 - Date:
 - Created At - 26/07/18
 - Modified At - date
 - Version: 1.0
 - Remark: nil.
 */

class NSKeyedArchiverUtility: NSObject {

    class func encodeObject(_ obj: Any) -> Data {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: obj)
        return encodedData
    }
    class func decodeObject(_ data: Data) -> Any {
        let decodedObj = NSKeyedUnarchiver.unarchiveObject(with: data) as Any
        return decodedObj
    }
}

//class NSKeyedArchiverUtility: NSObject {
//
//    class func encodeObject(_ obj: Any?) -> Data {
//        var filePath : String {
//            let manager = FileManager.default
//            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
//            return (url!.appendingPathComponent("File").path)
//        }
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: obj as Any)
////        let encodedData: Data =
//        return encodedData
//    }
//    class func decodeObject(_ data: Data) -> Any {
//        var filePath : String {
//            let manager = FileManager.default
//            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
//            return (url!.appendingPathComponent("File").path)
//        }
//        let decodedObj = NSKeyedUnarchiver.unarchiveObject(with: data) as Any
//        return decodedObj
//    }
//}
