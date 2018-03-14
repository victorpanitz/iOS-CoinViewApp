//
//  NewsListInteractor.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ReachabilitySwift
import RealmSwift
import FirebaseDatabase
import Firebase

class NewsListInteractor {
    
    // MARK: Properties
    let apiDataManager = NewsApiDataManager()
    weak var output: NewsListInteractorOutput?
    var localDataManager = ProfileLocalDataManager()
    var ref: DatabaseReference!

    
}

extension NewsListInteractor: NewsListUseCase {
    
    func setRealtimeObserver() {
        FirebaseApp.configure()
        self.ref =  Database.database().reference().root
        ref.observe(DataEventType.value, with: { (snapshot) in
            if let articles = snapshot.value as? [String : AnyHashable]{
                self.output?.whenObserverReturns(articles: articles)
            }else{
                self.output?.whenArticlesEmpty()
            }
            self.output?.hideLoading()
        }) { (error) in
            self.output?.showMessage(message: error.localizedDescription, title: "Ops!")
            self.output?.hideLoading()
        }
    }
    
    func fetchNews() {
        if Connectivity.isConnectedToInternet() {
            self.apiDataManager.fetchRecentNews(success: {(crypto) in
                if let news = crypto{
                    print("@@@@@@@")
                    self.output?.whenNewsFetched(news: news)
                }else{
                    self.output?.showMessage(message: "Verify your connection.", title: "Ops!")
                }
            }, failure: { (error) in
                self.output?.showMessage(message: error!, title: "Ops!")
            })
        } else {
            self.output?.showMessage(message: "Verify your connection.", title: "Ops!")
        }
       
    }
    
}

