//
//  CheckNetwork.swift
//  BEKApp
//
//  Created by Bhavik on 09/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit
import Reachability

class CheckNetwork: NSObject {
    class func checkStatus() -> Bool {
        var status = Bool()
        let reachability = Reachability()!
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        if reachability.connection == .wifi {
            status = true
        }
        else if reachability.connection == .cellular {
            status = true
        }
        else if reachability.connection == .none {
            status = false
        }
        else {
            status = false
        }
        return status
    }
}
