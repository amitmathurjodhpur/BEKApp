//
//  Double+Extension.swift
//  BEKApp
//
//  Created by Bhavik on 09/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
