//
//  ViewController.swift
//  BinanceTest
//
//  Created by Hanguang on 2018/9/6.
//  Copyright © 2018 hanguang. All rights reserved.
//

import UIKit
import POPAPIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let start = CFAbsoluteTimeGetCurrent()
        
        let request = BinanceAPI.GetProductRequest()
        APIKit.send(request) { (result) in
            switch result {
            case .success(let product):
//                print(product.data)
                break
            case .failure(let error):
//                print(error)
                break
            }
            
            let executionTime = CFAbsoluteTimeGetCurrent() - start
            print("request cost \(executionTime) s")
        }
    }
}

