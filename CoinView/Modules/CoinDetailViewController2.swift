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
    var mCoins : [CoinAttributes] = []
    // MARK: Properties
    
    var presenter: CoinDetailPresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "icArrowLeft")
        
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
        return mCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "mCell", for: indexPath) as! mTableViewCell

        
        return cell
    }
    
    
    // MARK: IBActions
    
    
    @IBAction func refreshCoins(_ sender: Any) {
//        presenter?.retrieveCoins()
    }
    
    // MARK: Private
    
    private func setupView() {
        // TODO: Setup view here
        self.view.backgroundColor = UIColor.black
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
        if state {
            self.progressIndicator.isHidden = false
            self.progressIndicator.startAnimating()
        }else{
            self.progressIndicator.isHidden = true
            self.progressIndicator.stopAnimating()
        }
    }
    
    func updateCoinTable(mCoins: [CoinAttributes]) {
        
    }
    
        
    
}

