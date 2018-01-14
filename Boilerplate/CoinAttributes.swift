//
//  CoinAttributes.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 06/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import Localize_Swift

class CoinAttributes: Object, Mappable {
    

    @objc dynamic var MarketCurrency: String?
    @objc dynamic var BaseCurrency: String?
    @objc dynamic var MarketCurrencyLong: String?
    @objc dynamic var BaseCurrencyLong: String?
    @objc dynamic var MinTradeSize = 0
    @objc dynamic var MarketName: String?
    @objc dynamic var IsActive = 0
    @objc dynamic var Created: Date?
    @objc dynamic var Notice: String?
    @objc dynamic var IsSponsored = 0
    @objc dynamic var LogoUrl: String?
    
    // MARK: Init methods
    
    override static func primaryKey() -> String? {
        return "MarketCurrencyLong"
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: Mapping variables
    
    func mapping(map: Map) {
        
        // Main Search Data
        
        MarketCurrency <- map["MarketCurrency"]
        BaseCurrency <- map["BaseCurrency"]
        MarketCurrencyLong <- map["MarketCurrencyLong"]
        BaseCurrencyLong <- map["BaseCurrencyLong"]
        MinTradeSize <- map["MinTradeSize"]
        MarketName <- map["MarketName"]
        IsActive <- map["IsActive"]
        Created <- map["Created"]
        Notice <- map["Notice"]
        IsSponsored <- map["IsSponsored"]
        LogoUrl <- map["LogoUrl"]

    }
}
