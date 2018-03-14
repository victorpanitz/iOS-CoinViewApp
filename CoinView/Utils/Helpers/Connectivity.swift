//
//  Connectivity.swift
//  CoinView
//
//  Created by Victor Magalhaes on 13/03/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
