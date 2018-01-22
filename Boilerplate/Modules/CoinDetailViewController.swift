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
    var coinDetails: [(String, String)] = []
    
    
    
    // MARK: Properties
    
    var presenter: CoinDetailPresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet var marketNameLabel: UILabel!
    @IBOutlet var mNavigationBar: UINavigationBar!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mCoinImageView: UIImageView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        setupView()
        
        
        
        if let marketName = mCoin?.marketName {
            presenter?.retrieveCoins(marketName: (mCoin?.marketName!)!)
        }
        
        hideKeyboardWhenTappedAround()
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
        return coinDetails.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.mTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoinDetailCell
        cell.coinDetailTitle.text = coinDetails[indexPath.row].0
        cell.coinDetailDescription.text = coinDetails[indexPath.row].1
        return cell
    }
    
    
    
    @IBAction func dismissView(_ sender: Any) {
        presenter?.dismissView()
    }
    
    @IBAction func refreshCoins(_ sender: Any) {
        //        presenter?.retrieveCoins()
    }
    
    
    private func setupView() {
        if mCoin != nil {
            updateView(coin: mCoin!)
        }
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
   
    
    func updateCoinTable(mCoins: CoinAttributes) {
        
        var last = mCoins.last
        if last < 0.01 {
            last = (last * 10000000000) / 10000000000
        }
        coinDetails.append(("Last", String(last)))
        
        var prevDay = mCoins.prevDay
        if prevDay < 0.01 {
            prevDay = (prevDay * 10000000000) / 10000000000
        }
        coinDetails.append(("Previous Day", String(prevDay)))
        
        var high = mCoins.high
        if high < 0.01 {
            high = (high * 10000000000) / 10000000000
        }
        coinDetails.append(("High", String(high)))
        
        var low = mCoins.low
        if low < 0.01 {
            low = (low * 10000000000) / 10000000000
        }
        coinDetails.append(("Low", String(low)))
        
        var volume = mCoins.volume
        coinDetails.append(("Volume", String(volume)))
        
        var bid = mCoins.bid
        if bid < 0.01 {
            bid = (bid * 10000000000) / 10000000000
        }
        coinDetails.append(("Bid", String(bid)))
        
        var ask = mCoins.ask
        if ask < 0.01 {
            ask = (ask * 10000000000) / 10000000000
        }
        coinDetails.append(("Ask", String(ask)))
        
        var openBuyOrders = mCoins.openBuyOrders
        coinDetails.append(("Open buy orders", String(openBuyOrders)))
        
        var openSellOrders = mCoins.openSellOrders
        coinDetails.append(("Open sell orders", String(openSellOrders)))
        
        mTableView.reloadData()
        
        
        
        
    }
    
    func updateView(coin: CoinAttributes) {
        self.mCoin = coin
        
        if self.marketNameLabel != nil {
            self.marketNameLabel.text = self.mCoin?.marketName
        }
        if self.mNavigationBar != nil{
            self.mNavigationBar.topItem?.title = self.mCoin?.marketCurrencyLong
        }
        
        if(coin.logoUrl != nil){
            let url = URL(string: coin.logoUrl!)
            if( url != nil){
                    if let mImage = self.mCoinImageView{
                        self.manager.loadImage(with: url!, into: mImage)
                    }
            }else{
                if let mImage = self.mCoinImageView{
                    mImage.image = #imageLiteral(resourceName: "Icon-App-76x76-1")
                }
            }
        }else{
            if let mImage = self.mCoinImageView{
                mImage.image = #imageLiteral(resourceName: "Icon-App-76x76-1")
            }
        }
    }
    
    
}


