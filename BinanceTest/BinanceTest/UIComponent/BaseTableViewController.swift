/*
Copyright (C) 2018 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Base or common view controller to share a common UITableViewCell prototype between subclasses.
*/

import UIKit

class BaseTableViewController: UITableViewController {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Required if our subclasses are to use `dequeueReusableCellWithIdentifier(_:forIndexPath:)`.
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorColor = UIColor(hex: 0x1D1F24)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        tableView.register(ProductDataCell.self)
        tableView.backgroundColor = UIColor.gray
        tableView.allowsSelection = false
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    // MARK: - Configuration
    
    // There are 2 best practices, either you configure cell in ViewController or
    // you leave it to cell itself. I will explain more details about it face to face.
    func configureCell(_ cell: UITableViewCell, forProduct product: ProductData) {
        guard let cell = cell as? ProductDataCell else {
            return
        }
        
        // Do some fancy stuff such as format numbers
        cell.data = product
        
        // Then take control for cell layout
        cell.resetView(false)
    }
}

