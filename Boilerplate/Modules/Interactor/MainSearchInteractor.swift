//
//  MainSearchInteractor.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 23/01/17.
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
    
}

extension MainSearchInteractor: MainSearchUseCase {
    func retrieveCoins() {
        self.apiDataManager.fetchCoins(completion: { (coins) in
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
