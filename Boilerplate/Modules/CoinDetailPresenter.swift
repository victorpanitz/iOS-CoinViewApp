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
    func dismissView() {
        router?.dismissView()
    }
    
    func updateView(coin: CoinAttributes) {
        view?.updateView(coin: coin)
    }
    
    func retrieveCoins(marketName: String) {
        view?.showLoading()
        interactor?.retrieveCoins(marketName: marketName)
    }
    
    
    func doSomething() {
        view?.showMessage("I'm doing something!!", withTitle: "Hey")
    }
    
    
    
    //TODO: Implement other methods from presenter->view here
    
}

extension CoinDetailPresenter: CoinDetailInteractorOutput {
    func onFetchCoins(mCoins: [CoinAttributes], error: String?) {
        view?.hideLoading()
        let parsedCoin = mCoins[0]
        view?.updateCoinTable(mCoins: parsedCoin)

    }
    
    
    func onFetchProductsFailure(message: String) {
        view?.showError(message)
    }
    
    
    
}

