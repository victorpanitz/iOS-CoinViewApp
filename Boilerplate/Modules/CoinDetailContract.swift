//
//  CoinDetailContract.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 14/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation

protocol CoinDetailView: BaseView {
    func updateCoinTable(mCoins: CoinAttributes)
    func updateView(coin: CoinAttributes)
    func updateIndicator(state: Bool)
}

protocol CoinDetailPresentation: class {
    func doSomething()
    func updateView(coin: CoinAttributes)
    func retrieveCoins(marketName: String)
    
}

protocol CoinDetailUseCase: class {
    func retrieveCoins(marketName: String)
}

protocol CoinDetailInteractorOutput: class {
    func onFetchProductsFailure(message: String)
    func onFetchCoins(mCoins: [CoinAttributes], error: String?)
}

protocol CoinDetailWireframe: class {
    
}

