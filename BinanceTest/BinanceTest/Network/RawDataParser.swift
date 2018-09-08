//
//  RawDataParser.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/8.
//  Copyright © 2018 hanguang. All rights reserved.
//

import Foundation
import POPAPIKit

class RawDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        guard data.count > 0 else {
            return Data()
        }
        return data
    }
}
