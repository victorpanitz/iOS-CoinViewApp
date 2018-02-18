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

    func fetchCoins(success: @escaping ((_ coins: Coin?) -> ()), failure: ((_ error: String?) -> Void)?) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        let alamoFireManager = Alamofire.SessionManager(configuration: configuration)

        
        let url = Constants.URL.baseURL + Constants.URL.getMarkets
        Alamofire
            .request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseObject(completionHandler: { (response: DataResponse<Coin>) in
                self.responseAPI(url, response.response?.statusCode, response.data!, success: {
                    success(response.result.value)
                }, failure: { (error) in
                    failure!(error)
                })
            })
    }
    
    
    func fetchCoinDetail(_ coin: String, success: @escaping ((_ coins: Coin?) -> ()), failure: ((_ error: String?) -> Void)?) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        let alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        
        let url = Constants.URL.baseURL + Constants.URL.coindetail + coin
        Alamofire
            .request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseObject(completionHandler: { (response: DataResponse<Coin>) in
                self.responseAPI(url, response.response?.statusCode, response.data!, success: {
                    success(response.result.value)
                }, failure: { (error) in
                    failure!(error)
                })
            })
    }
    
    
    ////////////////////  Global Fuctions ////////////////////////////
    
    func responseAPI(_ url: String, _ statusCode: Int?, _ data: Data, success: (() -> Void)?, failure:  ((_ error: String) -> Void)?){
        var logger = "URL: \(url) - code: \(statusCode ?? 0) "
        if statusCode != 200 {  logger += self.loggerError(data:data)}
        guard let statusCode = statusCode else {
            failure!(self.showError(data: data))
            return
        }
        switch statusCode {
        case 200..<400:
            success!()
            return
        default:
            failure!(self.showError(data: data))
            return
        }
    }
    
    func loggerError(data: Data) -> String{
        let errorString = "Ocorreu um erro ao executar essa ação no servidor."
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
            return "\(json)"
        }
        return errorString
    }
    
    func showError(data: Data) -> String{
        var errorString = "Ocorreu um erro ao executar essa ação no servidor."
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any] {
            if let errors: [[String: Any]] = json["errors"] as? [[String: Any]]{
                errorString = errors[0]["message"]! as! String
            }
        }
        return errorString
    }
    
    
}

