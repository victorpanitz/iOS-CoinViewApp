//
//  NewsDetailContracts.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 23/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
protocol NewsDetailView: BaseView {
    func setUrl(url: String)
}

protocol NewsDetailPresentation: class {
    func setUrl(url: String)
    func dismissNewsDetailView()
}

protocol NewsDetailUseCase: class {
    
}

protocol NewsDetailInteractorOutput: class {
   
}

protocol NewsDetailWireframe: class {
    func dismissNewsDetailView()
}
