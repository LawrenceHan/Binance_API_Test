//
//  UIUtils.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/9.
//  Copyright © 2018 hanguang. All rights reserved.
//

import UIKit

protocol ReuseableView {}
extension ReuseableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseableView {}

extension UITableView {
    func register<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Could not dequeue cell with identifier: \(Cell.reuseIdentifier)")
        }
        return cell
    }
}

extension UIView {
    
    var safeTopValue: CGFloat {
        if #available(iOS 11.0, *), iPhoneX() {
            return self.safeAreaInsets.top
        } else {
            return 0
        }
    }
    
    var safeLeftValue: CGFloat {
        if #available(iOS 11.0, *), iPhoneX() {
            return self.safeAreaInsets.left
        }else {
            return 0
        }
    }
    
    var safeRightValue: CGFloat {
        if #available(iOS 11.0, *), iPhoneX() {
            return self.safeAreaInsets.right
        }else {
            return 0
        }
    }
    
    var safeBottomValue: CGFloat {
        if #available(iOS 11.0, *), iPhoneX() {
            return self.safeAreaInsets.bottom
        } else {
            return 0
        }
    }
}

func iPhoneX() -> Bool {
    if UIDevice().userInterfaceIdiom == .phone {
        if UIScreen.main.nativeBounds.height >= 2436 {
            return true
        }
    }
    return false
}
