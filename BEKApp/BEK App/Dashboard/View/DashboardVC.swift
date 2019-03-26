//
//  DashboardVC.swift
//  BEKApp
//
//  Created by Bhavik on 02/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class DashboardVC: BaseVC {
    
    @IBOutlet weak var dashboardOptionCollectionView: UICollectionView!
    @IBOutlet weak var lblCartBadge: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    private var arrDashboardItemList: [(itemImage: UIImage, itemName: String)] = []
    var arrItemListing: [DSRCartItemListDatasourceModel] = []
    var arrFilteredDatasource: [DSRCartItemListDatasourceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let _ = getHotelData()
        if UserDefaultsManager.shared.tmpuserName == "pizzaplanetama@hybris.com" {
            welcomeLabel.text = "Hi Lesha McAllister, here is how you are doing."
        } else if UserDefaultsManager.shared.tmpuserName == "earussel@acme.com" {
            welcomeLabel.text = "Hi Earnie Russel, here is how you are doing."
        } else if UserDefaultsManager.shared.tmpuserName == "babradley@acme.com" {
            welcomeLabel.text = "Hi Brad Bradley, here is how you are doing."
        } else {
             welcomeLabel.text = "Hi, here is how you are doing."
        }
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    public func getHotelData() -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let data = UserDefaults.standard.object(forKey: "hotelData") as? NSData, let decodedData = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? HotelListModel {
            appDelegate.hotelDetails = decodedData
            return true
        }
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrFilteredDatasource.removeAll()
        let _ = self.isCartHavingItems()
        getCartDataAndSetDatasource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- IB Actions
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
    
    func getCartDataAndSetDatasource() {
        let dbSourceFromDB = CoreDataModel.shared.showData(for: .cart) as! [Cart]
        for dbSource in dbSourceFromDB {            
            self.arrItemListing.append(DSRCartItemListDatasourceModel(withModel: DSRCartItemListModel(with: dbSource.hotelId, hotelName: dbSource.hotelName, itemId: dbSource.itemId, itemMargin: dbSource.itemMargin, itemName: dbSource.itemName!, itemPerBagQuantity: dbSource.itemPerBagQuantity!, itemProductionCost: dbSource.itemProductionCost, itemQuantity: dbSource.itemQuantity, itemSubTotal: dbSource.itemSubTotal, itemTitle: dbSource.itemTitle, itemUnitPrice: dbSource.itemUnitPrice)))
        }
        self.arrFilteredDatasource = self.arrItemListing
    }
}
//MARK:- Private Functions
extension DashboardVC {
    private func setupView() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let end = formatter.string(from: date)
        let start = formatter.string(from: date.addingTimeInterval(-7 * 24 * 60 * 60))
        endDate.text = end
        startDate.text = start
        
        self.dashboardOptionCollectionView.register(UINib(nibName: "DashboardItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DashboardItemCollectionViewCell")
        self.setupDatasourceForDashboardItems()
        let _ = self.isCartHavingItems()
    }
    
