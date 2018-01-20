//
//  CoinInfoPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 18/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation

class CoinInfoPresenter {

    // MARK: Properties

    weak var view: CoinInfoView?
    var router: CoinInfoWireframe?
    var interactor: CoinInfoUseCase?
}

extension CoinInfoPresenter: CoinInfoPresentation {
    // TODO: implement presentation methods
}

extension CoinInfoPresenter: CoinInfoInteractorOutput {
    // TODO: implement interactor output methods
}
