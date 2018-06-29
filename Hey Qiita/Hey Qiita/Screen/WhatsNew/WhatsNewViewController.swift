//
//  WhatsNewViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// 新着一覧画面
final class WhatsNewViewController: TimelineBaseViewController, TableHeaderViewAnimatable, LoadingStatusObservable {
    private let disposeBag = DisposeBag()
    private let store = WhatsNewStore()
    private let action = WhatsNewActionCreator()
    
    // MARK: override
    let tableFooterLoadingView: TableFooterLoadingView? = TableFooterLoadingView()
    let refreshControl: RefreshControl? = RefreshControl()
    let loadingStore: LoadingStore = LoadingStore()
    let screenName: String = "What's New"
    let titleLabel: UILabel = UILabel()
    let tableHeaderView: TableHeaderTitleView = TableHeaderTitleView()
    var referenceTableView: UITableView { return tableView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        initLayout()
        initObserver()
        action.fetch()
    }
    
    private func initLayout() {
        navigationItem.titleView = titleLabel
        tableView.tableFooterView = tableFooterLoadingView
        tableView.refreshControl = refreshControl
        refreshControl?.selector = { [weak self] in
            self?.action.refresh()
        }
    }
    
    private func initObserver() {
        // observe articles
        store.state.articles
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] in
                self?.articles = $0
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // observe load status
        observeLoadingStatus()
        
        // top title animation
        observeScrollTopAnimation()
    }
    
    override func didSelectRow(at indexPath: IndexPath) {
        let vc = ArticleDetailViewController(article: articles[indexPath.row])
        show(vc, sender: nil)
    }
    
    override func fetchMoreAction() {
        action.fetch()
    }
}
