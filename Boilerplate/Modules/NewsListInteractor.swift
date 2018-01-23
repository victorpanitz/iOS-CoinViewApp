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

class NewsListInteractor {
    
    // MARK: Properties
    let apiDataManager = NewsApiDataManager()
    weak var output: NewsListInteractorOutput?
    var localDataManager = ProfileLocalDataManager()
    
}

extension NewsListInteractor: NewsListUseCase {
    func fetchNews() {
        self.apiDataManager.fetchRecentNews(success: {(crypto) in
            if let news = crypto{
                print("@@@@@@@")
                self.output?.whenNewsFetched(news: news)
            }else{
                print("@@@@@@@")
            }
        }, failure: { (error) in
            print(error!)
        })
    }
    
}

