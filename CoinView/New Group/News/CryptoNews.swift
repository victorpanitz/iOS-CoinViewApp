//
//  CryptoNews.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import ObjectMapper
import Localize_Swift
import RealmSwift

class CryptoNews: Object, Mappable {
    
     var status: String?
     var totalResults: Int = 0
     var articles: [Articles]?
    
    // MARK: Init methods
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: Mapping variables
    
    func mapping(map: Map) {
        
        // Main Search Data
        status <- map["status"]
        totalResults <- map["totalResults"]
        articles <- map["articles"]
        
    }
}
