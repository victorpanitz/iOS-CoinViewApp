//
//  TabBarRouter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class TabBarRouter {
    
    // MARK: Properties
    
    weak var view: UITabBarController?
    weak var delegate: TabBarController?
    
    // MARK: Static methods
    
    static func setupModule() -> TabBarController {
        
        let viewController = UIStoryboard.loadViewController() as TabBarController
        let presenter = TabBarPresenter()
        let router = TabBarRouter()
        let interactor = TabBarInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController as? TabBarView
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return viewController
    }
}


extension TabBarRouter: TabBarWireframe {

    static func setNavigation() -> [UIViewController] {
        
       // let defaults = UserDefaults.standard
        
        let coinList = MainSearchRouter.setupModule()
        let navigationCoinList = UINavigationController()
        navigationCoinList.navigationBar.isHidden = true
        navigationCoinList.viewControllers = [coinList]
        let navigationCoinListTabBarItem = UITabBarItem(title: "Coins List", image: UIImage(named: "CoinsTabBar-29x29-1"), selectedImage: UIImage(named: "CoinsTabBar-29x29-1"))
        navigationCoinList.tabBarItem = navigationCoinListTabBarItem
        
        let newsList = NewsListRouter.setupModule()
        let navigationNewsList = UINavigationController()
        navigationNewsList.navigationBar.isHidden = true
        navigationNewsList.viewControllers = [newsList]
        let navigationNewsListTabBarItem = UITabBarItem(title: "Last News", image: UIImage(named: "News-29x29-1"), selectedImage: UIImage(named: "News-29x29-1"))
        navigationNewsList.tabBarItem = navigationNewsListTabBarItem
        
        let favoriteCoinList = FavoriteCoinListRouter.setupModule()
        let navigationFavoriteCoinList = UINavigationController()
        navigationFavoriteCoinList.navigationBar.isHidden = true
        navigationFavoriteCoinList.viewControllers = [favoriteCoinList]
        let navigationFavoriteCoinListTabBarItem = UITabBarItem(title: "My Coins", image: UIImage(named: "FavoriteCoin-29x29"), selectedImage: UIImage(named: "FavoriteCoin-29x29"))
        navigationFavoriteCoinList.tabBarItem = navigationFavoriteCoinListTabBarItem

        
        return [navigationNewsList,navigationCoinList, navigationFavoriteCoinList]
    }
    
}

