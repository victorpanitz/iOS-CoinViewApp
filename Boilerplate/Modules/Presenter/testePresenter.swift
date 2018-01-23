//
//  testePresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation

class testePresenter {

    // MARK: Properties

    weak var view: testeView?
    var router: testeWireframe?
    var interactor: testeUseCase?
}

extension testePresenter: testePresentation {
    // TODO: implement presentation methods
}

extension testePresenter: testeInteractorOutput {
    // TODO: implement interactor output methods
}
