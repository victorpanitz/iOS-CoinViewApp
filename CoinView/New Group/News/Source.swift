//
//  Source.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import ObjectMapper
import Localize_Swift

class Source:  Mappable {
    
    @objc dynamic var id: String?
    @objc dynamic var name: String?
    
    // MARK: Init methods
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: Mapping variables
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
