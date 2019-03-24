//
//  DSRCartTableViewHeaderView.swift
//  BEKApp
//
//  Created by Bhavik Barot on 07/03/19.
//  Copyright © 2019 Bhavik Barot. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewSectionDelegate {
    func toggleSection(_ header: DSRCartTableViewHeaderView, section: Int)
}

class DSRCartTableViewHeaderView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemQuantityPerUnit: UILabel!
    @IBOutlet weak var lblItemUnitPrice: UILabel!
    @IBOutlet weak var lblItemQuantity: UILabel!
    @IBOutlet weak var btnAddUnit: UIButton!
    @IBOutlet weak var btnRemoveUnit: UIButton!
    @IBOutlet weak var vwAddQuantity: UIView!
    @IBOutlet weak var vwSaperator: UIView!
    
    var delegate: CollapsibleTableViewSectionDelegate?
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vwSaperator.backgroundColor = ColorConstants.borderColor.gray
    }
    
    func setupView(_ model: DSRCartItemListModel) {
        self.lblTitle.text = model.itemTitle
        self.lblItemName.text = model.itemName
        self.lblItemQuantityPerUnit.text = model.itemPerBagQuantity
        self.lblItemUnitPrice.text = "$" + "\(model.itemUnitPrice ?? 0.0)"
        self.lblItemQuantity.text = "\(model.itemQuantity ?? 0)"
    }
    
    @objc func tapBtnAdd(_ sender: UISwitch) {
        if delegate != nil {
            delegate?.toggleSection(self, section: self.section)
        }
    }
    
    func setCollapsed(_ collapsed: Bool) {
        self.vwAddQuantity.isHidden = collapsed
        self.vwSaperator.isHidden = collapsed
    }
}
