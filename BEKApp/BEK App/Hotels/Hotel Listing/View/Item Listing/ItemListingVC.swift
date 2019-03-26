//
//  ItemListingVC.swift
//  BEKApp
//
//  Created by Bhavik on 05/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit
import BHTextFieldManager

class ItemListingVC: BaseVC {
    
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
    @IBOutlet weak var btnReviewOrder: UIButton!
    @IBOutlet weak var voiceAlertViewContainer: UIView!
    
    @IBOutlet weak var lblCartBadge: UILabel!
    @IBOutlet weak var vwCartBadge: UIView!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var popupImage: UIImageView!
    @IBOutlet weak var popupTitle: UILabel!
    @IBOutlet weak var popupDesc: UILabel!
    
    @IBOutlet weak var lblVCTitle: UILabel!
    
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var imageDict: Dictionary<String, String> = [:]
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
                self.bottomViewHeightConstraint.constant = 221 - 96 - 3
            }
            else {
                self.vwSwitchUserModeRightConstraint.isActive = false
                self.vwSwitchUserModeLeftConstraint.isActive = true
                
                self.lblSwitchUserModeRightConstraint.isActive = true
                self.lblSwitchUserModeLeftConstraint.isActive = false
                self.lblSwitchUserMode.text = UserType.DSR.rawValue
                self.vwBottumExpandedPriceDetail.isHidden = false
                self.lblTotalAomount.isHidden = true
                self.bottomViewHeightConstraint.constant = 221
            }
            self.updateDataSourceForDSRMode()
        }
    }
    var isComeFromHistory: Bool = false
    private var responseData: GetProductListSearchResponse?
    var arrItemListing: [DSRCartItemListDatasourceModel] = []
    var arrFilteredDatasource: [DSRCartItemListDatasourceModel]! = [] {
        didSet {
            UIView.performWithoutAnimation {
                self.tblvwItemListing.reloadData()
            }
            self.setCartTotalPrice()
        }
    }
    private var isFiltered: Bool! = false
    
    var hotelDetails: HotelListModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.TempArrayOrderHistory)
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setView(view: popView, hidden: true)
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.popView.isHidden = hidden
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getCartDataAndSetDatasource()
        //        self.bhFramework.setEnable(self.view)
        self.bhFramework.delegate = self
        let _ = self.isCartHavingItems()
        self.isClientModeOn = UserDefaultsManager.shared.isClientModeOn
        
        
        
        
        print(self.arrFilteredDatasource)
        self.setCartTotalPrice()
        
        
    }
    
    //MARK:- IB Actions
    
    @IBAction func switchUserModeEvent(_ sender: UIButton) {
        UserDefaultsManager.shared.isClientModeOn = !self.isClientModeOn
        self.isClientModeOn = !self.isClientModeOn
    }
    
    @IBAction func dismissPopup(_ sender: UIButton) {
        setView(view: popView, hidden: true)
    }
    
    @IBAction func btnReviewTapped(_ sender: UIButton) {
        let nextVC = OrderReviewVC.instantiate(fromAppStoryboard: .Hotels)
        nextVC.hotelDetails = self.hotelDetails
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cartBtnAction(_ sender: UIButton) {
        if isCartHavingItems() {
            let nextVC = OrderReviewVC.instantiate(fromAppStoryboard: .Hotels)
            nextVC.hotelDetails = self.hotelDetails
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
//MARK:- Private Function
extension ItemListingVC {
    private func setupView() {
        if !self.isComeFromHistory {
            CoreDataModel.shared.deleteAllCartData(for: .cart)
        }
        self.lblVCTitle.text = self.hotelDetails.hotelName
        self.txtfldSearch.delegate = self
        self.isClientModeOn = UserDefaultsManager.shared.isClientModeOn
        self.customScrollIndicator.layoutIfNeeded()
        self.customScrollIndicator.setNeedsLayout()
        self.customScrollIndicator.insertSubview(CustomScrollViewIndicatorShared.shared.customScrollIndicatorView!, at: 0)
        self.tblvwItemListing.registerCellWithNib(class: DSRCartTableViewCell.self)
        
        //        self.arrFilteredDatasource.append((model: DSRCartItemListModel(with: Int64(Int(self.hotelDetails.hotelId) ?? 0), hotelName: self.hotelDetails.hotelName, itemId: 1, itemMargin: 0.0, itemName: "Chicken Wings Spicy Buffalo", itemPerBagQuantity: "", itemProductionCost: 36.68, itemQuantity: 0, itemSubTotal: 0.0, itemTitle: "Predue", itemUnitPrice: 36.68), collapsed: false))
        self.getItemListAPICall()
        self.setupUI()
        
        if let path = Bundle.main.path(forResource: "products", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, String> {
                    imageDict = jsonResult
                }
            } catch {
                print("Error")
            }
        }
    }
    
    private func setupUI() {
        self.tblvwItemListing.layer.borderWidth = 1
        self.tblvwItemListing.layer.borderColor = ColorConstants.borderColor.gray.cgColor
        
        self.vwSearchMain.layer.borderWidth = 1
        self.vwSearchMain.layer.borderColor = ColorConstants.borderColor.gray.cgColor
        CustomScrollViewIndicatorShared.shared.setupThemeIndicator()
        
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
    
    private func isCartHavingItems() -> Bool {
        let dbSourceFromDB = CoreDataModel.shared.showData(for: .cart) as! [Cart]
        self.lblCartBadge.text = "\(dbSourceFromDB.count)"
        return dbSourceFromDB.count > 0 ? true : false
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
    
    private func saveProductAPIDataToProductList(_ productList: [GetProductListSearchProduct]?) {
        
        let dbSource = CoreDataModel.shared.getDataFromProductList(for: Int64(self.hotelDetails!.hotelId)!) as! [ProductList]
        
        if dbSource.count <= 0 {
            if productList != nil {
                for item in productList! {
                    
                    var model = DSRCartItemListModel(with: Int64(Int(self.hotelDetails.hotelId) ?? 0), hotelName: self.hotelDetails.hotelName, itemId: Int64(Int("\(item.code ?? "0")") ?? 0), itemMargin: 0.0, itemName: item.name ?? "Product Name", itemPerBagQuantity: item.summary ?? "", itemProductionCost: Double(item.cost ?? 0.0).rounded(toPlaces: 2), itemQuantity: 0, itemSubTotal: 0.0, itemTitle: item.manufacturer, itemUnitPrice: Double(item.price?.value ?? 0.0).rounded(toPlaces: 2))
                    model = DSRCartItemListModel.calculateCostMargin(model)
                    CoreDataModel.shared.saveDataToProductList(with: model.hotelId, hotelName: model.hotelName, itemMargin: model.itemMargin, itemName: model.itemName, itemPerBagQuantity: model.itemPerBagQuantity, itemProductionCost: model.itemProductionCost, itemQuantity: model.itemQuantity, itemSubTotal: model.itemSubTotal, itemTitle: model.itemTitle, itemUnitPrice: model.itemUnitPrice)
                }
            }
        }
        else {
            for item in dbSource {
                let _ = CoreDataModel.shared.deleteProductListData(ProductId: item.objectID)
            }
            if productList != nil {
                for item in productList! {
                    var model = DSRCartItemListModel(with: Int64(Int(self.hotelDetails.hotelId) ?? 0), hotelName: self.hotelDetails.hotelName, itemId: Int64(Int("\(item.code ?? "0")") ?? 0), itemMargin: 0.0, itemName: item.name ?? "Product Name", itemPerBagQuantity: item.summary ?? "", itemProductionCost: Double(item.cost ?? 0.0).rounded(toPlaces: 2), itemQuantity: 0, itemSubTotal: 0.0, itemTitle: item.manufacturer, itemUnitPrice: Double(item.price?.value ?? 0.0).rounded(toPlaces: 2))
                    model = DSRCartItemListModel.calculateCostMargin(model)
                    CoreDataModel.shared.saveDataToProductList(with: model.hotelId, hotelName: model.hotelName, itemMargin: model.itemMargin, itemName: model.itemName, itemPerBagQuantity: model.itemPerBagQuantity, itemProductionCost: model.itemProductionCost, itemQuantity: model.itemQuantity, itemSubTotal: model.itemSubTotal, itemTitle: model.itemTitle, itemUnitPrice: model.itemUnitPrice)
                }
            }
        }
    }
    
    private func getSelectedItems() -> [DSRCartItemListDatasourceModel] {
        var arrSelected = [DSRCartItemListDatasourceModel]()
        for item in self.arrItemListing {
            if item.dsrCarListModel.itemSubTotal > 0 {
                arrSelected.append(item)
            }
        }
        return arrSelected
    }
    
    private func getCartDataAndSetDatasource() {
        var dbSource = CoreDataModel.shared.showData(for: .cart) as! [Cart]
        //        if dbSource.count == 0 {
        //            self.createCartForUser()
        //        }
        var i = 0
        for item in self.arrItemListing {
            if let index = dbSource.index(where: {$0.itemId == item.dsrCarListModel.itemId}) {
                self.arrItemListing[i].dsrCarListModel = DSRCartItemListModel(with: dbSource[index].hotelId, hotelName: dbSource[index].hotelName, itemId: dbSource[index].itemId, itemMargin: dbSource[index].itemMargin, itemName: dbSource[index].itemName!, itemPerBagQuantity: dbSource[index].itemPerBagQuantity!, itemProductionCost: dbSource[index].itemProductionCost, itemQuantity: dbSource[index].itemQuantity, itemSubTotal: dbSource[index].itemSubTotal, itemTitle: dbSource[index].itemTitle, itemUnitPrice: dbSource[index].itemUnitPrice)
            }
            i += 1
        }
        
        if appDelegate.TempArrayOrderHistory.count>0
        {
            var j = 0
            for items in appDelegate.TempArrayOrderHistory
            {
                var k = 0
                
                for item2 in self.arrItemListing
                {
                    if items.dsrCarListModel.itemId == item2.dsrCarListModel.itemId
                    {
                        item2.dsrCarListModel.itemQuantity = items.dsrCarListModel.itemQuantity
                        item2.dsrCarListModel.itemMargin = items.dsrCarListModel.itemMargin
                        item2.dsrCarListModel.itemSubTotal = items.dsrCarListModel.itemSubTotal
                        item2.dsrCarListModel.itemProductionCost = items.dsrCarListModel.itemProductionCost
                        
                        self.arrItemListing[k] = item2
                        
                    }
                    k=k+1
                }
                j=j+1
            }
        }
        
        self.arrFilteredDatasource = self.arrItemListing
        self.setCartTotalPrice()
        self.updateDataSourceForDSRMode()
    }
    
    private func getCartDataAndSetDatasourceForOfflineProductList() {
       // let dbSource = CoreDataModel.shared.getDataFromProductList(for: Int64(self.hotelDetails!.hotelId)!) as! [ProductList]
         let dbSource = CoreDataModel.shared.getDataFromProductList_Offline(for: Int64(self.hotelDetails!.hotelId)!) as! [ProductList]
        for item in dbSource {
            self.arrItemListing.append(DSRCartItemListDatasourceModel(withModel: DSRCartItemListModel(with: item.hotelId, hotelName: item.hotelName, itemId: item.itemId, itemMargin: item.itemMargin, itemName: item.itemName!, itemPerBagQuantity: item.itemPerBagQuantity!, itemProductionCost: item.itemProductionCost, itemQuantity: item.itemQuantity, itemSubTotal: item.itemSubTotal, itemTitle: item.itemTitle, itemUnitPrice: item.itemUnitPrice)))
        }
        self.getCartDataAndSetDatasource()
    }
    
    private func setCartTotalPrice() {
        var itemTotal: Double! = 0
        var itemMargin: Double! = 0
        var itemCost: Double! = 0
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
        self.btnReviewOrder.isEnabled = self.getSelectedItems().count > 0 ? true : false
        self.btnReviewOrder.alpha = self.getSelectedItems().count > 0 ? 1.0 : 0.4
        let _ = self.setCartItemToDatabase()
        self.updateDataSourceForDSRMode()
        let _ = self.isCartHavingItems()
    }
    
    private func setupDatasourceForProductList(_ productList: [GetProductListSearchProduct]?) {
        self.arrFilteredDatasource.removeAll()
        self.arrItemListing.removeAll()
        if productList != nil {
            for item in productList! {
                self.arrItemListing.append(DSRCartItemListDatasourceModel(withModel: DSRCartItemListModel(with: Int64(Int(self.hotelDetails.hotelId) ?? 0), hotelName: self.hotelDetails.hotelName, itemId: Int64(Int("\(item.code ?? "0")") ?? 0), itemMargin: 0.0, itemName: item.name ?? "Product Name", itemPerBagQuantity: item.summary ?? "", itemProductionCost: Double(item.cost ?? 0.0).rounded(toPlaces: 2), itemQuantity: 0, itemSubTotal: 0.0, itemTitle: item.manufacturer, itemUnitPrice: Double(item.price?.value ?? 0.0).rounded(toPlaces: 2))))
                self.arrItemListing.last?.dsrCarListModel = DSRCartItemListModel.calculateCostMargin((self.arrItemListing.last?.dsrCarListModel)!)
            }
        }
        self.getCartDataAndSetDatasource()
    }
    
    private func filterProduct(_ term: String) {
        if term != "" {
            self.arrFilteredDatasource = self.arrItemListing.filter { $0.dsrCarListModel.itemName.lowercased().contains(term.lowercased()) }
        }
        else {
            self.arrFilteredDatasource = self.arrItemListing
        }
    }
}
//MARK:- Voice Search
extension ItemListingVC: VoiceSearchInstructionViewDelegate {
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
extension ItemListingVC: UITextFieldDelegate {
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
//MARK:- API Calls
extension ItemListingVC {
    private func getItemListAPICall() {
        self.showLoadingIndicator()
        APIHelper.shared.get(request: [:], to: HTTPClient().createEndPoint(endPoint: HTTPClient.Products.ProductList.rawValue)) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: GetProductListSearchResponse.self, responseDic, completion: { (responseModel) in
                        self.responseData = responseModel
                        if responseModel?.products != nil {
                            self.setupDatasourceForProductList(responseModel?.products)
                            self.saveProductAPIDataToProductList(responseModel?.products)
                        }
                        else {
                            let alrt = UIAlertController(title: "BEKApp", message: "\((responseDic["error"] as? Array<[String:Any]>)?.first?["message"] ?? "Opps Something went wrong please try again.")", preferredStyle: .alert)
                            alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alrt, animated: true, completion: nil)
                        }
                    })
                }
            }
            else {
                //Net is off
                //                self.showAlertWithMessage(message: "Please check your network connection.")
                self.getCartDataAndSetDatasourceForOfflineProductList()
            }
            self.hideLoadingIndicator()
        }
    }
    
    private func createCartForUser() {
        self.showLoadingIndicator()
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/\(UserDefaultsManager.shared.userName)"
        
        APIHelper.shared.get(request: [:], to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: CreateCartResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.code != nil {
                            UserDefaultsManager.shared.cartID = responseModel?.code
                        }
                        else {
                            let alrt = UIAlertController(title: "BEKApp", message: "\(responseDic["error_description"] ?? "Opps Something went wrong please try again.")", preferredStyle: .alert)
                            alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alrt, animated: true, completion: nil)
                        }
                    })
                }
            }
            else {
                //Net is off
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
            self.hideLoadingIndicator()
        }
    }
    
    private func addProductToCartForUser(productId: String, Quantity qty: Int) {
        self.showLoadingIndicator()
        let url = "\(HTTPClient.BaseURL.Development.rawValue)/rest/v2/powertools/\(UserDefaultsManager.shared.userName)/carts/\(UserDefaultsManager.shared.cartID ?? "")/entries"
        let productDic: [String: Any] = ["code": productId]
        var reqDic: [String: Any] = [:]
        reqDic["product"] = productDic
        reqDic["quantity"] = qty
        
        APIHelper.shared.get(request: reqDic, to: url) { (responseDic, isError, isNetOn) in
            if isNetOn {
                //Net is on
                if isError {
                    //Error, Try Again
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: AddProductToCartResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.statusCode == "Success" {
                            
                        }
                        else {
                            let alrt = UIAlertController(title: "BEKApp", message: "\(responseDic["error_description"] ?? "Opps Something went wrong please try again.")", preferredStyle: .alert)
                            alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alrt, animated: true, completion: nil)
                        }
                    })
                }
            }
            else {
                //Net is off
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
            self.hideLoadingIndicator()
        }
    }
    
    private func deleteProductToCartForUser(productId: String, Quantity qty: Int) {
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
                    self.showAlertWithMessage(message: "Opps Something went wrong please try again.")
                }
                else {
                    //No Error
                    GetMapperModel.shared.getMapper(mapper: AddProductToCartResponse.self, responseDic, completion: { (responseModel) in
                        if responseModel?.statusCode == "Success" {
                            
                        }
                        else {
                            let alrt = UIAlertController(title: "BEKApp", message: "\(responseDic["error_description"] ?? "Opps Something went wrong please try again.")", preferredStyle: .alert)
                            alrt.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alrt, animated: true, completion: nil)
                        }
                    })
                }
            }
            else {
                //Net is off
                self.showAlertWithMessage(message: "Please check your network connection.")
            }
            self.hideLoadingIndicator()
        }
    }
    
    func getImageName(productName: String) -> String {
        if let jsonResult = imageDict as Dictionary<String, String>?, let product = jsonResult[caseInsensitive: productName] {
            print(product)
            return product
        }
        return "155195.jpeg"
    }
}
//MARK:- BHTextFieldDelegate
extension ItemListingVC: BHTextFieldManagerDelegate {
    func doneKeyBoardBtn(_ sender: Any!, isLastTextFieldOrTextView type: senderIDType) {
        let txtfld = sender as! UITextField
        if txtfld != txtfldSearch {
            if txtfld.text == "" || txtfld.text == "$" {
                self.tblvwItemListing.reloadSections(IndexSet(integer: txtfld.tag - 102), with: .none)
            }
            else {
                //                let cell = self.tblvwItemListing.cellForRow(at: IndexPath(row: 0, section: txtfld.tag - 102)) as! DSRCartTableViewCell
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
extension ItemListingVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
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
            headerView.tag = section
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showAlert))
            tapRecognizer.delegate = self as? UIGestureRecognizerDelegate
            tapRecognizer.numberOfTapsRequired = 1
            tapRecognizer.numberOfTouchesRequired = 1
            headerView.addGestureRecognizer(tapRecognizer)
            return headerView
        }
        return nil
    }
    
    @objc func showAlert(gestureRecognizer: UIGestureRecognizer) {
        if let v1 = gestureRecognizer.view?.tag, let listObj = self.arrFilteredDatasource[v1].dsrCarListModel {
            print(listObj.itemName)
            print(listObj.itemName)
            self.popupImage.image = UIImage(named: self.getImageName(productName: "\(listObj.itemName ?? "155195.jpeg")"))
            self.popupTitle.text = listObj.itemName
            self.popupDesc.text = "Golden Harvest cream cheese is a fresh, natural cheese that can be used as a spread or dip, as well as in sweet or savory dishes. Smooth and creamy, its primary ingredient is cream rather than milk. A starter culture is added to the milk and cream. This process causes it to ferment and creates cream cheese’s unique texture and flavor.\n \nA holiday staple to keep in your kitchen, make sure you have plenty on hand!" //listObj.itemPerBagQuantity
            setView(view: popView, hidden: false)
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  let listObj = self.arrFilteredDatasource[indexPath.section].dsrCarListModel {
            print(listObj.itemName)
            self.popupImage.image = UIImage(named: self.getImageName(productName: "\(listObj.itemName ?? "155195.jpeg")"))
            self.popupTitle.text = listObj.itemName
            self.popupDesc.text = "Golden Harvest cream cheese is a fresh, natural cheese that can be used as a spread or dip, as well as in sweet or savory dishes. Smooth and creamy, its primary ingredient is cream rather than milk. A starter culture is added to the milk and cream. This process causes it to ferment and creates cream cheese’s unique texture and flavor.\n \nA holiday staple to keep in your kitchen, make sure you have plenty on hand!" //listObj.itemPerBagQuantity
            setView(view: popView, hidden: false)
        }
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
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return self.arrFilteredDatasource.count
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withClass: ItemListingTableViewCell.self)
    //        cell.setupCell(model: self.arrFilteredDatasource[indexPath.row])
    //        cell.btnAddItem.tag = indexPath.row
    //        cell.btnAddItem.addTarget(self, action: #selector(btnAddTappedEvent(_:)), for: .touchUpInside)
    //        cell.btnRemoveItem.tag = indexPath.row
    //        cell.btnRemoveItem.addTarget(self, action: #selector(btnRemoveTappedEvent(_:)), for: .touchUpInside)
    //        return cell
    //    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        CustomScrollViewIndicatorShared.shared.customScrollIndicatorView?.showIndicator(scrollView)
    }
}
extension ItemListingVC: CollapsibleTableViewSectionDelegate {
    
    func toggleSection(_ header: DSRCartTableViewHeaderView, section: Int) {
        let collapsed = !self.arrFilteredDatasource[section].isCollapsed!
        self.arrFilteredDatasource[section].isCollapsed = collapsed
        header.setCollapsed(collapsed)
        UIView.performWithoutAnimation {
            self.tblvwItemListing.reloadSections(IndexSet(integer: section), with: .none)
        }
    }
}
