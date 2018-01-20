
//
//  mCollectionViewCell.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 08/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit

class coinDetailCell : UITableViewCell{
    
    var coinAttributes: CoinAttributes?
    
    @IBOutlet weak var coinTitleLabel: UILabel!
    @IBOutlet weak var coinReferenceLabel: UILabel!
    @IBOutlet weak var coinLogoImageView: UIImageView!
    
}
