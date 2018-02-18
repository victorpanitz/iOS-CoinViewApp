//
//  FavoriteCoinListContracts.swift
//  CoinView
//
//  Created by Victor Magalhaes on 18/02/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation


protocol FavoriteCoinListView: BaseView {
    func updateCoinTable(mCoins: [CoinAttributes])
}

protocol FavoriteCoinListPresentation: class {
    func retrieveCoinsFromRealm()
    func showCoinDetail(_ coinAttributes: CoinAttributes)
}

protocol FavoriteCoinListUseCase: class {
    func retrieveCoins()
}

protocol FavoriteCoinListInteractorOutput: class {
}

protocol FavoriteCoinListWireframe: class {
}
