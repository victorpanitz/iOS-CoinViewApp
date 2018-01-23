//
//  NewsListPresenter.swift
//  Boilerplate
//
//  Created by Victor Magalhaes on 22/01/2018.
//  Copyright © 2018 Cheesecake Labs. All rights reserved.
//

import UIKit
import Nuke
import RxSwift
import RxCocoa

class NewsListViewController: BaseViewController, StoryboardLoadable, UITableViewDelegate, UITableViewDataSource {
    
    var manager = Nuke.Manager.shared
    var mArticles: [Articles] = []
    let disposeBag = DisposeBag()
    
    // MARK: Properties
    
    var presenter: NewsListPresentation?
    
    // MARK: Lifecycle
    @IBOutlet var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.allowsMultipleSelection = false
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
//        mSearchBar
//            .rx.text // Observable property thanks to RxCocoa
//            .orEmpty // Make it non-optional
//            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
//            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
//            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value
//                self.mShownCoins = self.mCoinReferenced.filter {  ($0.marketCurrencyLong!.hasPrefix(query))}
//                self.mShownCoins.sort { (first, next) -> Bool in
//                    return first.marketCurrencyLong!.compare(next.marketCurrencyLong!) == .orderedAscending
//                }
//                self.mTableView.reloadData() // And reload table view data.
//            })
//            .disposed(by: disposeBag)
        
        hideKeyboardWhenTappedAround()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableCell
        cell.newsAuthorLabel.text = self.mArticles[indexPath.row].author
        cell.newsTitleLabel.text = self.mArticles[indexPath.row].title
        cell.newsDescriptionLabel.text = self.mArticles[indexPath.row].description
        if(self.mArticles[indexPath.row].urlToImage != nil){
            if(self.mArticles[indexPath.row].urlToImage!.count > 0){
                let url = URL(string: self.mArticles[indexPath.row].urlToImage!)
                cell.newsImageView.image = nil
                self.manager.loadImage(with: url!, into: cell.newsImageView)
            }else{
                cell.newsImageView.image = #imageLiteral(resourceName: "Icon-App-76x76-1")
            }
        }else{
            cell.newsImageView.image = #imageLiteral(resourceName: "Icon-App-76x76-1")
        }
        if let mDate = self.mArticles[indexPath.row].publishedAt {
                cell.newsDateLabel.text = "\(mDate.toDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss"))"
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.fetchNews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupKeyboardNotifications(with: scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardNotification()
    }
    
    // MARK: IBActions
    
    // MARK: Private
    
    func moveToNextField(_ view: UIView, nextFieldTag: Int) {
        let nextResponder = view.superview?.viewWithTag(nextFieldTag) as UIResponder!
        if (nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
        }
    }
    
}

extension  NewsListViewController: NewsListView {
    func updateNews(news: [Articles]) {
        self.mArticles = news
        mTableView.reloadData()
    }
    
   
    //TODO: Implement MainSearchView methods here
    
}




