//
//  NewsListPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation

class NewsListPresenter {

    // MARK: Properties

    weak var view: NewsListView?
    var router: NewsListWireframe?
    var interactor: NewsListUseCase?
}

extension NewsListPresenter: NewsListPresentation {
    // TODO: implement presentation methods
}

extension NewsListPresenter: NewsListInteractorOutput {
    // TODO: implement interactor output methods
}
