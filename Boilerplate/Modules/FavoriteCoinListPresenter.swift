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
    func retrieveCoins() {
        interactor?.retrieveCoins()
    }
    
    func showCoinDetail(_ coinAttributes: CoinAttributes) {
        return
    }
    
   
    
}

extension FavoriteCoinListPresenter: FavoriteCoinListInteractorOutput {
//    func showMessage(message: String, title: String) {
//        view?.hideLoading()
//        view?.showMessage(message, withTitle: title)
//    }
    
}
