//
//  CellConfigurable.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/9.
//  Copyright © 2018 hanguang. All rights reserved.
//

import UIKit

protocol CellConfigurable {}

extension CellConfigurable {
    
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
