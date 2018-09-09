//
//  BaseActor.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/9.
//  Copyright © 2018 hanguang. All rights reserved.
//

import ActionStageSwift
import POPAPIKit

class BaseActor: LHWActor {
    override func cancel() {
        if let token = cancelToken as? URLSessionTask {
            token.cancel()
        }
        
        if let token = cancelToken as? SessionTask {
            token.cancel()
        }
        
        for cancelToken in multipleCancelTokens {
            if let token = cancelToken as? URLSessionTask {
                token.cancel()
            }
            
            if let token = cancelToken as? SessionTask {
                token.cancel()
            }
        }
        
        super.cancel()
    }
}
