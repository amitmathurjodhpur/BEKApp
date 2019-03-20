//
//  DSRCartTableViewCell.swift
//  BEKApp
//
//  Created by Bhavik Barot on 07/03/19.
//  Copyright © 2019 Bhavik Barot. All rights reserved.
//

import UIKit

class DSRCartTableViewCell: UITableViewCell {

    @IBOutlet weak var lblProductionCost: UILabel!
    @IBOutlet weak var lblSubtotal: UILabel!
    @IBOutlet weak var vwUnitPrice: UIView!
    @IBOutlet weak var txtfldUnitPrice: UITextField!
    @IBOutlet weak var lblItemMargin: UILabel!
    @IBOutlet weak var lblItemQuantity: UILabel!
    @IBOutlet weak var btnAddUnit: UIButton!
    @IBOutlet weak var btnRemoveUnit: UIButton!
    @IBOutlet weak var btnAddMargin: UIButton!
    @IBOutlet weak var btnRemoveMargin: UIButton!
    @IBOutlet weak var vwSaperator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUI()
    }
    
    private func setupUI() {
        self.vwUnitPrice.layer.borderWidth = 0.5
        self.vwUnitPrice.layer.borderColor = ColorConstants.borderColor.gray.cgColor
        self.vwSaperator.backgroundColor = ColorConstants.borderColor.gray
    }
    
    func setupCell(_ model: DSRCartItemListModel) {
        self.lblProductionCost.text = "$" + "\(model.itemProductionCost ?? 0.0)"
        self.lblSubtotal.text = "$" + "\(model.itemSubTotal ?? 0.0)"
        self.lblItemMargin.text = "\(model.itemMargin ?? 0.0)" + "%"
        self.txtfldUnitPrice.text = "$" + "\(model.itemUnitPrice ?? 0.0)"
        self.lblItemQuantity.text = "\(model.itemQuantity ?? 0)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
}
