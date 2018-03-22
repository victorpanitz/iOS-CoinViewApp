//
//  FavoriteCoinListContracts.swift
//  CoinView
//
//  Created by Victor Magalhaes on 18/02/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation


protocol FavoriteCoinListView: BaseView {
    func updateCoinTable(coins: [CoinAttributes])
}

protocol FavoriteCoinListPresentation: class {
    func retrieveCoins()
    func removeFavoriteCoin(coin: CoinAttributes)
    func showCoinDetail(_ coinAttributes: CoinAttributes)
}

protocol FavoriteCoinListUseCase: class {
    func removeFavoriteCoin(coin: CoinAttributes)
    func retrieveCoins()
}

protocol FavoriteCoinListInteractorOutput: class {
    func onCoinRemoved()
    func onCoinsRetrieved(coins: [CoinAttributes])
}

protocol FavoriteCoinListWireframe: class {
    func showCoinDetail(_ coinAttributes: CoinAttributes)
}
