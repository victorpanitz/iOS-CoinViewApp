///
//  MainSearchViewController.swift
//  Boilerplate
//
//  Created by MARCELO GRACIETTI on 23/01/17.
//  Copyright © 2017 Cheesecake Labs. All rights reserved.
//

import UIKit
import Nuke
import RxSwift
import RxCocoa

class MainSearchViewController: BaseViewController, StoryboardLoadable, UITableViewDelegate, UITableViewDataSource {
    
    
    var manager = Nuke.Manager.shared
    var mCoins : [CoinAttributes] = []
    var mShownCoins : [CoinAttributes] = []
    var mCoinReferenced: [CoinAttributes] = []
    
    //CRIAR DATA E SHOWN DATA PARA TER AS INFORMACOES APOS APAGAR O FILTRO
    let disposeBag = DisposeBag()
    // MARK: Properties
    
    var presenter: MainSearchPresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet var sectionReferenceFilter: UISegmentedControl!
    @IBOutlet var mSearchBar: UISearchBar!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.allowsMultipleSelection = false
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        mSearchBar.placeholder = "Filter"
        mSearchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value
                self.mShownCoins = self.mCoinReferenced.filter {  ($0.marketCurrencyLong!.hasPrefix(query))}
                self.mShownCoins.sort { (first, next) -> Bool in
                    return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
                }
                self.mTableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag)
        
        hideKeyboardWhenTappedAround()
        presenter?.retrieveCoins()
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
        return mShownCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as! mTableViewCell
        cell.coinAttributes = self.mShownCoins[indexPath.row]
        if(self.mShownCoins[indexPath.row].logoUrl != nil){
            if(self.mShownCoins[indexPath.row].logoUrl!.count > 0){
                let url = URL(string: self.mShownCoins[indexPath.row].logoUrl!)
                cell.coinLogoImageView.image = nil
                self.manager.loadImage(with: url!, into: cell.coinLogoImageView)
            }else{
                cell.coinLogoImageView.image = #imageLiteral(resourceName: "Icon-App-76x76-1")
            }
        }else{
           cell.coinLogoImageView.image = #imageLiteral(resourceName: "Icon-App-76x76-1")
        }
        cell.coinTitleLabel.text = "\(mShownCoins[indexPath.row].marketCurrencyLong!) (\(mShownCoins[indexPath.row].marketName!))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coinAttribute: CoinAttributes = mShownCoins[indexPath.row] {
            presenter?.showCoinDetail(coinAttribute)
        }
    }
    
    // MARK: IBActions
    
    
    @IBAction func sectionReferenceChanged(_ sender: UISegmentedControl) {
        mSearchBar.text = ""
        setupReference()
    }
    
    // MARK: Private
    
    private func setupReference(){
        switch sectionReferenceFilter.selectedSegmentIndex {
        case 0:
            self.mCoinReferenced = self.mCoins.filter {  ($0.baseCurrency!.hasPrefix("BTC"))}
            self.mCoinReferenced.sort { (first, next) -> Bool in
                return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
            }
            self.mShownCoins = self.mCoinReferenced
            
        case 1:
            self.mCoinReferenced = self.mCoins.filter {  ($0.baseCurrency!.hasPrefix("ETH"))}
            self.mCoinReferenced.sort { (first, next) -> Bool in
                return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
            }
            self.mShownCoins = self.mCoinReferenced

        case 2:
            self.mCoinReferenced = self.mCoins.filter {  ($0.baseCurrency!.hasPrefix("USDT"))}
            self.mCoinReferenced.sort { (first, next) -> Bool in
                return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
            }
            self.mShownCoins = self.mCoinReferenced

        default:
            break
        }
        
            self.mTableView.reloadData()
            //self.mTableView.scrollsToTop = true
            self.mTableView.tableFooterView = UIView(frame: .zero)
        
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

extension  MainSearchViewController: MainSearchView {
    
    
    func updateCoinTable(mCoins: [CoinAttributes]) {
        self.mCoins = mCoins
        self.mCoinReferenced = self.mCoins
        self.mShownCoins = self.mCoins
        setupReference()
    }
    
    //TODO: Implement MainSearchView methods here
    
}



