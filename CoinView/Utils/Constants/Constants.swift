//
//  Constants.swift
//
//  Created by MARCELO GRACIETTI on 08/11/16.
//  Copyright © 2016 Cheesecake Labs. All rights reserved.
//

import UIKit
import Foundation
import Localize_Swift

enum Constants {
    
    enum URL {
        static let baseURL = "https://bittrex.com/api/v1.1/public/"
        static let getMarkets = "getmarkets"
        static let coindetail = "getmarketsummary?market="
        static let signUp = baseURL + ""
        static let login = baseURL + "auth/"
        
        static let topCryptoNews = "https://newsapi.org/v2/top-headlines?sources=crypto-coins-news&apiKey=15d3fdeee18c4ba5a0c73c2c50d822ad"
        
       static let recentCryptoNews = "https://newsapi.org/v2/everything?sources=crypto-coins-news&apiKey=15d3fdeee18c4ba5a0c73c2c50d822ad"
    }
    
    
    enum Storyboard {
        static let mainSearchStoryboard = "MainSearchStoryboard"
    }
    
    enum ViewControllerIdentifier {
        static let mainSearchViewControllerIdentifier = "MainSearchViewControllerID"
    }
    
    enum Label {
        static let padding = CGFloat(10)
        static let edgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    }
    
    enum Font {
        static let SFTextLight = "SanFranciscoText-Light"
        static let SFTextMedium = "SanFranciscoText-Medium"
        static let SFTextRegular = "SanFranciscoText-Regular"
    }

}
