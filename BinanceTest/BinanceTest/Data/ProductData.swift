//
//  ProductData.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/8.
//  Copyright © 2018 hanguang. All rights reserved.
//

import Foundation

class Product: NSObject, Codable {
    @objc var data: [ProductData] = []
}

//{
//    "symbol": "NULSBNB",
//    "quoteAssetName": "Binance Coin",
//    "tradedMoney": 1580.085984,
//    "baseAssetUnit": "",
//    "baseAssetName": "Nuls",
//    "baseAsset": "NULS",
//    "tickSize": "0.00001",
//    "prevClose": 0.1332,
//    "activeBuy": 0,
//    "high": "0.13615",
//    "lastAggTradeId": -1,
//    "low": "0.13000",
//    "matchingUnitType": "STANDARD",
//    "close": "0.13270",
//    "quoteAsset": "BNB",
//    "productType": null,
//    "active": true,
//    "minTrade": 0.1,
//    "activeSell": 11878.6,
//    "withdrawFee": "0",
//    "volume": "11878.60000",
//    "decimalPlaces": 8,
//    "quoteAssetUnit": "",
//    "open": "0.13320",
//    "status": "TRADING",
//    "minQty": 1e-8
//}

class ProductData: NSObject, Codable {
    @objc var symbol: String = ""
    @objc var quoteAssetName: String = ""
    @objc var tradedMoney: Double = 0
    @objc var baseAssetUnit: String = ""
    @objc var baseAssetName: String = ""
    @objc var baseAsset: String = ""
    @objc var tickSize: String = ""
    @objc var prevClose: Double = 0
    @objc var activeBuy: Int = 0
    @objc var high: String = ""
    @objc var lastAggTradeId: Int = 0
    @objc var low: String = ""
    @objc var matchingUnitType: String = ""
    @objc var close: String = ""
    @objc var quoteAsset: String = ""
    @objc var productType: String?
    @objc var active: Bool = false
    @objc var minTrade: Double = 0
    @objc var activeSell: Double = 0
    @objc var withdrawFee: String = ""
    @objc var volume: String = ""
    @objc var decimalPlaces: Int = 0
    @objc var quoteAssetUnit: String = ""
    @objc var open: String = ""
    @objc var status: String = ""
    @objc var minQty: Double = 0
}

//extension ProductData: Equatable {
//    public static func == (lhs: ProductData, rhs: ProductData) -> Bool {
//        return lhs.symbol == rhs.symbol &&
//        lhs.quoteAssetName == rhs.quoteAssetName &&
//        lhs.tradedMoney == rhs.tradedMoney &&
//        lhs.baseAssetUnit == rhs.baseAssetUnit &&
//        lhs.baseAssetName == rhs.baseAssetName &&
//        lhs.baseAsset == rhs.baseAsset &&
//        lhs.tickSize == rhs.tickSize &&
//        lhs.prevClose == rhs.prevClose &&
//        lhs.activeBuy == rhs.activeBuy &&
//        lhs.high == rhs.high &&
//        lhs.lastAggTradeId == rhs.lastAggTradeId &&
//        lhs.low == rhs.low &&
//        lhs.matchingUnitType == rhs.matchingUnitType &&
//        lhs.close == rhs.close &&
//        lhs.quoteAsset == rhs.quoteAsset &&
//        lhs.productType == rhs.productType &&
//        lhs.active == rhs.active &&
//        lhs.minTrade == rhs.minTrade &&
//        lhs.activeSell == rhs.activeSell &&
//        lhs.withdrawFee == rhs.withdrawFee &&
//        lhs.volume == rhs.volume &&
//        lhs.decimalPlaces == rhs.decimalPlaces &&
//        lhs.quoteAssetUnit == rhs.quoteAssetUnit &&
//        lhs.open == rhs.open &&
//        lhs.status == rhs.status &&
//        lhs.minQty == rhs.minQty
//    }
//}
