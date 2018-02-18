//
//  FavoriteCoinListInteractor.swift
//  CoinView
//
//  Created by Victor Magalhaes on 18/02/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import ReachabilitySwift
import RealmSwift

class FavoriteCoinListInteractor {
    
    // MARK: Properties
    
    weak var output: FavoriteCoinListInteractorOutput?
    var apiDataManager = CoinApiDataManager()
    var localDataManager = ProfileLocalDataManager()
    
}

extension FavoriteCoinListInteractor: FavoriteCoinListUseCase {
    func retrieveCoins() {
        return
    }
    
   
}

