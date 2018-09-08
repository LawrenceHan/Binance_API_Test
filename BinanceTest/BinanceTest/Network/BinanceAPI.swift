//
//  BinanceAPI.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/8.
//  Copyright © 2018 hanguang. All rights reserved.
//

import POPAPIKit

protocol BinanceRequest: Request {}

extension BinanceRequest {
    var baseURL: URL {
        return URL(string: "https://www.binance.com")!
    }
    
    var dataParser: DataParser {
        return RawDataParser()
    }
}

extension BinanceRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try JSONDecoder().decode(Product.self, from: object as! Data) as! Self.Response
    }
}

final class BinanceAPI {
    struct GetProductRequest: BinanceRequest {
        typealias Response = Product
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/exchange/public/product"
        }
    }
}
