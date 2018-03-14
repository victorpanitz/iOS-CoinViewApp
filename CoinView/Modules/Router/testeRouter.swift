//
//  testeRouter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class testeRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> testeViewController {
        let viewController = UIStoryboard.loadViewController() as testeViewController
        let presenter = testePresenter()
        let router = testeRouter()
        let interactor = testeInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension testeRouter: testeWireframe {
    // TODO: Implement wireframe methods
}
