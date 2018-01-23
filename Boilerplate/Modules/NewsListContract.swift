//
//  NewsListContract.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation


protocol NewsListView: BaseView {
    func updateNews(news: [Articles])
}

protocol NewsListPresentation: class {
    func fetchNews()
}

protocol NewsListUseCase: class {
    func fetchNews()
}

protocol NewsListInteractorOutput: class {
    func whenNewsFetched(news: CryptoNews)
}

protocol NewsListWireframe: class {
    
}

