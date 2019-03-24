//
//  SuccessOrderVC.swift
//  BEKApp
//
//  Created by Bhavik on 05/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class SuccessOrderVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTask(_ sender: UIButton) {
//        let dashboard = DashboardVC.instantiate(fromAppStoryboard: .Dashboard)
//        self.navigationController?.pushViewController(dashboard, animated: false)
//        self.navigationController?.popToRootViewController(animated: false)
        
        var i = 0
        if let navControllers = self.navigationController?.viewControllers {
            for vc in navControllers {
                if type(of: vc) == HotelListingVC.self {
                    self.navigationController?.popToViewController(vc, animated: true)
                    return
                }
                i += 1
            }
            
            i = 0
            for vc in navControllers {
                if type(of: vc) == BEKApp.DashboardVC.self {
                    self.navigationController?.popToViewController(vc, animated: true)
                    return
                }
                i += 1
            }
        }
    }
}
