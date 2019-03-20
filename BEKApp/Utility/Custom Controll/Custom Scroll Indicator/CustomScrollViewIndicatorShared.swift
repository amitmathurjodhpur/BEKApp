//
//  CustomScrollViewIndicatorShared.swift
//  BEKApp
//
//  Created by Bhavik on 06/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit
import Foundation

class CustomScrollViewIndicatorShared: NSObject {
    static let shared = CustomScrollViewIndicatorShared()
    open var customScrollIndicatorView: CustomScrollIndicatorView? = {
        if let customScroll = UINib(nibName: "CustomScrollIndicatorView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? CustomScrollIndicatorView {
            return customScroll
        }
        return nil
    }()
    
    func setupThemeIndicator() {
        self.customScrollIndicatorView?.indicatorColor = ColorConstants.themeColor.blue!
        self.customScrollIndicatorView?.borderWidthForBackgroundView = 0.5
        self.customScrollIndicatorView?.borderColorForBackgroundView = (ColorConstants.themeColor.lightGray?.cgColor)!
    }
}
