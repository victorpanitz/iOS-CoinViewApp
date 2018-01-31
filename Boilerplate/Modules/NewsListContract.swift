//
//  NewsListContract.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation


protocol NewsListView: BaseView {
    func updateNews(news: [Articles], isFromObserver: Bool)
}

protocol NewsListPresentation: class {
    func fetchNews()
    func setRealtimeObserver()
    func goToNewsDetail(url: String)
}

protocol NewsListUseCase: class {
    func fetchNews()
    func setRealtimeObserver()
}

protocol NewsListInteractorOutput: class {
    func hideLoading()
    func whenNewsFetched(news: CryptoNews)
    func whenObserverReturns(articles: [String : AnyHashable])
    func whenArticlesEmpty()    
    func showMessage(message: String, title: String)
}

protocol NewsListWireframe: class {
    func goToNewsDetail(url: String)
}

