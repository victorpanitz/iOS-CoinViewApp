//
//  MainSearchContract.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation


protocol MainSearchView: BaseView {
    func updateCoinTable(mCoins: [CoinAttributes])
}

protocol MainSearchPresentation: class {
    func doSomething()
    func retrieveCoins()
    func showCoinDetail(_ coinAttributes: CoinAttributes)
}

protocol MainSearchUseCase: class {
    func retrieveCoins()
}

protocol MainSearchInteractorOutput: class {
    func showMessage(message: String, title: String)
    func onFetchProductsFailure(message: String)
    func onFetchCoins(mCoins: [CoinAttributes], error: String?)
}

protocol MainSearchWireframe: class {
    func showCoinDetail(_ coinAttributes: CoinAttributes)
}
