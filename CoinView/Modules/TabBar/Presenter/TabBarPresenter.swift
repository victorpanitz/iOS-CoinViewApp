//
//  TabBarPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation


class TabBarPresenter {
    
    // MARK: Properties
    
    weak var view: TabBarView?
    var router: TabBarWireframe?
    var interactor: TabBarUseCase?
    
}

extension TabBarPresenter: TabBarPresentation {
   
    
    //TODO: Implement other methods from presenter->view here
    
}

extension TabBarPresenter: TabBarInteractorOutput {
    
    
}

