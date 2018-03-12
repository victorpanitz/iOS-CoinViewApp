//
//  MainSearchInteractor.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//


import Foundation
import Alamofire
import AlamofireObjectMapper
import ReachabilitySwift
import RealmSwift

class MainSearchInteractor {
    
    // MARK: Properties
    
    weak var output: MainSearchInteractorOutput?
    var apiDataManager = CoinApiDataManager()
    var localDataManager = ProfileLocalDataManager()
    var coinLocalDataManager = CoinsLocalDataManager()
    
}

extension MainSearchInteractor: MainSearchUseCase {
    func saveCoin(_ coin: CoinAttributes) {

//        let mCoins2: [CoinAttributes] = self.coinLocalDataManager.getFavoriteCoins()
        print(" ANTES ANTES \n")
        
        self.coinLocalDataManager.saveFavoriteCoins(coin)

        
        let mCoins: [CoinAttributes] = self.coinLocalDataManager.getFavoriteCoins()
        print(" DEPOIS DEPOIS \(mCoins))\n")
        
//        output?.onCoinSaved(coins: self.coinLocalDataManager.getFavoriteCoins())
        

        
    }
    
    func retrieveCoins() {
        self.apiDataManager.fetchCoins(
            success: { (coins) in
                var mCoins = [CoinAttributes]()
                for i in (coins?.result)! {
                    mCoins.append(i)
                }
                (self.output?.onFetchCoins(mCoins: mCoins, error: nil))!
                
        }, failure: { (error) in
            self.output?.showMessage(message: error!, title: "Ops!")
        })
    }
    
    func searchProducts(with searchTerm: String, onPage page: Int) {
        
        if Reachability()?.currentReachabilityStatus == .notReachable {
            output?.onFetchProductsFailure(message: "NO_INTERNET".localized())
            return
        }
        
    }
    
    
}
