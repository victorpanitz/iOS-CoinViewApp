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
        self.apiDataManager.fetchCoinDetail(marketName ,success: { (coins) in
            var mCoins = [CoinAttributes]()
            coins?.result.forEach({mAttributes in
                mCoins.append(mAttributes)
            })
            if (mCoins.count > 0){
                self.output?.onFetchCoins(mCoins: mCoins, error: nil)
            }
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


