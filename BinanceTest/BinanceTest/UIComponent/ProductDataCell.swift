//
//  ProductDataCell.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/9.
//  Copyright © 2018 hanguang. All rights reserved.
//

import UIKit

class ProductDataCell: UITableViewCell {
    
    let symbolLabel: UILabel!
    let volumeLabel: UILabel!
    let openLabel: UILabel!
    let dollarLabel: UILabel!
    
    var data: ProductData?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        symbolLabel = UILabel()
        volumeLabel = UILabel()
        openLabel = UILabel()
        dollarLabel = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.superview?.clipsToBounds = false
        let bg = UIView()
        bg.backgroundColor = UIColor(hex: 0x15161C)
        selectedBackgroundView = bg
        contentView.backgroundColor = UIColor(hex: 0x15161C)
        
        symbolLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(symbolLabel)
        
        volumeLabel.font = UIFont.systemFont(ofSize: 14)
        volumeLabel.textColor = UIColor(hex: 0x777883)
        contentView.addSubview(volumeLabel)
        
        openLabel.font = UIFont.boldSystemFont(ofSize: 16)
        openLabel.textColor = UIColor.white
        contentView.addSubview(openLabel)
        
        dollarLabel.font = UIFont.systemFont(ofSize: 14)
        dollarLabel.textColor = UIColor(hex: 0x777883)
        contentView.addSubview(dollarLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetView(_ keepState: Bool) {
        guard let data = data else {
            return
        }
        
        let symbol = data.baseAsset + " / " + data.quoteAsset
        let attr = NSMutableAttributedString(string: symbol)
        attr.addAttributes(
            [
                NSAttributedStringKey.foregroundColor : UIColor.white,
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)
            ],
            range: NSMakeRange(0, data.baseAsset.count)
        )
        attr.addAttributes(
            [
                NSAttributedStringKey.foregroundColor : UIColor(hex: 0x898A95)!,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)
            ],
            range: NSMakeRange(data.baseAsset.count, data.quoteAsset.count+3)
        )
        symbolLabel.attributedText = attr
//        symbolLabel.sizeToFit()
        
        volumeLabel.text = "Vol " + data.volume
        
        openLabel.text = data.open
        
        dollarLabel.text = "$ " + String(data.tradedMoney)
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        symbolLabel.sizeToFit()
        symbolLabel.frame = CGRect(
            x: 25,
            y: 15,
            width: symbolLabel.frame.size.width,
            height: symbolLabel.frame.size.height
        )
        
        volumeLabel.sizeToFit()
        volumeLabel.frame = CGRect(
            x: symbolLabel.frame.origin.x,
            y: symbolLabel.frame.origin.x+symbolLabel.frame.size.height+3,
            width: volumeLabel.frame.size.width,
            height: volumeLabel.frame.size.height
        )
        
        openLabel.sizeToFit()
        openLabel.frame = CGRect(
            x: contentView.frame.size.width*0.75-50,
            y: 15,
            width: openLabel.frame.size.width,
            height: openLabel.frame.size.height
        )
        
        dollarLabel.sizeToFit()
        dollarLabel.frame = CGRect(
            x: openLabel.frame.origin.x,
            y: volumeLabel.frame.origin.y,
            width: volumeLabel.frame.size.width,
            height: volumeLabel.frame.size.height
        )
    }
}
