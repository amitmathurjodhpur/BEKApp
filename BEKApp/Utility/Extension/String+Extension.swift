//
//  String+Extension.swift
//  Arya
//
//  Created by Bhavik Barot on 28/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    func isValidEmail() -> Bool {
        
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let kREG_EX_FOR_PASSWORD = "^.*(?=.{8,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!@#$%^&*()_-]).*$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", kREG_EX_FOR_PASSWORD)
        return passwordTest.evaluate(with: self)
    }
    
    
    
    
    func substring(with nsrange: NSRange) -> Substring? {
        guard let range = Range(nsrange, in: self) else { return nil }
        return self[range]
    }
    
    func toLengthOf(length:Int) -> String {
        if length <= 0 {
            return self
        } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
            return String(self[to])
            
        } else {
            return ""
        }
    }
    
    func getDateInAppFormateFromAPI() -> String? {
        let splitString = self.components(separatedBy: "T")
        return splitString[0]
    }
    
    func getDateInAPIFormateFromApp() -> String? {
        return self + "T00:00:00.000Z"
    }
    
    func formattedDate() -> String? {
        
        let dateFormattor = DateFormatter()
        dateFormattor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        var date = dateFormattor.date(from: self)
        if date == nil {
            dateFormattor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        }
        date = dateFormattor.date(from: self)
        dateFormattor.dateFormat = "dd-MM-yy"
        return dateFormattor.string(from: date!)
    }

    func formattedBirthdate() -> String? {

        let dateFormattor = DateFormatter()
        dateFormattor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormattor.date(from: self)
        dateFormattor.dateFormat = "dd MMM YYYY"
        return dateFormattor.string(from: date!)
    }

    func iso8601FormattedDate() -> String? {
        
        let dateFormattor = DateFormatter()
        dateFormattor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormattor.date(from: self)
        dateFormattor.dateFormat = "yyyy-MM-dd"
        return dateFormattor.string(from: date!)
    }
    
    func formattedAppointmentDate() -> String? {
        
        let dateFormattor = DateFormatter()
        dateFormattor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormattor.date(from: self)
        dateFormattor.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormattor.string(from: date!)
    }
    
    func formattedAppointmentPickerDate() -> Date {

        let dateFormattor = DateFormatter()
        dateFormattor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormattor.date(from: self)
        dateFormattor.dateFormat = "dd-MM-yyyy HH:mm"
        let dateString = dateFormattor.string(from: date!)
        return dateFormattor.date(from: dateString)!
    }
    
    
    func getHeight(width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: 2000)
        let boundingBox = self.boundingRect(
            with: size,
            options: [.usesLineFragmentOrigin, .usesFontLeading, .usesDeviceMetrics],
            context: nil
        )
        return boundingBox.height
    }
    func getWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
//    func frame(forText text: String?, sizeWith font: UIFont?, constrainedTo size: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
//        
//        let paragraphStyle = NSMutableParagraphStyle.default as? NSMutableParagraphStyle
//        paragraphStyle?.lineBreakMode = lineBreakMode
//        
//        var attributes: [AnyHashable : Any]
//        
//        if font != nil {
//            if let aFont = font, let aStyle = paragraphStyle {
//                attributes = [NSAttributedString.Key.font: aFont, NSAttributedString.Key.paragraphStyle: aStyle]
//            }
//        } else {
//            if let aStyle = paragraphStyle {
//                attributes = [NSAttributedString.Key.paragraphStyle: aStyle]
//            }
//        }
//        
//        
//        let textRect: CGRect? = text?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: (attributes as! [NSAttributedStringKey : Any]), context: nil)
//        
//        return textRect!.size
//    }
    
}
/**
 This extension is use for converting html string to the attributed string.
 - Authors:
 - Created By - Bhavik Barot
 - Modified By - nil
 - Date:
 - Created At - 1/08/2018
 - Modified At - nil
 - Version: 1.0
 - Remark: nil
 */
extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

