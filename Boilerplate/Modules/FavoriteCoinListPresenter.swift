//
//  FavoriteCoinListPresenter.swift
//  CoinView
//
//  Created by Victor Magalhaes on 18/02/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation

class FavoriteCoinListPresenter {
    
    // MARK: Properties
    
    weak var view: FavoriteCoinListView?
    var router: FavoriteCoinListWireframe?
    var interactor: FavoriteCoinListUseCase?
    
}

extension FavoriteCoinListPresenter: FavoriteCoinListPresentation {
    func removeFavoriteCoin(coin: CoinAttributes) {
        interactor?.removeFavoriteCoin(coin: coin)
    }
    
    func retrieveCoins() {
        interactor?.retrieveCoins()
    }
    
    func showCoinDetail(_ coinAttributes: CoinAttributes) {
        router?.showCoinDetail(coinAttributes)
    }
    
}

extension FavoriteCoinListPresenter: FavoriteCoinListInteractorOutput {
    func onCoinRemoved() {
        interactor?.retrieveCoins()
    }
    
    func onCoinsRetrieved(coins: [CoinAttributes]) {
        view?.updateCoinTable(coins: coins)
    }
    
    
    
}
