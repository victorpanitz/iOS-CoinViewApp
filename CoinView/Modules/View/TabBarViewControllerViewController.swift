//
//  TabBarViewControllerViewController.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewControllerViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: TabBarViewControllerPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TabBarViewControllerViewController: TabBarViewControllerView {
    // TODO: implement view output methods
}
