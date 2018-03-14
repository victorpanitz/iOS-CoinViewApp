//
//  NewsDetailViewController.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 23/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class NewsDetailViewController: BaseViewController, StoryboardLoadable, UIWebViewDelegate {
    
    // MARK: Properties
    var mUrl: String?
    var presenter: NewsDetailPresentation?
    
    @IBOutlet var mWebView: UIWebView!
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mWebView.delegate = self
        
        if let url = mUrl {
            setWebView(url: url)
        }
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardNotification()
    }
    
    private func setWebView(url: String){
    
        if let getUrl = URL(string: url) {
            let request  = URLRequest(url: getUrl)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if error == nil {
                    self.mWebView.loadRequest(request)
                    
                }else{
                    self.showMessage("An error ocurred loading this page, a reload is welcome.", withTitle: "Ops!")
                }
            }
            task.resume()
        }
    }
    @IBAction func dismissNewsDetailView(_ sender: Any) {
        presenter?.dismissNewsDetailView()
    }
    
 }



extension  NewsDetailViewController: NewsDetailView {
    func setUrl(url: String) {
        self.mUrl = url
    }
    
}
