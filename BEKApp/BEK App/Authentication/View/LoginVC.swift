//
//  LoginVC.swift
//  BEKApp
//
//  Created by Bhavik on 02/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit
import ObjectMapper
import LocalAuthentication

class LoginVC: BaseVC {
    
    @IBOutlet weak var txtfldUsername: UITextField!
    @IBOutlet weak var txtfldPassword: UITextField!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!

    let service = "myService"
    let account = "myAccount"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.bhFramework.setEnable(self.view)
    }
    
     @IBAction func loginWithFaceID(_ sender: UIButton) {
        if let userId = UserDefaultsManager.shared.userName as String?, let password = UserDefaultsManager.shared.password as String?, !userId.isEmpty, !password.isEmpty {
            self.Authenticate { (success) in
                print(success)
                if success {
                    DispatchQueue.main.async {
                        if userId != "pizzaplanetama@hybris.com" {
                            self.txtfldUsername.text = UserDefaultsManager.shared.tmpuserName
                        } else {
                            self.txtfldUsername.text = UserDefaultsManager.shared.userName
                        }
                        self.txtfldPassword.text = password
                        self.loginAPICall()
                    }
                }
            }
        }
    }
    
    func Authenticate(completion: @escaping ((Bool) -> ())){
        
        //Create a context
        let authenticationContext = LAContext()
        var error:NSError?
        
        //Check if device have Biometric sensor
        let isValidSensor : Bool = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        
        if isValidSensor {
            //Device have BiometricSensor
            //It Supports TouchID
            
            authenticationContext.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Touch / Face ID authentication",
                reply: { [unowned self] (success, error) -> Void in
                    
                    if(success) {
                        // Touch / Face ID recognized success here
                        completion(true)
                    } else {
                        //If not recognized then
                        if let error = error {
                            let strMessage = self.errorMessage(errorCode: error._code)
                            if strMessage != ""{
                                self.showAlertWithTitle(title: "Error", message: strMessage)
                            }
                        }
                        completion(false)
                    }
            })
        } else {
            
            let strMessage = self.errorMessage(errorCode: (error?._code)!)
            if strMessage != ""{
                self.showAlertWithTitle(title: "Error", message: strMessage)
            }
        }
        
    }
    
    //MARK: Show Alert
    func showAlertWithTitle( title:String, message:String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: TouchID error
    func errorMessage(errorCode:Int) -> String {
        
        var strMessage = ""
        
        switch errorCode {
            
        case LAError.Code.authenticationFailed.rawValue:
            strMessage = "Authentication Failed"
            
        case LAError.Code.appCancel.rawValue:
            strMessage = "User Cancel"
            
        case LAError.Code.systemCancel.rawValue:
            strMessage = "System Cancel"
            
        case LAError.Code.passcodeNotSet.rawValue:
            strMessage = "Please goto the Settings & Turn On Passcode"
            
        case LAError.Code.touchIDNotAvailable.rawValue:
            strMessage = "TouchID or FaceID Not Available"
            
        case LAError.Code.touchIDNotEnrolled.rawValue:
            strMessage = "TouchID or FaceID Not Enrolled"
            
        case LAError.Code.touchIDLockout.rawValue:
            strMessage = "TouchID or FaceID Lockout Please goto the Settings & Turn On Passcode"
            
        case LAError.Code.appCancel.rawValue:
            strMessage = "App Cancel"
            
        case LAError.Code.invalidContext.rawValue:
            strMessage = "Invalid Context"
            
        default:
            strMessage = ""
            
        }
        return strMessage
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        if txtfldUsername.text != "" {
            if CommonUtilitiesClass.shared.validEmailAddress(txtfldUsername.text!) {
                if txtfldPassword.text != "" {
                    self.loginAPICall()
                }
                else {
                    self.showAlertWithMessage(message: "Please enter your password.")
                }
            }
            else {
                self.showAlertWithMessage(message: "Please enter valid email.")
            }
        }
        else {
            self.showAlertWithMessage(message: "Please enter your email.")
        }
    }
}
//MARK: - Private Functions
extension LoginVC {
    private func loginAPICall() {
        self.showLoadingIndicator()
        var requestDic: [String:Any] = [:]
        let userName = "pizzaplanetama@hybris.com"
        let password = "12341234"
        requestDic[APIConstants.Key.kClientId] = "rest_api_client"
        requestDic[APIConstants.Key.kClientSecret] = "secret"
        requestDic[APIConstants.Key.kGrantType] = "password"
       
        requestDic[APIConstants.Key.kUsername] = userName //txtfldUsername.text
        requestDic[APIConstants.Key.kPassword] = password //txtfldPassword.text
        
        APIHelper.shared.post(request: requestDic, to: HTTPClient().createEndPoint(endPoint: HTTPClient.Authentication.Login.rawValue), withAuth: false) { (responseDic, isError, isNetOn) in
            self.hideLoadingIndicator()
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: LoginResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.accessToken != nil {
                            let loginData = NSKeyedArchiverUtility.encodeObject(responseModel as Any)
                            UserDefaultsManager.shared.loginData = loginData
                            UserDefaultsManager.shared.authToken = responseModel?.accessToken ?? ""
                            UserDefaultsManager.shared.isLoggedIn = true
                            UserDefaultsManager.shared.tmpuserName = self.txtfldUsername.text!
                            UserDefaultsManager.shared.userName = userName //self.txtfldUsername.text!
                            UserDefaultsManager.shared.password = password //self.txtfldPassword.text!
                            UserDefaults.standard.synchronize()
                            let nextVC = DashboardVC.instantiate(fromAppStoryboard: .Dashboard)
                            self.navigationController?.pushViewController(nextVC, animated: true)
                        }
                        else {
                            let alrt = UIAlertController(title: "BEKApp", message: "\(responseDic["error_description"] ?? "Opps Something went wrong please try again.")", preferredStyle: .alert)
                            alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
//                                let nextVC = DashboardVC.instantiate(fromAppStoryboard: .Dashboard)
//                                self.navigationController?.pushViewController(nextVC, animated: true)
                            }))
                            self.present(alrt, animated: true, completion: nil)
                        }
                    })
                }
            }
            else {
                //Net is off
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
        }
    }
}
