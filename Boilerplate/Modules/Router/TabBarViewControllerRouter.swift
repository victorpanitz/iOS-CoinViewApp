//
//  TabBarViewControllerRouter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewControllerRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> TabBarViewControllerViewController {
        let viewController = UIStoryboard.loadViewController() as TabBarViewControllerViewController
        let presenter = TabBarViewControllerPresenter()
        let router = TabBarViewControllerRouter()
        let interactor = TabBarViewControllerInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension TabBarViewControllerRouter: TabBarViewControllerWireframe {
    // TODO: Implement wireframe methods
}
