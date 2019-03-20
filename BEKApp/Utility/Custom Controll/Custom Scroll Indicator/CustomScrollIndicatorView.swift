//
//  CustomScrollIndicatorView.swift
//
//  Created by Bhavik Barot on 06/03/19.
//  Copyright © 2019 Bhavik Barot. All rights reserved.
//

import UIKit

class CustomScrollIndicatorView: UIView {
    
    @IBOutlet weak var indicatorViewContainerView: UIView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorViewYConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        self.setupDefaultViewForIndicator()
    }
    
    private func setupDefaultViewForIndicator() {
        self.indicatorViewContainerView.backgroundColor = .white
        self.indicatorView.backgroundColor = .blue
        self.indicatorViewContainerView.layer.cornerRadius = 0
        self.indicatorView.layer.cornerRadius = 0
        self.indicatorViewContainerView.layer.borderWidth = 0
        self.indicatorView.layer.borderWidth = 0
        self.indicatorViewContainerView.layer.borderColor = UIColor.clear.cgColor
        self.indicatorView.layer.borderColor = UIColor.clear.cgColor
        self.indicatorViewHeightConstraint.constant = 0
        self.indicatorViewYConstraint.constant = 0
    }
    
    override func draw(_ rect: CGRect) {
//        self.indicatorViewContainerView.layoutIfNeeded()
//        self.indicatorViewContainerView.setNeedsLayout()
//        self.indicatorViewYConstraint.constant = 0
//        self.indicatorViewHeightConstraint.constant = self.indicatorViewContainerView.bounds.height
    }
}

extension CustomScrollIndicatorView {
    
    var indicatorBackground: UIColor {
        set {
            self.indicatorViewContainerView.backgroundColor = newValue
        }
        get {
            return self.indicatorViewContainerView.backgroundColor ?? .white
        }
    }
    
    var indicatorColor: UIColor {
        set {
            self.indicatorView.backgroundColor = newValue
        }
        get {
            return self.indicatorView.backgroundColor ?? .blue
        }
    }
    
    var cornerRadiusForBackgroundView: CGFloat {
        set {
            self.indicatorViewContainerView.layer.cornerRadius = newValue
        }
        get {
            return self.indicatorViewContainerView.layer.cornerRadius
        }
    }
    
    var cornerRadiusForIndicator: CGFloat {
        set {
            self.indicatorView.layer.cornerRadius = newValue
        }
        get {
            return self.indicatorView.layer.cornerRadius
        }
    }
    
    var borderWidthForBackgroundView: CGFloat {
        set {
            self.indicatorViewContainerView.layer.borderWidth = newValue
        }
        get {
            return self.indicatorViewContainerView.layer.borderWidth
        }
    }
    
    var borderWidthForIndicator: CGFloat {
        set {
            self.indicatorView.layer.borderWidth = newValue
        }
        get {
            return self.indicatorView.layer.borderWidth
        }
    }
    
    var borderColorForBackgroundView: CGColor {
        set {
            self.indicatorViewContainerView.layer.borderColor = newValue
        }
        get {
            return self.indicatorViewContainerView.layer.borderColor ?? UIColor.clear.cgColor
        }
    }
    
    var borderColorForIndicator: CGColor {
        set {
            self.indicatorView.layer.borderColor = newValue
        }
        get {
            return self.indicatorView.layer.borderColor ?? UIColor.clear.cgColor
        }
    }
    
}
extension CustomScrollIndicatorView {
    func showIndicator(_ scrollView: UIScrollView) {
        scrollView.layoutIfNeeded()
        scrollView.setNeedsLayout()
        for view in scrollView.subviews {
            if view is UIImageView,
                let imageView = view as? UIImageView,
                let image = imageView.image  {
                imageView.layer.removeAllAnimations()
                imageView.tintColor = .clear
                imageView.image = image.withRenderingMode(.alwaysTemplate)
                imageView.isHidden = false
                DispatchQueue.main.async {
                    self.setupCustomIndicator(imageView, with: scrollView)
                }
            }
        }
//        scrollView.flashScrollIndicators()
    }
    
    private func setupCustomIndicator(_ imageView: UIImageView, with scrollView: UIScrollView) {
        imageView.layoutIfNeeded()
        imageView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        scrollView.setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            self.indicatorViewHeightConstraint.constant = imageView.frame.size.height
            var targetHeight: CGFloat = scrollView.bounds.size.height - imageView.frame.size.height
            if targetHeight < 0 {
                targetHeight = 0
            }
            var sourceHeight: CGFloat = scrollView.contentSize.height - scrollView.bounds.size.height
            if sourceHeight < 0 {
                sourceHeight = 0
            }
            var thumbY: CGFloat = 0
            if targetHeight > 0 && sourceHeight > 0 {
                var ry: CGFloat = scrollView.contentOffset.y / sourceHeight
                if ry < 0 {
                    ry = 0
                }
                else if ry > 1 {
                    ry = 1
                }
                thumbY = ry * targetHeight
            }
            
            self.indicatorViewYConstraint.constant = CGFloat(roundf(Float(thumbY)))//((imageView.frame.origin.y / self.tblvw.contentSize.height) * self.tblvw.bounds.height)
            
//            if scrollView.bounds.height < scrollView.contentSize.height {
//                var targetHeight: CGFloat = scrollView.bounds.size.height - imageView.frame.size.height
//                if targetHeight < 0 {
//                    targetHeight = 0
//                }
//                var sourceHeight: CGFloat = scrollView.contentSize.height - scrollView.bounds.size.height
//                if sourceHeight < 0 {
//                    sourceHeight = 0
//                }
//                var thumbY: CGFloat = 0
//                if targetHeight > 0 && sourceHeight > 0 {
//                    var ry: CGFloat = scrollView.contentOffset.y / sourceHeight
//                    if ry < 0 {
//                        ry = 0
//                    }
//                    else if ry > 1 {
//                        ry = 1
//                    }
//                    thumbY = ry * targetHeight
//                }
//
//                self.indicatorViewYConstraint.constant = CGFloat(roundf(Float(thumbY)))//((imageView.frame.origin.y / self.tblvw.contentSize.height) * self.tblvw.bounds.height)
//            }
//            else {
//                self.indicatorViewContainerView.layoutIfNeeded()
//                self.indicatorViewContainerView.setNeedsLayout()
//                self.indicatorViewYConstraint.constant = 0
//                self.indicatorViewHeightConstraint.constant = self.indicatorViewContainerView.bounds.height
//            }
        }
    }
}
