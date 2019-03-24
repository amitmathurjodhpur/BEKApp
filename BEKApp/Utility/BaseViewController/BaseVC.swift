//
//  BaseVC.swift
//  BEKApp
//
//  Created by Bhavik on 02/08/18.
//  Copyright © 2018 Bhavik Barot. All rights reserved.
//

import UIKit
import BHTextFieldManager

class BaseVC: UIViewController {
    
    var bhFramework = BHTextFieldManager()
    
    // Show hide Navigation Bar
    var hideNavigationBar: Bool = false {
        willSet {
            self.navigationController?.navigationBar.isHidden = newValue
        }
    }
    
    // Enable/Disable Swipe Back
    var enableSwipeBack: Bool = true {
        willSet {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.bhFramework.setKeyboardDistanceFromTextField(20.0)
        self.bhFramework.color(forUpDownArrow: ColorConstants.themeColor.blue)
        self.bhFramework.color(forDoneButtonText: ColorConstants.themeColor.blue)
        self.bhFramework.color(forBackgroundView: ColorConstants.themeColor.lightGray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Custom Methods
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - NavigationBar Methods

extension BaseVC {
    
    /**
     Set Navigation Bar Title with Image
     - Authors:
     - Created By - Bhavik
     - Modified By - <# author name #>
     - Date:
     - Created At - 20/9/2018
     - Modified At - <#date#>
     - Version: <#version#>
     - Remark: <#remark#>
     */
    func setNavigationTitleWithImage(title: String, image: UIImage) {
        
        let navView = UIView()
        
        let label = UILabel()
        label.text = "  \(title)"
        label.sizeToFit()
        label.center = navView.center
        label.textAlignment = NSTextAlignment.center
        
        let imageView = UIImageView()
        imageView.image = image
        let imageAspect = imageView.image!.size.width/imageView.image!.size.height
        imageView.frame = CGRect(x: label.frame.origin.x-label.frame.size.height*imageAspect, y: label.frame.origin.y, width: label.frame.size.height*imageAspect, height: label.frame.size.height)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        navView.addSubview(label)
        navView.addSubview(imageView)
        self.navigationItem.titleView = navView
        navView.sizeToFit()
    }
    
    func setNavigationBarTintColor(color: UIColor) {
        
        navigationController?.navigationBar.tintColor = color
    }
}
extension BaseVC {
    
    func showAlertWithMessage(message: String) {
        
        let alert = UIAlertController.alert(title: "BEKApp", message: message)
        alert.addAction(title: "OK", style: .cancel, handler: nil)
        alert.present(in: self)
    }
}
