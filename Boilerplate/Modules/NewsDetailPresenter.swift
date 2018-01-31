//
//  ViewsDetailPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 23/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation

class NewsDetailPresenter {
    
    // MARK: Properties
    
    weak var view: NewsDetailView?
    var router: NewsDetailWireframe?
    var interactor: NewsDetailUseCase?
    
}

extension NewsDetailPresenter: NewsDetailPresentation {
    func dismissNewsDetailView() {
        router?.dismissNewsDetailView()
    }
    
    func setUrl(url: String) {
        view?.setUrl(url: url)
    }
    
}

extension NewsDetailPresenter: NewsDetailInteractorOutput {

}
