//
//  NewsListRouter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//


import Foundation
import UIKit

class NewsListRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    weak var delegate: NewsListViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> NewsListViewController {
        
        let viewController = UIStoryboard.loadViewController() as NewsListViewController
        
        let presenter = NewsListPresenter()
        let router = NewsListRouter()
        let interactor = NewsListInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}


extension NewsListRouter: NewsListWireframe {
    
    
    // TODO: Implement wireframe methods
}
