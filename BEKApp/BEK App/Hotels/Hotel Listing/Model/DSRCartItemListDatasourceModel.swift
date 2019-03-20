//
//  DSRCartItemListDatasourceModel.swift
//  CoreDataDemo
//
//  Created by Bhavik Barot on 11/03/19.
//  Copyright © 2019 Bhavik Barot. All rights reserved.
//

import UIKit

class DSRCartItemListDatasourceModel: NSObject {
    var dsrCarListModel: DSRCartItemListModel!
    var isCollapsed: Bool!
    
    init(withModel dsrCarListModel: DSRCartItemListModel!, AndCollpsed isCollapsed: Bool! = false) {
        self.dsrCarListModel = dsrCarListModel
        self.isCollapsed = isCollapsed
    }
}
