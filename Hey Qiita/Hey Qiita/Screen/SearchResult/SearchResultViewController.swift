//
//  SearchResultViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/09.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift

/// 検索結果一覧画面
final class SearchResultViewController: TimelineBaseViewController, LoadingStatusObservable {
    private let store = SearchResultStore()
    private let action = SearchResultActionCreator()
    private let disposeBag = DisposeBag()
    private var searchType: SearchType!
    
    // MARK: override
    let tableFooterLoadingView: TableFooterLoadingView? = TableFooterLoadingView()
    let loadingStore: LoadingStore = LoadingStore()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(tagId: String) {
        self.init()
        searchType = .tag(id: tagId)
    }
    
    convenience init(searchWord: String) {
        self.init()
        searchType = .freeWord(word: searchWord)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = searchType.title
        tableView.tableFooterView = tableFooterLoadingView
        
        initObserver()
        action.search(type: searchType)
    }
    
    private func initObserver() {
        // observe articles
        store.state.articles
            .asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] in
                self?.articles = $0
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // observe load status
        observeLoadingStatus()
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let vc = ArticleDetailViewController(article: articles[indexPath.row])
        show(vc, sender: nil)
    }
    
    override func fetchMoreAction() {
        action.search(type: searchType)
    }
}
