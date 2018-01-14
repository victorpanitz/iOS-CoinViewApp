//
//  CoinApiDataManager.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 06/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class CoinApiDataManager: NSObject {
    
    //TODO: Implement API requests here
    //TODO: Requestes related to User, Profile, CompanyProfile and similar entities can be implemented here
    
    func fetchCoins(completion: @escaping ((_ coins: Coin?) -> ())) {
       // guard let header = SessionHelper.shared.authorizationHeader else { return }
        let url = Constants.URL.baseURL
        Alamofire
            .request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseObject(completionHandler: { (response: DataResponse<Coin>) in
                completion(response.result.value)
                
            })
    }
    
}
