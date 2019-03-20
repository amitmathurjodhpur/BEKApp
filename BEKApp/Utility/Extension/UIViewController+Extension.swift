//
//  UIViewController+Extension.swift
//  BEKApp
//
//  Created by Bhavik Barot on 28/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation
import SVProgressHUD

extension UIViewController {
    
    func showLoadingIndicator() {
        
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.show()
//            SVProgressHUD.show(withStatus: Constants.UserInterface.LoadingIndicatorMessage.loading)
        }
    }
    
    func hideLoadingIndicator() {
        
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}

