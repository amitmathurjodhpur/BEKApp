//
//  OrderReviewVC.swift
//  BEKApp
//
//  Created by Bhavik on 08/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit
import BHTextFieldManager

class OrderReviewVC: BaseVC {
    
    @IBOutlet weak var tblvwItemListing: UITableView!
    @IBOutlet weak var vwSearchMain: UIView!
    @IBOutlet weak var txtfldSearch: UITextField!
    @IBOutlet weak var lblTotalAomount: UILabel!
    @IBOutlet weak var lblSalePrice: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblMargin: UILabel!
    @IBOutlet weak var vwBottumExpandedPriceDetail: UIView!
    @IBOutlet weak var customScrollIndicator: UIView!
    
    @IBOutlet weak var vwSwitchMain: UIView!
    @IBOutlet weak var vwSwitchUserMode: UIView!
    @IBOutlet weak var vwSwitchUserModeLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var vwSwitchUserModeRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblSwitchUserMode: UILabel!
    @IBOutlet weak var lblSwitchUserModeLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblSwitchUserModeRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var voiceAlertViewContainer: UIView!
    @IBOutlet weak var lblVCTitle: UILabel!
    
    private var isClientModeOn: Bool! = true {
        didSet {
            if self.isClientModeOn {
                self.vwSwitchUserModeRightConstraint.isActive = true
                self.vwSwitchUserModeLeftConstraint.isActive = false
                
                self.lblSwitchUserModeRightConstraint.isActive = false
                self.lblSwitchUserModeLeftConstraint.isActive = true
                self.lblSwitchUserMode.text = UserType.client.rawValue
                self.vwBottumExpandedPriceDetail.isHidden = true
                self.lblTotalAomount.isHidden = false
            }
            else {
                self.vwSwitchUserModeRightConstraint.isActive = false
                self.vwSwitchUserModeLeftConstraint.isActive = true
                
                self.lblSwitchUserModeRightConstraint.isActive = true
                self.lblSwitchUserModeLeftConstraint.isActive = false
                self.lblSwitchUserMode.text = UserType.DSR.rawValue
                self.vwBottumExpandedPriceDetail.isHidden = false
                self.lblTotalAomount.isHidden = true
            }
            self.updateDataSourceForDSRMode()
        }
    }
    
    private var responseData: SearchProductResponse?
    var arrItemListing: [DSRCartItemListDatasourceModel] = []
    var arrFilteredDatasource: [DSRCartItemListDatasourceModel]! = [] {
        didSet {
            UIView.performWithoutAnimation {
            self.tblvwItemListing.reloadData()
            }
        }
    }
    var hotelDetails: HotelListModel?
    
    private var apiCallIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        self.bhFramework.setEnable(self.view)
        self.bhFramework.delegate = self
        self.isClientModeOn = UserDefaultsManager.shared.isClientModeOn
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- IB Actions
    @IBAction func switchUserModeEvent(_ sender: UIButton) {
        UserDefaultsManager.shared.isClientModeOn = !self.isClientModeOn
        self.isClientModeOn = !self.isClientModeOn
    }
    
