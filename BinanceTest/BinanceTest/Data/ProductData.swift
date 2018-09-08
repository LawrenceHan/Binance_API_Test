//
//  ProductData.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/8.
//  Copyright © 2018 hanguang. All rights reserved.
//

import Foundation

struct Product: Codable {
    let data: [ProductData]
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

struct ProductData: Codable {
    let symbol: String
    let quoteAssetName: String
    let tradedMoney: Double
    let baseAssetUnit: String
    let baseAssetName: String
    let baseAsset: String
    let tickSize: String
    let prevClose: Double
    let activeBuy: Int
    let high: String
    let lastAggTradeId: Int
    let low: String
    let matchingUnitType: String
    let close: String
    let quoteAsset: String
    let productType: String?
    let active: Bool
    let minTrade: Double
    let activeSell: Double
    let withdrawFee: String
    let volume: String
    let decimalPlaces: Int
    let quoteAssetUnit: String
    let open: String
    let status: String
    let minQty: Double
}

extension ProductData: Equatable {
    public static func == (lhs: ProductData, rhs: ProductData) -> Bool {
        return lhs.symbol == rhs.symbol &&
        lhs.quoteAssetName == rhs.quoteAssetName &&
        lhs.tradedMoney == rhs.tradedMoney &&
        lhs.baseAssetUnit == rhs.baseAssetUnit &&
        lhs.baseAssetName == rhs.baseAssetName &&
        lhs.baseAsset == rhs.baseAsset &&
        lhs.tickSize == rhs.tickSize &&
        lhs.prevClose == rhs.prevClose &&
        lhs.activeBuy == rhs.activeBuy &&
        lhs.high == rhs.high &&
        lhs.lastAggTradeId == rhs.lastAggTradeId &&
        lhs.low == rhs.low &&
        lhs.matchingUnitType == rhs.matchingUnitType &&
        lhs.close == rhs.close &&
        lhs.quoteAsset == rhs.quoteAsset &&
        lhs.productType == rhs.productType &&
        lhs.active == rhs.active &&
        lhs.minTrade == rhs.minTrade &&
        lhs.activeSell == rhs.activeSell &&
        lhs.withdrawFee == rhs.withdrawFee &&
        lhs.volume == rhs.volume &&
        lhs.decimalPlaces == rhs.decimalPlaces &&
        lhs.quoteAssetUnit == rhs.quoteAssetUnit &&
        lhs.open == rhs.open &&
        lhs.status == rhs.status &&
        lhs.minQty == rhs.minQty
    }
}
