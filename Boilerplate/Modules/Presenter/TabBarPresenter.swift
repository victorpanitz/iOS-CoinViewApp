//
//  TabBarPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation

class TabBarPresenter {

    // MARK: Properties

    weak var view: TabBarView?
    var router: TabBarWireframe?
    var interactor: TabBarUseCase?
}

extension TabBarPresenter: TabBarPresentation {
    // TODO: implement presentation methods
}

extension TabBarPresenter: TabBarInteractorOutput {
    // TODO: implement interactor output methods
}
