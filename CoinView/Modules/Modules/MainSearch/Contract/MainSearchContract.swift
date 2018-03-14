//
//  MainSearchContract.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation


protocol MainSearchView: BaseView {
    func updateCoinTable(mCoins: [CoinAttributes])
}

protocol MainSearchPresentation: class {
    func doSomething()
    func retrieveCoins()
}

protocol MainSearchUseCase: class {
    func retrieveCoins()
}

protocol MainSearchInteractorOutput: class {
    func onFetchProductsFailure(message: String)
    func onFetchCoins(mCoins: [CoinAttributes], error: String?)
}

protocol MainSearchWireframe: class {
    
}
