//
//  CoinInfoRouter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 18/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class CoinInfoRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> CoinInfoViewController {
        let viewController = UIStoryboard.loadViewController() as CoinInfoViewController
        let presenter = CoinInfoPresenter()
        let router = CoinInfoRouter()
        let interactor = CoinInfoInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension CoinInfoRouter: CoinInfoWireframe {
    // TODO: Implement wireframe methods
}
