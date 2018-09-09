//
//  GetProductActor.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/9.
//  Copyright © 2018 hanguang. All rights reserved.
//

import ActionStageSwift
import POPAPIKit

class GetProductActor: BaseActor {
    
    override class func genericPath() -> String? {
        return "/exchange/public/product"
    }
    
    override func execute(options: [String: Any]?, completion: ((String, Any?, Any?) -> Void)?) {
        
        let start = CFAbsoluteTimeGetCurrent()
        
        let request = BinanceAPI.GetProductRequest()
        APIKit.send(request) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .success(let product):
                Actor.dispatchResource(path: self.path, resource: filterData(product), arguments: nil)
            case .failure(_):
                Actor.actionFailed(self.path, reason: .failed)
            }
            
            Actor.actionCompleted(self.path)
            let executionTime = CFAbsoluteTimeGetCurrent() - start
            print("request cost \(executionTime) s")
        }
    }
}

private func filterData(_ product: Product) -> [[ProductData]] {
    var result = [[ProductData]]()
    
    var BNB = [ProductData]()
    var BTC = [ProductData]()
    var ETH = [ProductData]()
    var USDT = [ProductData]()
    
    for data in product.data {
        if data.quoteAsset.uppercased() == "BNB" {
            BNB.append(data)
        } else if data.quoteAsset.uppercased() == "BTC" {
            BTC.append(data)
        } else if data.quoteAsset.uppercased() == "ETH" {
            ETH.append(data)
        } else if data.quoteAsset.uppercased() == "USDT" {
            USDT.append(data)
        }
    }
    
    result.append(BNB)
    result.append(BTC)
    result.append(ETH)
    result.append(USDT)
    
    return result
}
