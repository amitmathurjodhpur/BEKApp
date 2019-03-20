//
//  UIButton+Extension.swift
//  Arya
//
//  Created by Bhavik Barot on 01/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func setBorderWithRadius(borderWidth: CGFloat = 1, borderColor: UIColor = UIColor.white, cornerRadius: CGFloat) {
        
        self.clipsToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
    }
}
