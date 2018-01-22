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
        
        let defaults = UserDefaults.standard
        
        let coinList = MainSearchRouter.setupModule()
        
        let navigationCoinList = UINavigationController()
        navigationCoinList.navigationBar.isHidden = true
        navigationCoinList.viewControllers = [coinList]
        let navigationCoinListTabBarItem = UITabBarItem(title: "Coins List", image: UIImage(named: "CoinsTabBar-29x29-1"), selectedImage: UIImage(named: "CoinsTabBar-29x29-1"))
        navigationCoinList.tabBarItem = navigationCoinListTabBarItem
        
//        let orders =  OrdersRouter.setupModule()
//        let navigationOrders = UINavigationController()
//        navigationOrders.viewControllers = [orders]
//        let navigationOrdersTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "icCart"), selectedImage: UIImage(named: "icCartActive"))
//        navigationOrders.tabBarItem = navigationOrdersTabBarItem


        
        return [navigationCoinList]
    }
    
}

