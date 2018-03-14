//
//  TabBarController.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import UIKit
import Nuke
import RxSwift
import RxCocoa

class TabBarController: UITabBarController, StoryboardLoadable  {
    
    var manager = Nuke.Manager.shared
    
    // MARK: Properties
    
    var presenter: TabBarPresentation?
    @IBOutlet weak var scrollView: UIScrollView!

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.tabBar.tintColor = UIColor.black
        hideKeyboardWhenTappedAround()
        //presenter?.retrieveCoins()
    }
    
    
}


