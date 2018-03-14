//
//  ReusableView.swift
//
//  Created by MARCELO GRACIETTI on 08/12/16.
//  Copyright © 2016 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit


protocol ReusableView: class {}

extension ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
