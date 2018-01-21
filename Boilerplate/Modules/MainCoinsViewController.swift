//
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
    //CRIAR DATA E SHOWN DATA PARA TER AS INFORMACOES APOS APAGAR O FILTRO
    let disposeBag = DisposeBag()
    // MARK: Properties
    
    var presenter: MainSearchPresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet var mSearchBar: UISearchBar!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
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

        mSearchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value
                self.mShownCoins = self.mCoins.filter {  ($0.marketCurrencyLong!.hasPrefix(query))}
                self.mShownCoins.sort { (first, next) -> Bool in
                    return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
                }
                self.mTableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag)
        
        setupView()
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
                let url = URL(string: self.mShownCoins[indexPath.row].logoUrl!)
                cell.coinLogoImageView.image = nil
                self.manager.loadImage(with: url!, into: cell.coinLogoImageView)
            }
        cell.coinTitleLabel.text = "\(mShownCoins[indexPath.row].marketCurrencyLong!) (\(mShownCoins[indexPath.row].marketName!))"
        cell.coinReferenceLabel.text = "Ref.: \(mShownCoins[indexPath.row].baseCurrencyLong!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coinAttribute: CoinAttributes = mShownCoins[indexPath.row] {
            presenter?.showCoinDetail(coinAttribute)
        }
    }
    
    
    
    
    // MARK: IBActions
    
  
    @IBAction func refreshCoins(_ sender: Any) {
        presenter?.retrieveCoins()
    }
    
    // MARK: Private
    
    private func setupView() {
        // TODO: Setup view here
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
    func updateIndicator(state: Bool) {
        if state {
            self.progressIndicator.isHidden = false
            self.progressIndicator.startAnimating()
        }else{
            self.progressIndicator.isHidden = true
            self.progressIndicator.stopAnimating()
        }
    }
    
    func updateCoinTable(mCoins: [CoinAttributes]) {
        self.mCoins = mCoins
        self.mShownCoins = self.mCoins
        self.mShownCoins.sort { (first, next) -> Bool in
            return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
        }
        
        DispatchQueue.main.async() {
            self.mTableView.reloadData()
            self.mTableView.tableFooterView = UIView(frame: .zero)
        }
        
    }
    
    
    //TODO: Implement MainSearchView methods here
    
    
}

