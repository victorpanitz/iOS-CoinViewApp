//
//  CoinsLocalDataManager.swift
//  CoinView
//
//  Created by Victor Magalhaes on 18/02/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class CoinsLocalDataManager: NSObject {
    let realm = try! Realm()

    
    func saveFavoriteCoins(_ coins: CoinAttributes){
        
        if !realm.isInWriteTransaction{
            realmWrite(coins)
        }else{
            realm.cancelWrite()
            realmWrite(coins)
            
        }
    }
    
    private func realmWrite(_ coins: CoinAttributes){
        try! realm.write {
            if var mCoin: CoinAttributes = realm.object(ofType: CoinAttributes.self, forPrimaryKey: coins.marketName) {
                mCoin = coins
            }else{
                realm.add(coins, update: true)
            }
        }
        
    }
    
    
    
    func getFavoriteCoins() -> [CoinAttributes] {
        let realm = try! Realm()
        return realm.objects(CoinAttributes.self).toArray() as! [CoinAttributes]
    }
    
    func deleteFavoriteCoin(_ coin: CoinAttributes) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(coin)
        }
        
    }
    
    
    
    
    
    
}


