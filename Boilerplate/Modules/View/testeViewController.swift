//
//  testeViewController.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class testeViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: testePresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension testeViewController: testeView {
    // TODO: implement view output methods
}
