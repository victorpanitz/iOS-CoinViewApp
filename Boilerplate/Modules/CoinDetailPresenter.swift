//
//  CoinDetailPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 14/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation


class CoinDetailPresenter {
    
    // MARK: Properties
    
    weak var view: CoinDetailView?
    var router: CoinDetailWireframe?
    var interactor: CoinDetailUseCase?
    
}

extension CoinDetailPresenter: CoinDetailPresentation {
    func updateView(coin: CoinAttributes) {
        view?.updateView(coin: coin)
    }
    
    func retrieveCoins(marketName: String) {
        view?.updateIndicator(state: true)
        // interactor?.retrieveCoins(marketName: <#String#>)
    }
    
    
    
    func doSomething() {
        view?.showMessage("I'm doing something!!", withTitle: "Hey")
    }
    
    
    
    //TODO: Implement other methods from presenter->view here
    
}

extension CoinDetailPresenter: CoinDetailInteractorOutput {
    func onFetchCoins(mCoins: [CoinAttributes], error: String?) {
        view?.updateIndicator(state: false)
        //view?.updateCoinTable(mCoins: mCoins)
    }
    
    
    func onFetchProductsFailure(message: String) {
        view?.updateIndicator(state: false)
        view?.showError(message)
    }
    
    
    
}

