//
//  TabBarViewControllerPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation

class TabBarViewControllerPresenter {

    // MARK: Properties

    weak var view: TabBarViewControllerView?
    var router: TabBarViewControllerWireframe?
    var interactor: TabBarViewControllerUseCase?
}

extension TabBarViewControllerPresenter: TabBarViewControllerPresentation {
    // TODO: implement presentation methods
}

extension TabBarViewControllerPresenter: TabBarViewControllerInteractorOutput {
    // TODO: implement interactor output methods
}
