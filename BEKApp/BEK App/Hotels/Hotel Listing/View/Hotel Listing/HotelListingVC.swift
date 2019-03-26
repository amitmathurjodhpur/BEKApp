//
//  HotelListingVC.swift
//  BEKApp
//
//  Created by Bhavik on 04/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class HotelListingVC: BaseVC {
    
    @IBOutlet weak var tblvwHotelList: UITableView!
    @IBOutlet weak var btnVoiceSearchOption: UIButton!
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var txtfldSearch: UITextField!
    @IBOutlet weak var customScrollIndicator: UIView!
    @IBOutlet weak var voiceAlertViewContainer: UIView!
    @IBOutlet weak var lblCartBadge: UILabel!
    @IBOutlet weak var vwCartBadge: UIView!
    
    private var arrHotelList:[HotelListModel] = []
    private var arrFilteredDatasource:[HotelListModel] = [] {
        didSet {
            self.tblvwHotelList.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.bhFramework.setEnable(self.view)
//        self.bhFramework.delegate = nil
        let _ = self.isCartHavingItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IB Actions
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtnAction(_ sender: UIButton) {
        if self.isCartHavingItems() {
            let nextVC = OrderReviewVC.instantiate(fromAppStoryboard: .Hotels)
            //nextVC.hotelDetails = self.hotelDetails
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            self.showAlertWithMessage(message: "Your cart is empty. Please enter some item to it.")
        }
    }
    @IBAction func btnVoiceSearchOptionTapped(_ sender: UIButton) {
        if let voiceSearchInstructionView = UINib(nibName: "VoiceSearchInstructionView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? VoiceSearchInstructionView {
            voiceSearchInstructionView.delegate = self
            self.voiceAlertViewContainer.layoutIfNeeded()
            self.voiceAlertViewContainer.setNeedsLayout()
            voiceSearchInstructionView.frame = self.voiceAlertViewContainer.bounds
            self.voiceAlertViewContainer.addSubview(voiceSearchInstructionView)
            self.voiceAlertViewContainer.isHidden = false
            self.voiceAlertViewContainer.layoutIfNeeded()
            self.voiceAlertViewContainer.setNeedsLayout()
        }
    }
}
//MARK: Private Functions
extension HotelListingVC {
    private func setupView() {
        self.customScrollIndicator.layoutIfNeeded()
        self.customScrollIndicator.setNeedsLayout()
        self.txtfldSearch.delegate = self
        let _ = self.isCartHavingItems()

        self.customScrollIndicator.insertSubview(CustomScrollViewIndicatorShared.shared.customScrollIndicatorView!, at: 0)
        self.tblvwHotelList.registerCellWithNib(class: HotelListTableViewCell.self)
        self.arrHotelList.append(HotelListModel(with: "421603", hotelName: "Big Texan Steakhouse", hotelPhone: "8063726000", hotelAddress: "7701 I-40 East, Amarillo, Tx 79118-0000", hotelEmailId: "alex.thebigtexan@hybris.com", hotelContact:"Alex Lee"))
        self.arrHotelList.append(HotelListModel(with: "422954", hotelName: "Pizza Planet/Bell", hotelPhone: "0", hotelAddress: "6801 Bell, Amarillo, Tx 79109-0000", hotelEmailId: "pizzaplanet101@hybris.com", hotelContact: "Eddie Todd"))
        self.arrHotelList.append(HotelListModel(with: "423135", hotelName: "Pizza Planet/Paramount", hotelPhone: "0", hotelAddress: "2400 Paramount, Amarillo, Tx 79109-0000", hotelEmailId: "pizzaplanetama@hybris.com", hotelContact: "Lesha McAllister"))
        self.arrHotelList.append(HotelListModel(with: "423852", hotelName: "Leal S- Amarillo", hotelPhone: "8063729016", hotelAddress: "1619 S. Kentucky, Bidg. C #318, Amarillo, Tx 79102-0000", hotelEmailId: "becky@hybris.com", hotelContact: "Becky Knapp"))
        self.arrHotelList.append(HotelListModel(with: "424199", hotelName: "Jorge S Bar Grill", hotelPhone: "0", hotelAddress: "6051 S. Bell St., Amarillo, Tx 79109-0000", hotelEmailId: "", hotelContact: "8063729016"))
        
        self.arrHotelList.append(HotelListModel(with: "703358", hotelName: "Ember S Steakhouse", hotelPhone: "0", hotelAddress: "2721 Virginia St, Amarillo, Tx 79109-0000", hotelEmailId: "clardie3@hybris.com", hotelContact: "Chad Lardie"))
        self.arrHotelList.append(HotelListModel(with: "760852", hotelName: "Jimmy S Egg Wolfin Village", hotelPhone: "8064186752", hotelAddress: "2225 S Georgia, Amarillo, Tx 79109-0000", hotelEmailId: "jdcasasanta@hybris.com", hotelContact: "John Casasanta"))
        self.arrHotelList.append(HotelListModel(with: "763185", hotelName: "Edes Meat Martket", hotelPhone: "8065846022", hotelAddress: "6103 Hillside Rd., Amarillo, Tx 79109-0000", hotelEmailId: "sandra@hybris.com", hotelContact: "Sandra Rains"))
        self.arrHotelList.append(HotelListModel(with: "771432", hotelName: "Pak-A-Sak 22 Amarillo", hotelPhone: "0", hotelAddress: "14841 Fm 2590, Amarillo, Tx 79109-0000", hotelEmailId: "", hotelContact: "8065846022"))
        self.arrHotelList.append(HotelListModel(with: "774410", hotelName: "Jimmy S Egg Midland Ops L", hotelPhone: "4052039403", hotelAddress: "1904 Loop 250 Frontage Ro, Amarillo, Tx 79103-0000", hotelEmailId: "aoneil@hybris.com", hotelContact: "Angela O'Neil"))
        self.arrFilteredDatasource = self.arrHotelList
        self.setupUI()
    }
    
    private func setupUI() {
        
        CustomScrollViewIndicatorShared.shared.setupThemeIndicator()
        CustomScrollViewIndicatorShared.shared.customScrollIndicatorView?.indicatorColor = ColorConstants.borderColor.gray
        
        self.tblvwHotelList.layer.borderWidth = 0.5
        self.tblvwHotelList.layer.borderColor = ColorConstants.borderColor.gray.cgColor
        
        self.vwSearch.layer.borderWidth = 0.5
        self.vwSearch.layer.borderColor = ColorConstants.borderColor.gray.cgColor
    }
    
    private func isCartHavingItems() -> Bool {
        let dbSourceFromDB = CoreDataModel.shared.showData(for: .cart) as! [Cart]
        self.lblCartBadge.text = "\(dbSourceFromDB.count)"
        return dbSourceFromDB.count > 0 ? true : false
    }
    
    private func filterProduct(_ term: String) {
        if term != "" {
            self.arrFilteredDatasource = self.arrHotelList.filter { $0.hotelName.lowercased().contains(term.lowercased()) }
        }
        else {
            self.arrFilteredDatasource = self.arrHotelList
        }
    }
}
//MARK: Voice Search
extension HotelListingVC: VoiceSearchInstructionViewDelegate {
    func didReciveTextFromSpeech(_ voiceText: String) {
        self.filterProduct(voiceText)
        txtfldSearch.text = voiceText
        for item in self.voiceAlertViewContainer.subviews {
            item.removeFromSuperview()
        }
        self.voiceAlertViewContainer.isHidden = true
    }
    
    func voiceSearchInstructionViewDissmiss() {
        for item in self.voiceAlertViewContainer.subviews {
            item.removeFromSuperview()
        }
        self.voiceAlertViewContainer.isHidden = true
    }
    
    @objc func callTapped(_ sender: AnyObject) {
        let buttonRow = sender.tag
        if let row = buttonRow, let callObj = self.arrFilteredDatasource[row].hotelPhone {
            guard let number = URL(string: "tel://" + callObj) else { return }
            UIApplication.shared.open(number)
        }
    }
}
//MARK: Textfield Delegate
extension HotelListingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.filterProduct(textField.text!)
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.txtfldSearch {
            if let text = textField.text,
                let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,
                                                           with: string)
                self.filterProduct(updatedText)
            }
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.filterProduct("")
        textField.resignFirstResponder()
        return true
    }
}
//MARK: Tableview
extension HotelListingVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFilteredDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HotelListTableViewCell.self)
        cell.lblHotelName.text = self.arrFilteredDatasource[indexPath.row].hotelName
        cell.setTextForAddressLabel(with: self.arrFilteredDatasource[indexPath.row].hotelAddress)
         cell.btnCall.tag = indexPath.row
        cell.btnCall.addTarget(self, action: #selector(callTapped(_:)), for: .touchUpInside)
        
        if self.arrFilteredDatasource[indexPath.row].hotelPhone == "0" {
            cell.btnCall.isHidden = true
        }
        else {
            cell.btnCall.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = HotelDetailVC.instantiate(fromAppStoryboard: .Hotels)
        nextVC.hotelDetails = self.arrFilteredDatasource[indexPath.row]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.hotelDetails = self.arrFilteredDatasource[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    // This function will setup custom scrollview for the table
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        CustomScrollViewIndicatorShared.shared.customScrollIndicatorView?.showIndicator(scrollView)
    }
}
