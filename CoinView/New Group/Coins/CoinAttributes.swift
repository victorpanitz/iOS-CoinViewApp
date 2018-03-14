//
//  CoinAttributes.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 06/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import ObjectMapper
import Localize_Swift
import RealmSwift

class CoinAttributes: Object, Mappable {
    
    @objc dynamic var id: String? = nil
    @objc dynamic var marketCurrency: String? = nil
    @objc dynamic var baseCurrency: String? = nil
    @objc dynamic var marketCurrencyLong: String? = nil
    @objc dynamic var baseCurrencyLong: String? = nil
    @objc dynamic var minTradeSize : Double = 0.0
    @objc dynamic var marketName: String? = nil
    @objc dynamic var isActive = 0
    @objc dynamic var created: Date? = nil
    @objc dynamic var notice: String? = nil
    @objc dynamic var isSponsored = 0
    @objc dynamic var logoUrl: String? = nil
    @objc dynamic var high : Double = 0.0
    @objc dynamic var low : Double = 0.0
    @objc dynamic var volume = 0
    @objc dynamic var last : Double = 0.0
    @objc dynamic var baseVolume = 0
    @objc dynamic var timeStamp: Date? = nil
    @objc dynamic var bid : Double = 0.0
    @objc dynamic var ask : Double = 0.0
    @objc dynamic var openBuyOrders = 0
    @objc dynamic var openSellOrders = 0
    @objc dynamic var prevDay : Double = 0.0
    
    
    override static func primaryKey() -> String? {
        return "marketName"
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    // MARK: Mapping variables
    
    func mapping(map: Map) {
        
        // Main Search Data
        
        marketCurrency <- map["MarketCurrency"]
        baseCurrency <- map["BaseCurrency"]
        marketCurrencyLong <- map["MarketCurrencyLong"]
        baseCurrencyLong <- map["BaseCurrencyLong"]
        minTradeSize <- map["MinTradeSize"]
        marketName <- map["MarketName"]
        isActive <- map["IsActive"]
        created <- map["Created"]
        notice <- map["Notice"]
        isSponsored <- map["IsSponsored"]
        logoUrl <- map["LogoUrl"]
        high <- map["High"]
        low <- map["Low"]
        volume <- map["Volume"]
        last <- map["Last"]
        baseVolume <- map["BaseVolume"]
        timeStamp <- map["TimeStamp"]
        bid <- map["Bid"]
        ask <- map["Ask"]
        openBuyOrders <- map["OpenBuyOrders"]
        openSellOrders <- map["OpenSellOrders"]
        prevDay <- map["PrevDay"]
        
        
    }
}
