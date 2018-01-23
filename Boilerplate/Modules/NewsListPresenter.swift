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
    func fetchNews() {
        view?.showLoading()
        interactor?.fetchNews()
    }
    
    
    
}

extension NewsListPresenter: NewsListInteractorOutput {
    func whenNewsFetched(news: CryptoNews) {
        view?.hideLoading()
        if let articles = news.articles {
            if articles.count > 0 {
                view?.updateNews(news: news.articles!)
            }else{
                view?.showMessage("There arent available new's.", withTitle: "Ops!")
            }
        }else{
            view?.showMessage("There aren't available new's.", withTitle: "Ops!")
        }
        
    }
    
    
    
}

