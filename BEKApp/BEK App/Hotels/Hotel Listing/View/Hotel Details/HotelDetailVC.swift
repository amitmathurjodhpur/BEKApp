//
//  HotelDetailVC.swift
//  BEKApp
//
//  Created by Bhavik on 05/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit
import Foundation
import MessageUI
import CoreLocation

enum UserType: String {
    case client = "Client"
    case DSR = "DSR"
}

class HotelDetailVC: BaseVC {
    
    @IBOutlet weak var lblVCTitle: UILabel!
    
    @IBOutlet weak var tblvwHotelOrderSummery: UITableView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPrimaryContact: UILabel!
    @IBOutlet weak var lblOfferOrInformation: UILabel!
    @IBOutlet weak var lblPayableAmount: UILabel!
    @IBOutlet weak var lblPastDueAmount: UILabel!
    
    @IBOutlet weak var vwSwitchMain: UIView!
    @IBOutlet weak var vwSwitchUserMode: UIView!
    @IBOutlet weak var vwSwitchUserModeLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwSwitchUserModeRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblSwitchUserMode: UILabel!
    @IBOutlet weak var lblSwitchUserModeLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblSwitchUserModeRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblCartBadge: UILabel!
    @IBOutlet weak var vwCartBadge: UIView!
    @IBOutlet weak var mailIcon: UIImageView!
    @IBOutlet weak var mapIcon: UIImageView!
    
    private var isClientModeOn: Bool! {
        didSet {
            if self.isClientModeOn {
                self.vwSwitchUserModeRightConstraint.isActive = true
                self.vwSwitchUserModeLeftConstraint.isActive = false
                
                self.lblSwitchUserModeRightConstraint.isActive = false
                self.lblSwitchUserModeLeftConstraint.isActive = true
                self.lblSwitchUserMode.text = UserType.client.rawValue
            }
            else {
                self.vwSwitchUserModeRightConstraint.isActive = false
                self.vwSwitchUserModeLeftConstraint.isActive = true
                
                self.lblSwitchUserModeRightConstraint.isActive = true
                self.lblSwitchUserModeLeftConstraint.isActive = false
                self.lblSwitchUserMode.text = UserType.DSR.rawValue
            }
        }
    }
    
