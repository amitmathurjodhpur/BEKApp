//
//  UINavigationController+Extension.swift
//  Arya
//
//  Created by Bhavik Barot on 01/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation
import UIKit

//extension UINavigationController {
//    
//    func setupTransperentNavigationBar() {
//        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationBar.shadowImage = UIImage()
//        self.navigationBar.isTranslucent = true
//        self.view.backgroundColor = .clear
//        self.navigationBar.tintColor = UIColor.white
//    }
//    
//    func setNavigationBarTintColor(color: UIColor) {
//        
//        self.navigationBar.tintColor = color
//    }
//    
//    func setProviderNavigationBar() {
//        self.navigationBar.isTranslucent = false
//        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
//        self.navigationBar.tintColor = UIColor.white
//        self.navigationBar.barTintColor = ColorConstant.blueNavigationBar
//        self.view.backgroundColor = ColorConstant.blueNavigationBar
//    }
//    
//    func setPatientNavigationBar() {
//        self.navigationBar.isTranslucent = false
//        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : ColorConstant.darkTabThemeColor]
//        self.navigationBar.tintColor = ColorConstant.blueNavigationBar
//        self.navigationBar.barTintColor = UIColor.white
//        self.view.backgroundColor = UIColor.white
//    }
//    
//    func showBackButton() {
//        let backButton = UIBarButtonItem()
//        backButton.title = Constants.NavigationBarTitle.back
//        self.navigationBar.topItem?.backBarButtonItem = backButton
//    }
//    
//    func hideBackButton() {
//        self.navigationBar.isHidden = false
//    }
//    
//    func setupNavigationBar() {
//        
//        if UserDefaultsManager.shardInstance.isPatient{
//            
//            setPatientNavigationBar()
//        } else {
//            
//            setProviderNavigationBar()
//        }
//    }
//}

