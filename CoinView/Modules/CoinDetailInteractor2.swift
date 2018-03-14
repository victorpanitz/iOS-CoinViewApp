//
//  CoinDetailInteractor.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 14/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ReachabilitySwift
import RealmSwift

class CoinDetailInteractor {
    
    // MARK: Properties
    
    weak var output: CoinDetailInteractorOutput?
    var apiDataManager = CoinApiDataManager()
    //var localDataManager = ProfileLocalDataManager()
    
}

extension CoinDetailInteractor: CoinDetailUseCase {
   
    
    func retrieveCoins(marketName: String) {
        self.apiDataManager.fetchCoinDetail(marketName ,completion: { (coins) in
            var mCoins = [CoinAttributes]()
            coins?.result?.forEach({mAttributes in
                mCoins.append(mAttributes)
            })
            if (mCoins.count > 0){
                self.output?.onFetchCoins(mCoins: mCoins, error: nil)
            }
        })
    }
    
    func searchProducts(with searchTerm: String, onPage page: Int) {
        
        if Reachability()?.currentReachabilityStatus == .notReachable {
            output?.onFetchProductsFailure(message: "NO_INTERNET".localized())
            return
        }
        
        //TODO: Code below show how interactor get data from API and then saves it on local DB with separate data managers
        /*
         self.apiDataManager.searchProducts(with: searchTerm, forPage: page) { (products) in
         if let products = products {
         self.localDataManager.updateSearchResultFavorites(products) { (products) in
         self.output?.onFetchProductsSuccess(Array(products), shouldAppend: page != 1)
         }
         } else {
         self.output?.onFetchProductsSuccess(nil, shouldAppend: page != 1)
         }
         }
         */
    }
    
    // TODO: Method below is an example on how interactor gets info from local Data Manager
    /*
     func fetchSearchHistory() {
     self.localDataManager.fetchSearchHistory() { (history) in
     self.output?.onFetchSearchHistorySuccess(history)
     }
     }
     */
    
}

