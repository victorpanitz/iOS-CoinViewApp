//
//  FavoriteCoinListRouter.swift
//  CoinView
//
//  Created by Victor Magalhaes on 18/02/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCoinListRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    weak var delegate: FavoriteCoinListViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> FavoriteCoinListViewController {
        
        let viewController = UIStoryboard.loadViewController() as FavoriteCoinListViewController
        
        let presenter = FavoriteCoinListPresenter()
        let router = FavoriteCoinListRouter()
        let interactor = FavoriteCoinListInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}


extension FavoriteCoinListRouter: FavoriteCoinListWireframe {
    func showCoinDetail(_ coinAttributes: CoinAttributes) {
        view?.present(CoinDetailRouter.setupModule(coinAttributes), animated: true, completion: nil)
    }
    
    // TODO: Implement wireframe methods
}



