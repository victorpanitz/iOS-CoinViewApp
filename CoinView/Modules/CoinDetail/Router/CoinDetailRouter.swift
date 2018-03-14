
//
//  CoinDetailRouter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 14/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class CoinDetailRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule(_ coin: CoinAttributes) -> CoinDetailViewController {
        
        let viewController = UIStoryboard.loadViewController() as CoinDetailViewController
        
        let presenter = CoinDetailPresenter()
        let router = CoinDetailRouter()
        let interactor = CoinDetailInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        presenter.updateView(coin: coin)
        
        return viewController
    }
}


extension CoinDetailRouter: CoinDetailWireframe {
    func dismissView() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    // TODO: Implement wireframe methods
    
}

