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
import FirebaseDatabase
import Firebase
import ObjectMapper


class NewsListViewController: BaseViewController, StoryboardLoadable, UITableViewDelegate, UITableViewDataSource {
    
    var manager = Nuke.Manager.shared
    var mArticles: [Articles] = []
    var shownArticles: [Articles] = []

    let disposeBag = DisposeBag()
    var ref: DatabaseReference!
    
    // MARK: Properties
    
    var presenter: NewsListPresentation?
    
    // MARK: Lifecycle
    @IBOutlet var mTableView: UITableView!
    @IBOutlet var mNewsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
    
        self.mTableView.delegate = self
        self.mTableView.dataSource = self
        self.mTableView.allowsMultipleSelection = false
        self.mTableView.tableFooterView = UIView()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        mNewsSearchBar.placeholder = "Filter"
        mNewsSearchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value
                self.shownArticles = self.mArticles.filter {  ($0.description!.localizedCaseInsensitiveContains(query))}
                if query.count <= 0 {
                    self.shownArticles = self.mArticles
                }
                self.mTableView.reloadData() // And reload table view data.
            })
            .disposed(by: disposeBag)
        
        if Connectivity.isConnectedToInternet() {
            presenter?.setRealtimeObserver()
        }else{
            self.hideLoading()
            self.showMessage("No Internet. Verify your connection.", withTitle: "Ops!")
        }
        hideKeyboardWhenTappedAround()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shownArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableCell
        cell.url = self.shownArticles[indexPath.row].url
        cell.newsAuthorLabel.text = self.shownArticles[indexPath.row].author
        cell.newsTitleLabel.text = self.shownArticles[indexPath.row].title
        cell.newsDescriptionLabel.text = self.shownArticles[indexPath.row].description
        if(self.shownArticles[indexPath.row].urlToImage != nil){
            if(self.shownArticles[indexPath.row].urlToImage!.count > 0){
                let url = URL(string: self.shownArticles[indexPath.row].urlToImage!)
                cell.newsImageView.image = nil
                (url != nil) ? (self.manager.loadImage(with: url!, into: cell.newsImageView)) : (cell.newsImageView.image = #imageLiteral(resourceName: "Icon-App-76x76-1"))
            }else{
                cell.newsImageView.image = #imageLiteral(resourceName: "Icon-App-76x76-1")
            }
        }else{
            cell.newsImageView.image = #imageLiteral(resourceName: "Icon-App-76x76-1")
        }
        if let mDate = self.shownArticles[indexPath.row].publishedAt {
            let dateString = mDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let dateObj = dateFormatter.date(from: dateString)
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            cell.newsDateLabel.text = "\(dateFormatter.string(from: dateObj!))"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url: String = shownArticles[indexPath.row].url {
            presenter?.goToNewsDetail(url: url)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupKeyboardNotifications(with: scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mNewsSearchBar.text = nil
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
    func updateNews(news: [Articles], isFromObserver: Bool) {
        if isFromObserver {
            self.mArticles = news
            self.shownArticles = self.mArticles
            mTableView.reloadData()
            ref.updateChildValues(["timestamp": Date().timeIntervalSince1970])
            for pos in 0...(self.mArticles.count - 1) {
                let JSONString = self.mArticles[pos].toJSONString(prettyPrint: false)
                if let data = JSONString!.convertToDictionary(){
                    ref.child("article\(pos)").updateChildValues(data)
                }
            }
        }else{
            self.mArticles = news
            self.shownArticles = self.mArticles
            self.mNewsSearchBar.text = nil
            self.mTableView.reloadData()
        }
        
    }
    
}




