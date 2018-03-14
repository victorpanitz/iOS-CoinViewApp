//
//  CoinRealmEntity.swift
//  CoinView
//
//  Created by Victor Magalhaes on 11/03/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import Localize_Swift
import RealmSwift

class CoinRealmEntity: Object {
    
    @objc dynamic var id : String? = nil
    @objc dynamic var marketCurrency: String? = nil
    @objc dynamic var baseCurrency: String? = nil
    @objc dynamic var marketCurrencyLong: String? = nil
    @objc dynamic var baseCurrencyLong: String? = nil
    @objc dynamic var minTradeSize : Double = 0.0
    @objc dynamic var marketName: String? = nil
    @objc dynamic var isActive = 0
    @objc dynamic var isSponsored = 0
    @objc dynamic var logoUrl: String? = nil
   
    
    // MARK: Init methods
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func getRealmCoin(from: CoinAttributes) -> CoinRealmEntity {
        
        self.id = String(round(NSDate().timeIntervalSince1970))
        self.marketCurrency = from.marketCurrency
        self.baseCurrency = from.baseCurrency
        self.marketCurrencyLong = from.marketCurrencyLong
        self.baseCurrencyLong = from.baseCurrencyLong
        self.minTradeSize = from.minTradeSize
        self.marketName = from.marketName
        self.isActive = from.isActive
        self.isSponsored = from.isSponsored
        self.logoUrl = from.logoUrl
        
        return self
    }
    
    
}