    @IBAction func btnPlaceOrderTapped(_ sender: UIButton) {
        self.apiCallIndex = 0
        self.createCartForUserAPI()
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
//MARK:- Private Methods
extension OrderReviewVC {
    private func setupView() {
        self.isClientModeOn = UserDefaultsManager.shared.isClientModeOn
        self.txtfldSearch.delegate = self
        self.customScrollIndicator.layoutIfNeeded()
        self.customScrollIndicator.setNeedsLayout()
        self.lblVCTitle.text = "\(self.hotelDetails?.hotelName ?? "Cart")"
        self.customScrollIndicator.insertSubview(CustomScrollViewIndicatorShared.shared.customScrollIndicatorView!, at: 0)
        self.tblvwItemListing.registerCellWithNib(class: DSRCartTableViewCell.self)
        self.getCartDataAndSetDatasource()
        self.setupUI()
    }
    
    private func setupUI() {
        self.tblvwItemListing.layer.borderWidth = 1
        self.tblvwItemListing.layer.borderColor = ColorConstants.borderColor.gray.cgColor
        
        self.vwSearchMain.layer.borderWidth = 1
        self.vwSearchMain.layer.borderColor = ColorConstants.borderColor.gray.cgColor
        CustomScrollViewIndicatorShared.shared.setupThemeIndicator()
        CustomScrollViewIndicatorShared.shared.customScrollIndicatorView?.indicatorColor = ColorConstants.themeColor.lightGray!
        self.vwSwitchUserMode.layoutIfNeeded()
        self.vwSwitchUserMode.setNeedsLayout()
        self.vwSwitchUserMode.layer.cornerRadius = self.vwSwitchUserMode.bounds.height / 2
        
        self.vwSwitchMain.layoutIfNeeded()
        self.vwSwitchMain.setNeedsLayout()
        self.vwSwitchMain.layer.cornerRadius = self.vwSwitchMain.bounds.height / 2
        self.vwSwitchMain.layer.borderWidth = 0.5
        self.vwSwitchMain.layer.borderColor = ColorConstants.borderColor.gray.cgColor
    }
    
    private func updateDataSourceForDSRMode() {
        for item in self.arrFilteredDatasource {
            item.isCollapsed = !self.isClientModeOn
        }
        UIView.performWithoutAnimation {
        self.tblvwItemListing.reloadData()
        }
    }
    
    private func setCartItemToDatabase() -> Bool {
        CoreDataModel.shared.deleteAllCartData(for: .cart)
        var isSaved: Bool! = false
        for item in self.arrItemListing {
            if item.dsrCarListModel.itemSubTotal > 0 {
                isSaved = CoreDataModel.shared.saveDataToCart(with: item.dsrCarListModel.hotelId, hotelName: item.dsrCarListModel.hotelName, itemId: item.dsrCarListModel.itemId, itemMargin: item.dsrCarListModel.itemMargin, itemName: item.dsrCarListModel.itemName, itemPerBagQuantity: item.dsrCarListModel.itemPerBagQuantity, itemProductionCost: item.dsrCarListModel.itemProductionCost, itemQuantity: item.dsrCarListModel.itemQuantity, itemSubTotal: item.dsrCarListModel.itemSubTotal, itemTitle: item.dsrCarListModel.itemTitle, itemUnitPrice: item.dsrCarListModel.itemUnitPrice)
            }
        }
        return isSaved
    }
    
    private func getCartDataAndSetDatasource() {
        let dbSourceFromDB = CoreDataModel.shared.showData(for: .cart) as! [Cart]
        for dbSource in dbSourceFromDB {
            self.arrItemListing.append(DSRCartItemListDatasourceModel(withModel: DSRCartItemListModel(with: dbSource.hotelId, hotelName: dbSource.hotelName, itemId: dbSource.itemId, itemMargin: dbSource.itemMargin, itemName: dbSource.itemName!, itemPerBagQuantity: dbSource.itemPerBagQuantity!, itemProductionCost: dbSource.itemProductionCost, itemQuantity: dbSource.itemQuantity, itemSubTotal: dbSource.itemSubTotal, itemTitle: dbSource.itemTitle, itemUnitPrice: dbSource.itemUnitPrice)))
        }
        self.arrFilteredDatasource = self.arrItemListing
        self.setCartTotalPrice()
        self.updateDataSourceForDSRMode()
    }
    
    private func setCartTotalPrice() {
        var itemTotal: Double = 0
        var itemMargin: Double = 0
        var itemCost: Double = 0
        for item in self.arrItemListing {
            if item.dsrCarListModel.itemSubTotal > 0 {
                itemTotal = (itemTotal + item.dsrCarListModel.itemSubTotal).rounded(toPlaces: 2)
                itemCost = (itemCost + (item.dsrCarListModel.itemProductionCost * Double(item.dsrCarListModel.itemQuantity ?? Int64(1.0)))).rounded(toPlaces: 2)
            }
        }
        if itemTotal > 0 && itemCost > 0 {
            itemMargin = (((itemTotal - itemCost)/itemCost) * 100).rounded(toPlaces: 2)
        }
        self.updateUIForCartTotalPrice(total: itemTotal, margin: itemMargin, cost: itemCost)
    }
    
    private func updateUIForCartTotalPrice(total: Double, margin: Double, cost: Double) {
        self.lblSalePrice.text = "$" + "\(total)"
        self.lblTotalAomount.text = "$" + "\(total)"
        self.lblCost.text = "$" + "\(cost)"
        self.lblMargin.text = "\(margin)" + "%"
        let _ = self.setCartItemToDatabase()
        self.updateDataSourceForDSRMode()
    }
    
    private func filterProduct(_ term: String) {
        if term != "" {
            self.arrFilteredDatasource = self.arrItemListing.filter { $0.dsrCarListModel.itemName.lowercased().contains(term.lowercased()) }
        }
        else {
            self.arrFilteredDatasource = self.arrItemListing
        }
    }
    private func setAddItemToCartAPI() {
        if self.apiCallIndex < self.arrItemListing.count {
            self.addProductToCartForUserAPI(productId: "\(self.arrItemListing[self.apiCallIndex].dsrCarListModel!.itemId ?? 0)", Quantity: Int(self.arrItemListing[self.apiCallIndex].dsrCarListModel!.itemQuantity))
            self.apiCallIndex += 1
        }
        else {
            self.setCustomerPaymentTypeAPI()
        }
    }
}

//MARK:- API Calls
extension OrderReviewVC {
    private func createCartForUserAPI() {
        self.showLoadingIndicator()
       let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/users/\(UserDefaultsManager.shared.userName)/carts"
       // let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/users/pizzaplanetama@hybris.com/carts"

        APIHelper.shared.post(request: [:], to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                    self.hideLoadingIndicator()
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: CreateCartResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.code != nil {
                            UserDefaultsManager.shared.cartID = responseModel?.code
                            self.setAddItemToCartAPI()
                        }
                        else {
                            self.hideLoadingIndicator()
                            if let respDictObj = responseDic["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                                let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                                alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alrt, animated: true, completion: nil)
                            }
                        }
                    })
                }
            }
            else {
                //Net is off
                self.hideLoadingIndicator()
                self.showAlertWithMessage(message: "we couldn’t place your order but it is saved locally. You can submit it later from open items.")
            }
        }
    }
    
    private func setCustomerPaymentTypeAPI() {
        self.showLoadingIndicator()
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/users/\(UserDefaultsManager.shared.userName)/carts/\(UserDefaultsManager.shared.cartID ?? "")/paymenttype?paymentType=ACCOUNT"

        let reqDic: [String: Any] = [:]
        
        APIHelper.shared.put(request: reqDic, to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.hideLoadingIndicator()
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: SetCustomerPaymentTypeResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.entries != nil {
                            self.setCustomerCostCenterAPI()
                        }
                        else {
                            self.hideLoadingIndicator()
                            if let respDictObj = responseDic["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                                let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                                alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alrt, animated: true, completion: nil)
                            }
                        }
                    })
                }
            }
            else {
                //Net is off
                self.hideLoadingIndicator()
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
        }
    }
    
    private func setCustomerCostCenterAPI() {
        self.showLoadingIndicator()
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/users/\(UserDefaultsManager.shared.userName)/carts/\(UserDefaultsManager.shared.cartID ?? "")/costcenter?costCenterId=423135CC"
        
        let reqDic: [String: Any] = [:]
        
        APIHelper.shared.put(request: reqDic, to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.hideLoadingIndicator()
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: SetCustomerCostCenterResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.entries != nil {
                            self.setDeliveryAddressForCartAPI()
                        }
                        else {
                            self.hideLoadingIndicator()
                            if let respDictObj = responseDic["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                                let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                                alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alrt, animated: true, completion: nil)
                            }
                        }
                    })
                }
            }
            else {
                //Net is off
                self.hideLoadingIndicator()
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
        }
    }
    
    private func setDeliveryAddressForCartAPI() {
        self.showLoadingIndicator()
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/users/\(UserDefaultsManager.shared.userName)/carts/\(UserDefaultsManager.shared.cartID ?? "")/addresses/delivery?addressId=8796224258071&fields=FULL"
        
        let reqDic: [String: Any] = [:]
        
        APIHelper.shared.put(request: reqDic, to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.hideLoadingIndicator()
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: SetDeliveryAddressResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.entries != nil {
                            self.setDeliveryModeAPI()
                        }
                        else {
                            self.hideLoadingIndicator()
                            if let respDictObj = responseDic["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                                let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                                alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alrt, animated: true, completion: nil)
                            }
                        }
                    })
                }
            }
            else {
                //Net is off
                self.hideLoadingIndicator()
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
        }
    }
    
    private func setDeliveryModeAPI() {
        self.showLoadingIndicator()
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/users/\(UserDefaultsManager.shared.userName)/carts/\(UserDefaultsManager.shared.cartID ?? "")/deliverymode?deliveryModeId=standard-net"
        
        let reqDic: [String: Any] = [:]
        
        APIHelper.shared.put(request: reqDic, to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.hideLoadingIndicator()
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: SetDeliveryAddressResponse.self, responseDic, completion: { (responseModel) in
                        self.hideLoadingIndicator()
                        if let respDictObj = responseDic["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                            let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                            alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alrt, animated: true, completion: nil)
                        }
                        else {
                            self.finalizeOrderAPI()
                        }
                    })
                }
            }
            else {
                //Net is off
                self.hideLoadingIndicator()
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
        }
    }
    
    private func addProductToCartForUserAPI(productId: String, Quantity qty: Int) {
        self.showLoadingIndicator()
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/users/\(UserDefaultsManager.shared.userName)/carts/\(UserDefaultsManager.shared.cartID ?? "")/entries"
        let productDic: [String: Any] = ["code": productId]
        var reqDic: [String: Any] = [:]
        reqDic["product"] = productDic
        reqDic["quantity"] = qty
     /* APIHelper.shared.post(request: params, to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.hideLoadingIndicator()
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: AddProductToCartResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.statusCode == "success" {
                            self.setAddItemToCartAPI()
                        }
                        else {
                            self.hideLoadingIndicator()
                            if let respDictObj = responseDic["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                                let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                                    alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alrt, animated: true, completion: nil)
                            }
                           
                        }
                    })
                }
            }
            else {
                //Net is off
                self.hideLoadingIndicator()
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
        }*/
        
        if let params = reqDic as Dictionary<String, Any>?, let urlStr = URL(string: url) {
            var request = URLRequest(url: urlStr)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer "+"\(UserDefaultsManager.shared.authToken)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                print(response!)
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print(json)
                    if error != nil {
                        //Error, Try Again
                        self.hideLoadingIndicator()
                        self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                    }
                    else {
                        //No Error
                        GetMapperModel.shared.getMapper(mapper: AddProductToCartResponse.self, json, completion: { (responseModel) in
                            if responseModel?.statusCode == "success" {
                                self.setAddItemToCartAPI()
                            }
                            else {
                                self.hideLoadingIndicator()
                                if let respDictObj = json["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                                    let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                                    alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alrt, animated: true, completion: nil)
                                }
                            }
                        })
                    }
                    
                } catch {
                    print("error")
                    self.hideLoadingIndicator()
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
            })
            
            task.resume()
        }
    }
    
    private func deleteProductToCartForUserAPI(productId: String, Quantity qty: Int) {
        self.showLoadingIndicator()
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/\(UserDefaultsManager.shared.userName)/carts/\(UserDefaultsManager.shared.cartID ?? "")/entries"
        let productDic: [String: Any] = ["code": productId]
        var reqDic: [String: Any] = [:]
        reqDic["product"] = productDic
        reqDic["quantity"] = qty
        
        APIHelper.shared.delete(request: reqDic, to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.hideLoadingIndicator()
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: AddProductToCartResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.statusCode == "Success" {
                            
                        }
                        else {
                            self.hideLoadingIndicator()
                            if let respDictObj = responseDic["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                                let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                                alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alrt, animated: true, completion: nil)
                            }
                            
                        }
                    })
                }
            }
            else {
                //Net is off
                self.hideLoadingIndicator()
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
        }
    }
    
    private func finalizeOrderAPI() {
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/users/\(UserDefaultsManager.shared.userName)/orders?cartId=\(UserDefaultsManager.shared.cartID ?? "")&termsChecked=True"/*carts/\(UserDefaultsManager.shared.cartID ?? "")/entries"*/
        let reqDic: [String: Any] = [:]
        APIHelper.shared.post(request: reqDic, to: url) { (responseDic, isError, isNetOn) in
            self.hideLoadingIndicator()
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: FinalizeOrderResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.entries != nil {
                           // CoreDataModel.shared.deleteAllCartData()
                            let nextVC = SuccessOrderVC.instantiate(fromAppStoryboard: .Hotels)
                            self.navigationController?.pushViewController(nextVC, animated: true)
                        }
                        else {
                            if let respDictObj = responseDic["errors"] as? Array<[String:Any]>, let firstObj = respDictObj.first, let msg = firstObj["message"] as? String {
                                let alrt = UIAlertController(title: "BEKApp", message: msg, preferredStyle: .alert)
                                alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alrt, animated: true, completion: nil)
                            }
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

//MARK:- Voice Search
extension OrderReviewVC: VoiceSearchInstructionViewDelegate {
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
}
//MARK:- TextField Delegate
extension OrderReviewVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField != self.txtfldSearch {
            if textField.text == "" || textField.text == "$" {
                self.tblvwItemListing.reloadSections(IndexSet(integer: textField.tag - 102), with: .none)
            }
            else {
                let arrPrice = textField.text!.components(separatedBy: "$")
                if Double(arrPrice.last!) != nil {
                    if self.arrFilteredDatasource[textField.tag - 102].dsrCarListModel.itemProductionCost > Double(arrPrice.last!)!  {
                        self.showAlertWithMessage(message: "Sale price can not be less then the production price.")
                    }
                    else {
                        self.arrFilteredDatasource[textField.tag - 102].dsrCarListModel.itemUnitPrice = Double(arrPrice.last!)!
                        self.arrFilteredDatasource[textField.tag - 102].dsrCarListModel = DSRCartItemListModel.calculateCostMargin(self.arrFilteredDatasource[textField.tag - 102].dsrCarListModel)
                        self.tblvwItemListing.reloadSections(IndexSet(integer: textField.tag - 102), with: .none)
                        self.setCartTotalPrice()
                    }
                }
                else {
                    self.showAlertWithMessage(message: "Please enter the valid price.")
                }
            }
        }
        else {
            self.filterProduct(textField.text!)
        }
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != self.txtfldSearch {
            if textField.text == "" || textField.text == "$" {
                self.tblvwItemListing.reloadSections(IndexSet(integer: textField.tag - 102), with: .none)
            }
            else {
                //                let cell = self.tblvwItemListing.cellForRow(at: IndexPath(row: 0, section: txtfld.tag - 102)) as! DSRCartTableViewCell
                let arrPrice = textField.text!.components(separatedBy: "$")
                if Double(arrPrice.last!) != nil {
                    if self.arrFilteredDatasource[textField.tag - 102].dsrCarListModel.itemProductionCost > Double(arrPrice.last!)!  {
                        self.showAlertWithMessage(message: "Sale price can not be less then the production price.")
                    }
                    else {
                        self.arrFilteredDatasource[textField.tag - 102].dsrCarListModel.itemUnitPrice = Double(arrPrice.last!)!
                        self.arrFilteredDatasource[textField.tag - 102].dsrCarListModel = DSRCartItemListModel.calculateCostMargin(self.arrFilteredDatasource[textField.tag - 102].dsrCarListModel)
                        self.tblvwItemListing.reloadSections(IndexSet(integer: textField.tag - 102), with: .none)
                        self.setCartTotalPrice()
                    }
                }
                else {
                    self.showAlertWithMessage(message: "Please enter the valid price.")
                }
            }
        }
    }
}
//MARK:- BHTextFieldDelegate
extension OrderReviewVC: BHTextFieldManagerDelegate {
    func doneKeyBoardBtn(_ sender: Any!, isLastTextFieldOrTextView type: senderIDType) {
        let txtfld = sender as! UITextField
        if txtfld != txtfldSearch {
            if txtfld.text == "" || txtfld.text == "$" {
                self.tblvwItemListing.reloadSections(IndexSet(integer: txtfld.tag - 102), with: .none)
            }
            else {
                let arrPrice = txtfld.text!.components(separatedBy: "$")
                if Double(arrPrice.last!) != nil {
                    if self.arrFilteredDatasource[txtfld.tag - 102].dsrCarListModel.itemProductionCost > Double(arrPrice.last!)!  {
                        self.showAlertWithMessage(message: "Sale price can not be less then the production price.")
                    }
                    else {
                        self.arrFilteredDatasource[txtfld.tag - 102].dsrCarListModel.itemUnitPrice = Double(arrPrice.last!)!
                        self.arrFilteredDatasource[txtfld.tag - 102].dsrCarListModel = DSRCartItemListModel.calculateCostMargin(self.arrFilteredDatasource[txtfld.tag - 102].dsrCarListModel)
                        self.tblvwItemListing.reloadSections(IndexSet(integer: txtfld.tag - 102), with: .none)
                        self.setCartTotalPrice()
                    }
                }
                else {
                    self.showAlertWithMessage(message: "Please enter the valid price.")
                }
            }
        }
    }
}
//MARK:- TableView Methods
extension OrderReviewVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrFilteredDatasource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = UINib(nibName: String(describing: DSRCartTableViewHeaderView.self), bundle: nil).instantiate(withOwner: nil, options: nil).first as? DSRCartTableViewHeaderView {
            
