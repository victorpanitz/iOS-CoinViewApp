//
//  CoinDetailViewController.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 14/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import UIKit
import Nuke

class CoinDetailViewController: BaseViewController, StoryboardLoadable, UITableViewDelegate, UITableViewDataSource {
    
    
    var manager = Nuke.Manager.shared
    var mCoin : CoinAttributes?
    
    // MARK: Properties
    
    var presenter: CoinDetailPresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mCoinImageView: UIImageView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        
        if mCoin != nil {
            updateView(coin: mCoin!)
        }
        
        setupView()
        hideKeyboardWhenTappedAround()
        //presenter?.retrieveCoins(marketName: )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotifications(with: scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardNotification()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! coinDetailCell
        return cell
    }
    
    
    @IBAction func dismissView(_ sender: Any) {
        
    }
    
    @IBAction func refreshCoins(_ sender: Any) {
        //        presenter?.retrieveCoins()
    }
    
    
    private func setupView() {
        // TODO: Setup view here
        //self.view.backgroundColor = UIColor.black
    }
    
    
    func moveToNextField(_ view: UIView, nextFieldTag: Int) {
        let nextResponder = view.superview?.viewWithTag(nextFieldTag) as UIResponder!
        if (nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
        }
    }
    
}

extension  CoinDetailViewController: CoinDetailView {
    func updateIndicator(state: Bool) {
            self.progressIndicator.isHidden = state
        if state {
            self.progressIndicator.startAnimating()
        }else{
            self.progressIndicator.stopAnimating()
        }
    }
    
    func updateCoinTable(mCoins: CoinAttributes) {
        
    }
    
    func updateView(coin: CoinAttributes) {
        self.mCoin = coin
        if(coin.logoUrl != nil){
            let url = URL(string: coin.logoUrl!)
            if( url != nil){
                    if let mImage = self.mCoinImageView{
                        self.manager.loadImage(with: url!, into: mImage)
                    }
            }
        }
        //self.mCoinImageView.backgroundColor = UIColor.blue
    }
    
    
}


