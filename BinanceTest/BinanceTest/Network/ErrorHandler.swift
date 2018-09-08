//
//  ErrorHandler.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/9.
//  Copyright © 2018 hanguang. All rights reserved.
//

import Foundation
import POPAPIKit

extension ErrorHandleable {
    func handle(error: SessionTaskError) {
        switch error {
        case .connectionError(let err):
            // Handle connection such as show an error alert
            print(err)
        case .requestError(let err):
            // Handle request error
            print(err)
        case .responseError(let err):
            // Handle response error such as decoding error
            print(err)
        }
    }
}

extension Interceptable {
    /// Before sending a request to Session
    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        // Maybe redirect the request to a test server
        return urlRequest
    }
    
    /// After received response from server
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard 200..<300 ~= urlResponse.statusCode else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        
        // Maybe handle something else here
        
        return object
    }
}
