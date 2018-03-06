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

    func saveFavoriteCoins(_ coins: [CoinAttributes]){
        DispatchQueue.global().async(execute: {
            let realm = try! Realm()
            let oldFavoriteCoins = realm.objects(CoinAttributes.self)
            while !oldFavoriteCoins.isEmpty {
                try! realm.write {
                    realm.delete(oldFavoriteCoins)
                }
            }
            try! realm.write {
                realm.add(coins, update:true)
            }
        })
    }

    
    func getFavoriteCoins() -> [CoinAttributes] {
        let realm = try! Realm()
        let oldFavoriteCoins = realm.objects(CoinAttributes.self)

//        let sortProperties = [SortDescriptor(keyPath: "marketName", ascending: true)]
//        oldFavoriteCoins = oldFavoriteCoins.sorted(by: sortProperties)

        return Array(oldFavoriteCoins)
    }
    
    
    

}


