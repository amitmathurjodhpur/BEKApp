//
//  DashboardItemCollectionViewCell.swift
//  BEKApp
//
//  Created by Bhavik on 04/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class DashboardItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgvwItemImage: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var btnSelection: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
