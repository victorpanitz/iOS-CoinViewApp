//
//  NewsDetailRouter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 23/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class NewsDetailRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    weak var delegate: NewsDetailViewController?
    
    // MARK: Static methods
    
    static func setupModule(url: String) -> NewsDetailViewController {
        
        let viewController = UIStoryboard.loadViewController() as NewsDetailViewController
        
        let presenter = NewsDetailPresenter()
        let router = NewsDetailRouter()
        let interactor = NewsDetailInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        presenter.setUrl(url: url)
        return viewController
    }
}


extension NewsDetailRouter: NewsDetailWireframe {
    func dismissNewsDetailView() {
        view?.dismiss(animated: true, completion: nil)
    }
    
    
    
}
