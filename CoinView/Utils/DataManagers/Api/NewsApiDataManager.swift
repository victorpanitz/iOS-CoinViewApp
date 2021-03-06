//
//  NewsApiDataManager.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation


import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class NewsApiDataManager: NSObject {
    
    //TODO: Implement API requests here
    //TODO: Requestes related to User, Profile, CompanyProfile and similar entities can be implemented here
    
    var alamoFireManager = Alamofire.SessionManager.default
    
    
    //    let manager : SessionManager = {
    //        let config = URLSessionConfiguration.default
    //        config.timeoutIntervalForRequest = 5
    //        config.timeoutIntervalForResource = 5
    //        let mgr = Alamofire.SessionManager(configuration: config)
    //
    //        return mgr
    //    }()
    
    
    func fetchTopNews(success: @escaping ((_ cryptoNews: CryptoNews?) -> ()), failure: ((_ error: String?) -> Void)?) {
        //guard let header = SessionHelper.shared.authorizationHeader else { return }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 4 // seconds
        configuration.timeoutIntervalForResource = 4
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        let url = Constants.URL.topCryptoNews
        self.alamoFireManager
            .request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseObject(completionHandler: { (response: DataResponse<CryptoNews>) in
                self.responseAPI(url, response.response?.statusCode, response.data!, success: {
                    success(response.result.value)
                }, failure: { (error) in
                    if let err = error as? URLError, err.code  == URLError.Code.notConnectedToInternet
                    {
                        print("SEM INTERNET")                    }
                    else
                    {
                        // Other errors
                        failure!(error)
                        print("SEM INTERNET")
                        
                    }
                })
            })
    }
    
    func fetchRecentNews(success: @escaping ((_ cryptoNews: CryptoNews?) -> ()), failure: ((_ error: String?) -> Void)?) {
        //guard let header = SessionHelper.shared.authorizationHeader else { return }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 4 // seconds
        configuration.timeoutIntervalForResource = 4
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        let url = Constants.URL.recentCryptoNews
        self.alamoFireManager
            .request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseObject(completionHandler: { (response: DataResponse<CryptoNews>) in
                self.responseAPI(url, response.response?.statusCode, response.data!, success: {
                    success(response.result.value)
                }, failure: { (error) in
                    if let err = error as? URLError, err.code == .notConnectedToInternet {
                        // no internet connection
                        print(error)
                        print("CAPTURADO1")
                    } else {
                        // other failures
                        print("CAPTURADO2")

                    }
                    failure!(error)
                })
            })
    }
    
    
    
    
    ////////////////////  Global Fuctions ////////////////////////////
    
    func responseAPI(_ url: String, _ statusCode: Int?, _ data: Data, success: (() -> Void)?, failure:  ((_ error: String) -> Void)?){
        var logger = "URL: \(url) - code: \(statusCode ?? 0) "
        if statusCode != 200 {  logger += self.loggerError(data:data)}
        guard let statusCode = statusCode else {
            print("SEM INTERNET")
            failure!(self.showError(data: data))
            return
        }
        switch statusCode {
        case 200..<400:
            success!()
            return
        default:
            print("SEM INTERNET")
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
