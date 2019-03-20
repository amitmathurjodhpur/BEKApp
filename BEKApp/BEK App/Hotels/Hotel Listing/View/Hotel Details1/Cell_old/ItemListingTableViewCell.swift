//
//  ItemListingTableViewCell.swift
//  WeatherDataDemo
//
//  Created by CIPL-PC68 on 05/03/19.
//  Copyright © 2019 Bhavik Barot. All rights reserved.
//

import UIKit

class ItemListingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vcMainContentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemQuantityPerPack: UILabel!
    @IBOutlet weak var lblItemUnitPrice: UILabel!
    @IBOutlet weak var lblItemQuantity: UILabel!
    @IBOutlet weak var btnAddItem: UIButton!
    @IBOutlet weak var btnRemoveItem: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vcMainContentView.layer.borderWidth = 1
        self.vcMainContentView.layer.borderColor = ColorConstants.themeColor.grey?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupCell(model: ItemListingModel) {
        self.lblTitle.text = model.itemTitle
        self.lblItemName.text = model.itemName
        self.lblItemQuantityPerPack.text = model.itemQuantityPerPack
        self.lblItemUnitPrice.text = model.itemUnitPrice
        self.lblItemQuantity.text = model.itemQunatity
    }
}
