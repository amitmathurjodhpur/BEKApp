//
//  UserDefaultsManager.swift
//  Arya
//
//  Created by Bhavik on 10/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    var isLoggedIn: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isLoggedIn")
        }
        get {
            return UserDefaults.standard.bool(forKey: "isLoggedIn")
        }
    }
    var userName: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
        get {
            if let userName = UserDefaults.standard.string(forKey: "userName") {
                return userName
            }
            return ""
        }
    }
    var tmpuserName: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "tmpuserName")
        }
        get {
            if let tmpuserName = UserDefaults.standard.string(forKey: "tmpuserName") {
                return tmpuserName
            }
            return ""
        }
    }
    var password: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
        }
        get {
            if let userPassword = UserDefaults.standard.string(forKey: "password") {
                return userPassword
            }
            return ""
        }
    }
    var loginData: Data {
        set {
            UserDefaults.standard.set(newValue, forKey: "loginData")
        }
        get {
            return UserDefaults.standard.value(forKey: "loginData") as! Data
        }
    }
    var authToken: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "AuthToken")
        }
        get {
            return UserDefaults.standard.value(forKey: "AuthToken") as! String
        }
    }
    var refreshToken: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "RefreshToken")
        }
        get {
            return UserDefaults.standard.string(forKey: "RefreshToken")
        }
    }
    var cartID: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "cartID")
        }
        get {
            return UserDefaults.standard.string(forKey: "cartID")
        }
    }
    var isClientModeOn: Bool! {
        set {
            UserDefaults.standard.set(newValue, forKey: "cartID")
        }
        get {
            return UserDefaults.standard.bool(forKey: "cartID")
        }
    }
}

func syncUserDefault() {
     UserDefaults.standard.synchronize()
}
