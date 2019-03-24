//
//  HotelDetailsTableViewCell.swift
//  WeatherDataDemo
//
//  Created by Bhavik Barot on 05/03/19.
//  Copyright © 2019 Bhavik Barot. All rights reserved.
//

import UIKit

class HotelDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var vwSideHighlight: UIView!
    @IBOutlet weak var vwForBorder: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vwForBorder.layer.borderWidth = 0.5
        self.vwForBorder.layer.borderColor = ColorConstants.borderColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
