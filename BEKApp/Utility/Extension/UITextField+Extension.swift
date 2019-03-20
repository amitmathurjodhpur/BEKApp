//
//  UITextField+Extension.swift
//  Arya
//
//  Created by Bhavik Barot on 01/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setWhitePlaceholder(fontSize: CGFloat) {
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)])
    }
    func setBlackPlaceholder(fontSize: CGFloat) {
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)])
    }

    /*-----------------------------------------------------
     Method name  : shouldChangeCharactersInRange
     Created By   : 103
     Version      : 1
     Purpose      : This method will format the phone number text, this method will be called every time when user type characters in textfield
     reference formate :- +1-123-123-1234
     -------------------------------------------------------*/
    func setPhoneNumberFormat(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            return true
        }

        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let components = newString.components(separatedBy: CharacterSet.decimalDigits.inverted)
        
        let decimalString = components.joined(separator: "") as NSString
        let length = decimalString.length
        let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
        
        if length == 0 || (length > 11 && !hasLeadingOne) || length > 12
        {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
            
            if newLength > 10
            {
                return false
            }
            
            let numberOnly = NSCharacterSet.init(charactersIn: "0123456789")
            let stringFromTextField = NSCharacterSet.init(charactersIn: string)
            let strValid = numberOnly.isSuperset(of: stringFromTextField as CharacterSet)
            
            return strValid
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if hasLeadingOne
        {
            formattedString.append("1 ")
            index += 1
        }
        if (length - index) > 3
        {
            let countryCode = decimalString.substring(with: NSMakeRange(index, 1))
            let areaCode = decimalString.substring(with: NSMakeRange(1, 3))
            formattedString.appendFormat("+%@-%@-", countryCode,areaCode)
            index += 4
        }
        if length - index > 3
        {
            let prefix = decimalString.substring(with: NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalString.substring(from: index)
        formattedString.append(remainder)
        textField.text = formattedString as String
        
        //changes related to : New user registration does not appear to limit max. characters for fields
        if (textField.text?.count == 15 && range.length == 0)
        {
            return false
        }
        else
        {
            return false
        }
    }
}
