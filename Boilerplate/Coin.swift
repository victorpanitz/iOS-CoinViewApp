//
//  Coin.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 06/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import ObjectMapper
import Localize_Swift

class Coin:  Mappable {
    
     var success = 0
     var message: String?
     var result : [CoinAttributes]?
    
    // MARK: Init methods
    

    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: Mapping variables
    
    func mapping(map: Map) {
        
        // Main Search Data
        success <- map["success"]
        message <- map["message"]
        result <- map["result"]
        
    }
}