    private func setupDatasourceForDashboardItems() {
        self.arrDashboardItemList.append((itemImage: #imageLiteral(resourceName: "create"), itemName: "Create"))
        self.arrDashboardItemList.append((itemImage: #imageLiteral(resourceName: "directory"), itemName: "Directory"))
        self.arrDashboardItemList.append((itemImage: #imageLiteral(resourceName: "calendar"), itemName: "Calendar"))
        self.arrDashboardItemList.append((itemImage: #imageLiteral(resourceName: "analytics"), itemName: "Analytics"))
        self.arrDashboardItemList.append((itemImage: #imageLiteral(resourceName: "media"), itemName: "Media"))
        self.arrDashboardItemList.append((itemImage: #imageLiteral(resourceName: "settings"), itemName: "Settings"))
        self.arrDashboardItemList.append((itemImage: #imageLiteral(resourceName: "open-items"), itemName: "Open Items"))
        self.dashboardOptionCollectionView.reloadData()
    }
    
    private func isCartHavingItems() -> Bool {
        let dbSourceFromDB = CoreDataModel.shared.showData(for: .cart) as! [Cart]
        self.lblCartBadge.text = "\(dbSourceFromDB.count)"
        return dbSourceFromDB.count > 0 ? true : false
    }
}

//MARK:- Collectionview
extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrDashboardItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardItemCollectionViewCell", for: indexPath) as! DashboardItemCollectionViewCell
        cell.imgvwItemImage.image = self.arrDashboardItemList[indexPath.row].itemImage
        cell.lblItemName.text = self.arrDashboardItemList[indexPath.row].itemName
        cell.btnSelection.tag = indexPath.row
        cell.btnSelection.addTarget(self, action: #selector(dashboardItemTappedEvent(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.layoutIfNeeded()
        collectionView.setNeedsLayout()
        
        let yourWidth: CGFloat = collectionView.bounds.width/3.0
        let yourHeight: CGFloat = 105
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    @objc func dashboardItemTappedEvent(_ sendar: UIButton) {
        switch sendar.tag {
        case 1:
            let nextVC = HotelListingVC.instantiate(fromAppStoryboard: .Hotels)
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 6:
             let appDelegate = UIApplication.shared.delegate as! AppDelegate
             if let _ = appDelegate.hotelDetails, self.arrItemListing.count > 0 {
                let nextVC = ItemListingVC.instantiate(fromAppStoryboard: .Hotels)
                if let cartObj = self.arrItemListing.first {
                    let hotelID = String(cartObj.dsrCarListModel.hotelId)
                    if hotelID == "421603" {
                        nextVC.hotelDetails = HotelListModel(with: "421603", hotelName: "Big Texan Steakhouse", hotelPhone: "8063726000", hotelAddress: "7701 I-40 East, Amarillo, Tx 79118-0000", hotelEmailId: "alex.thebigtexan@hybris.com", hotelContact:"Alex Lee")
                    } else if hotelID == "422954" {
                        nextVC.hotelDetails = HotelListModel(with: "422954", hotelName: "Pizza Planet/Bell", hotelPhone: "0", hotelAddress: "6801 Bell, Amarillo, Tx 79109-0000", hotelEmailId: "pizzaplanet101@hybris.com", hotelContact: "Eddie Todd")
                    } else if hotelID == "423135" {
                        nextVC.hotelDetails = HotelListModel(with: "423135", hotelName: "Pizza Planet/Paramount", hotelPhone: "0", hotelAddress: "2400 Paramount, Amarillo, Tx 79109-0000", hotelEmailId: "pizzaplanetama@hybris.com", hotelContact: "Lesha McAllister")
                    } else if hotelID == "423852" {
                        nextVC.hotelDetails = HotelListModel(with: "423852", hotelName: "Leal S- Amarillo", hotelPhone: "8063729016", hotelAddress: "1619 S. Kentucky, Bidg. C #318, Amarillo, Tx 79102-0000", hotelEmailId: "becky@hybris.com", hotelContact: "Becky Knapp")
                    } else if hotelID == "424199" {
                        nextVC.hotelDetails = HotelListModel(with: "424199", hotelName: "Jorge S Bar Grill", hotelPhone: "0", hotelAddress: "6051 S. Bell St., Amarillo, Tx 79109-0000", hotelEmailId: "", hotelContact: "8063729016")
                    } else if hotelID == "703358" {
                        nextVC.hotelDetails = HotelListModel(with: "703358", hotelName: "Ember S Steakhouse", hotelPhone: "0", hotelAddress: "2721 Virginia St, Amarillo, Tx 79109-0000", hotelEmailId: "clardie3@hybris.com", hotelContact: "Chad Lardie")
                    } else if hotelID == "760852" {
                        nextVC.hotelDetails = HotelListModel(with: "760852", hotelName: "Jimmy S Egg Wolfin Village", hotelPhone: "8064186752", hotelAddress: "2225 S Georgia, Amarillo, Tx 79109-0000", hotelEmailId: "jdcasasanta@hybris.com", hotelContact: "John Casasanta")
                    } else if hotelID == "763185" {
                        nextVC.hotelDetails = HotelListModel(with: "763185", hotelName: "Edes Meat Martket", hotelPhone: "8065846022", hotelAddress: "6103 Hillside Rd., Amarillo, Tx 79109-0000", hotelEmailId: "sandra@hybris.com", hotelContact: "Sandra Rains")
                    } else if hotelID == "771432" {
                        nextVC.hotelDetails = HotelListModel(with: "771432", hotelName: "Pak-A-Sak 22 Amarillo", hotelPhone: "0", hotelAddress: "14841 Fm 2590, Amarillo, Tx 79109-0000", hotelEmailId: "", hotelContact: "8065846022")
                    } else if hotelID == "774410" {
                        nextVC.hotelDetails = HotelListModel(with: "774410", hotelName: "Jimmy S Egg Midland Ops L", hotelPhone: "4052039403", hotelAddress: "1904 Loop 250 Frontage Ro, Amarillo, Tx 79103-0000", hotelEmailId: "aoneil@hybris.com", hotelContact: "Angela O'Neil")
                    }
                }
                nextVC.isComeFromHistory = true
                appDelegate.TempArrayOrderHistory = self.arrFilteredDatasource
                self.navigationController?.pushViewController(nextVC, animated: true)
             } else {
                self.showAlertWithMessage(message: "No Open Items")
            }
            
        default:
            self.showAlertWithMessage(message: "Coming Soon...")
        }
    }
}
