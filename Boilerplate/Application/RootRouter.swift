//
//  RootWireframe.swift
//
//  Created by MARCELO GRACIETTI on 07/11/16.
//  Copyright © 2016 Cheesecake Labs. All rights reserved.
//

import UIKit

class RootRouter: NSObject {

    
    
    func presentFirstScreen() {
        presentView()
    }

    private func presentView() {
        guard let window = UIApplication.shared.delegate?.window! else { return }
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
//
//        let defaults = UserDefaults.standard
//        defaults.set([], forKey: "categoriesID")
//        defaults.set(nil, forKey: "orderByLogic")
//        defaults.set([], forKey: "paymentTypes")
//        defaults.set([], forKey: "cardFilters")
//        defaults.set(false, forKey: "onlinePayment")

        let tabBarController = TabBarController()
        tabBarController.viewControllers = TabBarRouter.setNavigation()
        window.rootViewController = tabBarController
    }
    
//
//    func presentFirstScreen(inWindow window: UIWindow) {
//        presentMainSearchScreen()
//    }
//
//    private func presentMainSearchScreen() {
//        let mainSearchViewController = MainSearchRouter.setupModule()
//        presentView(mainSearchViewController)
//    }
//
//    private func presentView(_ viewController: UIViewController) {
//        guard let window = UIApplication.shared.delegate?.window! else { return }
//        window.backgroundColor = UIColor.white
//        window.makeKeyAndVisible()
//        window.rootViewController = viewController
//    }
//}


}
