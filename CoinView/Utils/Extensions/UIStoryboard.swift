//
//  UIStoryboard.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 04/04/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>() -> T where T: ReusableView {
        return instantiateViewController(withIdentifier: T.reuseIdentifier) as! T
    }

}
