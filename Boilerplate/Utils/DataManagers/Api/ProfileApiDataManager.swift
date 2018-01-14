//
//  ProfileApiDataManager.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 04/04/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class ProfileApiDataManager: NSObject {

    //TODO: Implement API requests here
    //TODO: Requestes related to User, Profile, CompanyProfile and similar entities can be implemented here
    
    func fetchProducts(completion: @escaping ((_ products: [Product]?) -> ())) {
        guard let header = SessionHelper.shared.authorizationHeader else { return }
        let url = Constants.URL.baseURL
        Alamofire
            .request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseArray(completionHandler: { (response: DataResponse<[Product]>) in
                completion(response.result.value)
            })
    }

}
