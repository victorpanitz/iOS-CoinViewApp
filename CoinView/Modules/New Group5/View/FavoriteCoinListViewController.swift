//
//  FavoriteCoinListView.swift
//  CoinView
//
//  Created by Victor Magalhaes on 18/02/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import UIKit
import Nuke
import RxSwift
import RxCocoa

class FavoriteCoinListViewController: BaseViewController, StoryboardLoadable, UITableViewDelegate, UITableViewDataSource {
    
    var manager = Nuke.Manager.shared
    var mCoins : [CoinAttributes] = []
    var mShownCoins : [CoinAttributes] = []
    
    //CRIAR DATA E SHOWN DATA PARA TER AS INFORMACOES APOS APAGAR O FILTRO
    let disposeBag = DisposeBag()
    // MARK: Properties
    
    var presenter: FavoriteCoinListPresentation?
    
    // MARK: IBOutlets
    
    @IBOutlet var mFavSearchBar: UISearchBar!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.allowsMultipleSelection = false
        self.mTableView.tableFooterView = UIView()

            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.barTintColor = UIColor.red
            self.navigationController?.navigationBar.tintColor = UIColor.white
        
        mFavSearchBar.placeholder = "Filter"
        mFavSearchBar
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
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.retrieveCoins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardNotifications(with: scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mFavSearchBar.text = nil
        removeKeyboardNotification()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mShownCoins.count
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.destructive, title: "  Dump  ", handler:{action, indexpath in
            if let coin: CoinAttributes = self.mShownCoins[indexPath.row] {
                self.presenter?.removeFavoriteCoin(coin: coin)
                for i in 1...40 {
                    self.generateFavoriteAnimation()
                }
            }
        })
//        moreRowAction.backgroundColor = UIColor.red
        return [moreRowAction]
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
    
    
    // MARK: Private
    
    
    func moveToNextField(_ view: UIView, nextFieldTag: Int) {
        let nextResponder = view.superview?.viewWithTag(nextFieldTag) as UIResponder!
        if (nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
        }
    }
    
    fileprivate func generateFavoriteAnimation(){
        
        let aleatory = drand48()
        var imageView = UIImageView()
        imageView = aleatory > 0.5 ? UIImageView(image: #imageLiteral(resourceName: "star")) : UIImageView(image: #imageLiteral(resourceName: "coin"))
        
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = customPath2().cgPath
        animation.duration = 3 + drand48() * 5
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        
    }

    
}

func customPath2() -> UIBezierPath{
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x:500,y: 0))
    let endpoint = CGPoint(x: -300, y: 700)
    
    let randomYShift = 200 + drand48() * 800
    let cp1 = CGPoint(x: 400, y: 100 - randomYShift)
    let cp2 = CGPoint(x: 600, y: 50 + randomYShift)
    
    path.addCurve(to: endpoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

class CurvedView2: UIView{
    override func draw(_ rect: CGRect) {
        let path = customPath2()
        path.lineWidth = 3
        path.stroke()
    }
}


extension  FavoriteCoinListViewController: FavoriteCoinListView {
    func updateCoinTable(coins: [CoinAttributes]) {
        self.mCoins = coins
        self.mShownCoins = mCoins
        self.mShownCoins.sort { (first, next) -> Bool in
            return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
        }
        mTableView.reloadData()
    }
    
}