    var hotelDetails: HotelListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let _ = self.isCartHavingItems()
        self.isClientModeOn = UserDefaultsManager.shared.isClientModeOn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @objc func openMap(tapGestureRecognizer: UITapGestureRecognizer) {
        if (tapGestureRecognizer.view as? UIImageView) != nil {
            if let address = self.hotelDetails.hotelAddress {
                let geoCoder = CLGeocoder()
                geoCoder.geocodeAddressString(address) {
                    placemarks, error in
                    let placemark = placemarks?.first
                    let lat = placemark?.location?.coordinate.latitude
                    let lon = placemark?.location?.coordinate.longitude
                    if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                        UIApplication.shared.open(NSURL(string:
                            "comgooglemaps://?saddr=&daddr=\(lat ?? 0.0),\(lon ?? 0.0)&directionsmode=driving")! as URL, options: [:], completionHandler: nil)
                    } else {
                        // if GoogleMap App is not installed
                        UIApplication.shared.open(NSURL(string:
                            "https://maps.google.com/?q=\(lat ?? 0.0),\(lon ?? 0.0)")! as URL, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    //MARK: IB Actions
    @IBAction func switchUserModeEvent(_ sender: UIButton) {
        UserDefaultsManager.shared.isClientModeOn = !self.isClientModeOn
        self.isClientModeOn = !self.isClientModeOn
    }
    
    @IBAction func btnPlaceNewOrderTapped(_ sender: UIButton) {
        let nextVC = ItemListingVC.instantiate(fromAppStoryboard: .Hotels)
        nextVC.hotelDetails = self.hotelDetails
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtnAction(_ sender: UIButton) {
        if isCartHavingItems() {
            let nextVC = OrderReviewVC.instantiate(fromAppStoryboard: .Hotels)
            nextVC.hotelDetails = nil
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            self.showAlertWithMessage(message: "Your cart is empty. Please enter some item to it.")
        }
    }
}
//MARK: Private Methods
extension HotelDetailVC {
    private func setupView() {
        self.isClientModeOn = UserDefaultsManager.shared.isClientModeOn
        self.tblvwHotelOrderSummery.registerCellWithNib(class: HotelDetailsTableViewCell.self)
        self.lblVCTitle.text = hotelDetails.hotelName
        self.lblLocation.text = hotelDetails.hotelAddress
        if hotelDetails.hotelPhone != "0" {
            self.lblPrimaryContact.text = hotelDetails.hotelPhone
        }
       
        let _ = self.isCartHavingItems()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sendMail(tapGestureRecognizer:)))
        mailIcon.isUserInteractionEnabled = true
        mailIcon.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(openMap(tapGestureRecognizer:)))
        mapIcon.isUserInteractionEnabled = true
        mapIcon.addGestureRecognizer(tapGestureRecognizer1)
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.vwSwitchUserMode.layoutIfNeeded()
        self.vwSwitchUserMode.setNeedsLayout()
        self.vwSwitchUserMode.layer.cornerRadius = self.vwSwitchUserMode.bounds.height / 2
        
        self.vwSwitchMain.layoutIfNeeded()
        self.vwSwitchMain.setNeedsLayout()
        self.vwSwitchMain.layer.cornerRadius = self.vwSwitchMain.bounds.height / 2
        self.vwSwitchMain.layer.borderWidth = 0.5
        self.vwSwitchMain.layer.borderColor = ColorConstants.borderColor.gray.cgColor
    }
    private func isCartHavingItems() -> Bool {
        let dbSourceFromDB = CoreDataModel.shared.showData(for: .cart) as! [Cart]
        self.lblCartBadge.text = "\(dbSourceFromDB.count)"
        return dbSourceFromDB.count > 0 ? true : false
    }
    
    func openMap() {
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.openURL(NSURL(string:
                "comgooglemaps://?saddr=&daddr=7701 I-40 East, Amarillo, Tx 79118-0000&directionsmode=driving")! as URL)
        } else {
            NSLog("Can't use comgooglemaps://");
        }
    }
}

//MARK: Tableview Methods
extension HotelDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerNib = UINib.init(nibName: "HotelDetailsTableViewCellHeaderView", bundle: nil)
        
        self.tblvwHotelOrderSummery.register(headerNib, forHeaderFooterViewReuseIdentifier: "HotelDetailsTableViewCellHeaderView")
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HotelDetailsTableViewCellHeaderView") as! HotelDetailsTableViewCellHeaderView
        
        if section == 0 {
            headerView.lblHeaderForSection.text = "Suggested Orders"
        }
        else {
            headerView.lblHeaderForSection.text = "Order History"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HotelDetailsTableViewCell.self)
        
        if indexPath.section == 0 {
            cell.vwSideHighlight.backgroundColor = ColorConstants.themeColor.green
            if indexPath.row == 0 {
                cell.lblTitle.text = "Just the Basics - Pizza"
                cell.lblSubTitle.text = "Olive oil, garlic, onions..."
            }
            else {
                cell.lblTitle.text = "Toppings & Extras"
                cell.lblSubTitle.text = "Pepperoni, sausage, parmesan..."
            }
        }
        else {
            cell.vwSideHighlight.backgroundColor = ColorConstants.themeColor.yellow
            cell.lblTitle.text = "February 20, 2019 - $3,287.32"
            cell.lblSubTitle.text = "Olive oil, ground beef, peeled tomatos..."
        }
        
        return cell
    }
}
extension HotelDetailVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func sendMail(tapGestureRecognizer: UITapGestureRecognizer) {
        if (tapGestureRecognizer.view as? UIImageView) != nil {
            if !MFMailComposeViewController.canSendMail() {
                print("Mail services are not available")
                return
            }
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            if let emailId = self.hotelDetails.hotelEmailId {
                 composeVC.setToRecipients([emailId])
            }
           
            composeVC.setSubject("BEK Demo App")
            composeVC.setMessageBody("Welcome to Bek App", isHTML: false)
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    
}

