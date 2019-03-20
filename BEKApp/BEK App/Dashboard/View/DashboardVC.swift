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

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaultsManager.shared.userName == "pizzaplanetama@hybris.com" {
            welcomeLabel.text = "Hi Lesha McAllister, here is how you are doing."
        } else if UserDefaultsManager.shared.userName == "earussel@acme.com" {
            welcomeLabel.text = "Hi Earnie Russel, here is how you are doing."
        } else if UserDefaultsManager.shared.userName == "babradley@acme.com" {
            welcomeLabel.text = "Hi Brad Bradley, here is how you are doing."
        } else {
             welcomeLabel.text = "Hi, here is how you are doing."
        }
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let _ = self.isCartHavingItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- IB Actions
    @IBAction func cartBtnAction(_ sender: UIButton) {
        if self.isCartHavingItems() {
            let nextVC = OrderReviewVC.instantiate(fromAppStoryboard: .Hotels)
            nextVC.hotelDetails = nil
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        else {
            self.showAlertWithMessage(message: "Your cart is empty. Please enter some item to it.")
        }
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
        default:
            self.showAlertWithMessage(message: "Coming Soon...")
        }
    }
}
