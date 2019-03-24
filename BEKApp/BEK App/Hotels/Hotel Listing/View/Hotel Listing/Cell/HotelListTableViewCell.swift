//
//  HotelListTableViewCell.swift
//  BEKApp
//
//  Created by Bhavik on 04/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class HotelListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblHotelName: UILabel!
    @IBOutlet weak var lblHotelAddress: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var vwBottomSaperator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.vwBottomSaperator.backgroundColor = ColorConstants.borderColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func setTextForAddressLabel(with string: String) {
        let textRange = NSMakeRange(0, string.count)
        let attributedText = NSMutableAttributedString(string: string)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        self.lblHotelAddress.attributedText = attributedText
    }
    
}
