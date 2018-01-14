//
//  Product.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 04/04/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import Localize_Swift

class Product: Object, Mappable {

     var id = 0
     var code = 0
     var name: String?
    
    // MARK: Init methods
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: Mapping variables
    
    func mapping(map: Map) {
        
        // Main Search Data
        
        id <- map["id"]
        code <- map["code"]
        name <- map["name"]
    }
}
