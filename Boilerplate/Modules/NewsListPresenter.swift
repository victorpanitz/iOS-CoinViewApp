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
    func goToNewsDetail(url: String) {
        router?.goToNewsDetail(url: url)
    }
    
    func setRealtimeObserver() {
        interactor?.setRealtimeObserver()
    }
    
    func fetchNews() {
        view?.showLoading()
        interactor?.fetchNews()
    }
    
    

}

extension NewsListPresenter: NewsListInteractorOutput {
    func showMessage(message: String, title: String) {
        view?.hideLoading()
        view?.showMessage(message, withTitle: title)
    }
    
    func whenArticlesEmpty() {
        view?.hideLoading()
        interactor?.fetchNews()
    }
    
    func hideLoading() {
        view?.hideLoading()
    }
    
    
    func whenObserverReturns(articles: [String : AnyHashable]) {
        var articlesHolder: [Articles] = []
        if let mTimestamp = articles["timestamp"] as? Double{
            if ((Date().timeIntervalSince1970 - mTimestamp) > 600){
                view?.self.hideLoading()
                interactor?.fetchNews()
                return
            }
        }
        for pos in 0...articles.count {
            if let article = articles["article\(pos)"] as? [String : AnyHashable]{
                var mArticle = Articles()
                print("\(article)")
                mArticle.author = article["author"] as! String
                mArticle.description = article["description"] as! String
                mArticle.title = article["title"] as! String
                mArticle.urlToImage = article["urlToImage"] as! String
                mArticle.url = article["url"] as! String
                mArticle.publishedAt = article["publishedAt"] as! String
                if let mSource = article["url"] as? [String : AnyHashable]{
                    mArticle.source = Source()
                    mArticle.source?.id = mSource["id"] as! String
                    mArticle.source?.name = mSource["name"] as! String
                }
                articlesHolder.append(mArticle)
            }
        }
        if articlesHolder.count > 0 {
            view?.updateNews(news: articlesHolder, isFromObserver: true)
        }
    }
    
    func whenNewsFetched(news: CryptoNews) {
        view?.hideLoading()
        if let articles = news.articles {
            if articles.count > 0 {
                view?.updateNews(news: news.articles!, isFromObserver: false)
            }else{
                view?.showMessage("There arent available new's.", withTitle: "Ops!")
            }
        }else{
            view?.showMessage("There aren't available new's.", withTitle: "Ops!")
        }
    }
    
    
    
    
    
}

