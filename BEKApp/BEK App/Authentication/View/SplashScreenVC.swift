//
//  SplashScreenVC.swift
//  BEKApp
//
//  Created by Bhavik on 10/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.perform(#selector(nextVC), with: nil, afterDelay: 0.2)
    }
    
    @objc func nextVC() {
        
        if UserDefaultsManager.shared.isLoggedIn {
            let nextVC = DashboardVC.instantiate(fromAppStoryboard: .Dashboard)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            let nextVC = LoginVC.instantiate(fromAppStoryboard: .Authentication)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
