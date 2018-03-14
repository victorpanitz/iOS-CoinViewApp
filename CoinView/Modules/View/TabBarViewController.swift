//
//  TabBarViewController.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: TabBarPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TabBarViewController: TabBarView {
    // TODO: implement view output methods
}
