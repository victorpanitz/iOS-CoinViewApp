//
//  NewsListViewController.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class NewsListViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: NewsListPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NewsListViewController: NewsListView {
    // TODO: implement view output methods
}
