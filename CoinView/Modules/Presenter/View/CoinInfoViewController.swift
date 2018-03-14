//
//  CoinInfoViewController.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 18/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class CoinInfoViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: CoinInfoPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CoinInfoViewController: CoinInfoView {
    // TODO: implement view output methods
}