            headerView.delegate = self
            headerView.section = section
            headerView.setupView(self.arrFilteredDatasource[section].dsrCarListModel)
            headerView.setCollapsed(self.arrFilteredDatasource[section].isCollapsed!)
            headerView.btnAddUnit.tag = section
            headerView.btnAddUnit.addTarget(self, action: #selector(btnAddQtyHeaderTapped(_:)), for: .touchUpInside)
            headerView.btnRemoveUnit.tag = section
            headerView.btnRemoveUnit.addTarget(self, action: #selector(btnRemoveQtyHeaderTapped(_:)), for: .touchUpInside)
            
            return headerView
        }
        return nil
    }
    
    @objc func btnAddQtyHeaderTapped(_ sender: UIButton) {
        self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity = self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity + 1
        self.arrFilteredDatasource[sender.tag].dsrCarListModel = DSRCartItemListModel.calculateCostSubtotal(self.arrFilteredDatasource[sender.tag].dsrCarListModel)
        UIView.performWithoutAnimation {
        self.tblvwItemListing.reloadSections(IndexSet(integer: sender.tag), with: .none)
        }
        self.setCartTotalPrice()
    }
    
    @objc func btnRemoveQtyHeaderTapped(_ sender: UIButton) {
        if (self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity - 1) >= 0 {
            self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity = self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity - 1
            self.arrFilteredDatasource[sender.tag].dsrCarListModel = DSRCartItemListModel.calculateCostSubtotal(self.arrFilteredDatasource[sender.tag].dsrCarListModel)
            UIView.performWithoutAnimation {
            self.tblvwItemListing.reloadSections(IndexSet(integer: sender.tag), with: .none)
            }
            self.setCartTotalPrice()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrFilteredDatasource[section].isCollapsed! ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: DSRCartTableViewCell.self)
        cell.setupCell(self.arrFilteredDatasource[indexPath.section].dsrCarListModel)
        cell.txtfldUnitPrice.tag = indexPath.section + 102
        cell.txtfldUnitPrice.inputAccessoryView = self.bhFramework.setInputViewForKeyboard(cell.txtfldUnitPrice)
        self.bhFramework.isShowUpDownBtn(false)
        cell.txtfldUnitPrice.delegate = self
        cell.btnAddUnit.tag = indexPath.section
        cell.btnAddUnit.addTarget(self, action: #selector(btnAddQtyCellTapped(_:)), for: .touchUpInside)
        cell.btnRemoveUnit.tag = indexPath.section
        cell.btnRemoveUnit.addTarget(self, action: #selector(btnRemoveQtyCellTapped(_:)), for: .touchUpInside)
        
        cell.btnAddMargin.tag = indexPath.section
        cell.btnAddMargin.addTarget(self, action: #selector(btnAddMarginCellTapped(_:)), for: .touchUpInside)
        cell.btnRemoveMargin.tag = indexPath.section
        cell.btnRemoveMargin.addTarget(self, action: #selector(btnRemoveMarginCellTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func btnAddQtyCellTapped(_ sender: UIButton) {
        self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity = self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity + 1
        self.arrFilteredDatasource[sender.tag].dsrCarListModel = DSRCartItemListModel.calculateCostSubtotal(self.arrFilteredDatasource[sender.tag].dsrCarListModel)
        UIView.performWithoutAnimation {
        self.tblvwItemListing.reloadSections(IndexSet(integer: sender.tag), with: .none)
        }
        self.setCartTotalPrice()
    }
    
    @objc func btnRemoveQtyCellTapped(_ sender: UIButton) {
        if (self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity - 1) >= 0 {
            self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity = self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemQuantity - 1
            self.arrFilteredDatasource[sender.tag].dsrCarListModel = DSRCartItemListModel.calculateCostSubtotal(self.arrFilteredDatasource[sender.tag].dsrCarListModel)
            UIView.performWithoutAnimation {
            self.tblvwItemListing.reloadSections(IndexSet(integer: sender.tag), with: .none)
            }
            self.setCartTotalPrice()
        }
    }
    
    @objc func btnAddMarginCellTapped(_ sender: UIButton) {
        self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemMargin = (self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemMargin + 0.1).rounded(toPlaces: 1)
        self.arrFilteredDatasource[sender.tag].dsrCarListModel = DSRCartItemListModel.calculateCostSubtotal(self.arrFilteredDatasource[sender.tag].dsrCarListModel)
        UIView.performWithoutAnimation {
        self.tblvwItemListing.reloadSections(IndexSet(integer: sender.tag), with: .none)
        }
        self.setCartTotalPrice()
    }
    
    @objc func btnRemoveMarginCellTapped(_ sender: UIButton) {
        if (self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemMargin - 0.1) >= 0 {
            self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemMargin = (self.arrFilteredDatasource[sender.tag].dsrCarListModel.itemMargin - 0.1).rounded(toPlaces: 1)
            self.arrFilteredDatasource[sender.tag].dsrCarListModel = DSRCartItemListModel.calculateCostSubtotal(self.arrFilteredDatasource[sender.tag].dsrCarListModel)
            UIView.performWithoutAnimation {
            self.tblvwItemListing.reloadSections(IndexSet(integer: sender.tag), with: .none)
            }
            self.setCartTotalPrice()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        CustomScrollViewIndicatorShared.shared.customScrollIndicatorView?.showIndicator(scrollView)
    }
}
extension OrderReviewVC: CollapsibleTableViewSectionDelegate {
    
    func toggleSection(_ header: DSRCartTableViewHeaderView, section: Int) {
        let collapsed = !self.arrFilteredDatasource[section].isCollapsed!
        self.arrFilteredDatasource[section].isCollapsed = collapsed
        header.setCollapsed(collapsed)
        UIView.performWithoutAnimation {
        self.tblvwItemListing.reloadSections(IndexSet(integer: section), with: .none)
        }
    }
}
