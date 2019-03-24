//
//  CommonUtilitiesClass.swift
//
//  Created by Bhavik Barot on 19/07/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit

/**
 This class is used for create common methods which used in project.
 - Authors:
 - Created By - Bhavik Barot
 - Modified By - nil
 - Date:
 - Created At - 20/07/2018
 - Modified At - nil
 - Version: 1.0
 - Remark: nil
 */
class CommonUtilitiesClass: NSObject {
    
    static let shared = CommonUtilitiesClass()
    
    /**
     This method used for validate email address based on regEx pattern.
     - Authors:
        - Created By - Bhavik Barot
        - Modified By - nil
     - Date:
        - Created At - 20/07/2018
        - Modified At - nil
     - Version: 1.0
     - Remark: nil
     */
   public func validEmailAddress(_ emailString: String) -> Bool {
    let regExPattern: String = Constants.kREG_EX_FOR_EMAIL
        let regEx = try? NSRegularExpression(pattern: regExPattern, options: .caseInsensitive)
        let regExMatches: Int? = regEx?.numberOfMatches(in: emailString, options: [], range: NSRange(location: 0, length: (emailString.count)))
        if regExMatches == 0 {
            return false
        }
        else {
            return true
        }
    }
//    /**
//     This method used for validate password based on regEx pattern.
//     - Authors:
//     - Created By - Bhavik Barot
//     - Modified By - nil
//     - Date:
//     - Created At - 20/07/2018
//     - Modified At - nil
//     - Version: 1.0
//     - Remark: nil
//     */
//    public func validPasswordFormat(_ pwdString: String) -> Bool {
//        let regExPattern: String = Constants.kREG_EX_FOR_PASSWORD
//        let regEx = try? NSRegularExpression(pattern: regExPattern, options: .caseInsensitive)
//        let regExMatches: Int? = regEx?.numberOfMatches(in: pwdString, options: [], range: NSRange(location: 0, length: (pwdString.count)))
//        if regExMatches == 0 {
//            return false
//        }
//        else {
//            return true
//        }
//    }
    
    public func setHotelData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: appDelegate.hotelDetails)
        userDefaults.set(encodedData, forKey: "hotelData")
        userDefaults.synchronize()
    }
    
    public func getHotelData() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let data = UserDefaults.standard.object(forKey: "hotelData") as? NSData, let decodedData = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? HotelListModel {
            appDelegate.hotelDetails = decodedData
            return true
        }
        return false
    }
}
