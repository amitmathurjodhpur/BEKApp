//
//  UIView+Extension.swift
//  Arya
//
//  Created by Bhavik Barot on 24/09/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    public func roundCorners(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
    }
    
    public func addViewShadow() {
        DispatchQueue.main.asyncAfter(deadline: (.now() + 0.2)) {
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 12, height: 12)).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor(red:0.71, green:0.8, blue:0.89, alpha:0.5).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: -2)
            shadowLayer.shadowOpacity = 1.0
            shadowLayer.shadowRadius = 4
            self.layer.insertSublayer(shadowLayer, at: 0)

        }
    }
}
