//
//  MypageViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/06.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// TODO: 上にスクロールさせるとヘッダーもスクロールして隠れる実装（面倒臭すぎ）

/// マイページ
final class MypageViewController: UIViewController {
    private lazy var layoutBaseScrollView = UIScrollView()
    private lazy var layoutBaseView = UIView()
    private lazy var headerView = HeaderView()
    private lazy var tabPagingView = UIView()
    private let tabPagingViewController = TabPagingViewController()
    private let stockListViewController = MypageStockListViewController()
    private let followingTagsViewController = MypageFollowingTagsViewController()
    private let followeesViewController = MypageFolloweesViewController()
    private let disposeBag = DisposeBag()
    private let store = MypageStore()
    private let action = MypageActionCreator()

    override func viewDidLoad() {
        super.viewDidLoad()

        initLayout()
        initObserver()
        action.fetchUser()
        action.fetchStockList()
        action.fetchFollowingTags()
        action.fetchFollowees()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateConstraints()
    }
    
    private func initLayout() {
        title = "Mypage"
        view.addSubview(layoutBaseScrollView)
        layoutBaseScrollView.addSubview(layoutBaseView)
        layoutBaseView.addSubviews(headerView, tabPagingView)
        
        layoutBaseScrollView.bounces = true
        layoutBaseScrollView.showsVerticalScrollIndicator = false
        layoutBaseScrollView.snp.makeConstraintsEqualToSuperview()
        
        tabPagingViewController.dataSource = self
        addChildViewController(tabPagingViewController)
        tabPagingViewController.didMove(toParentViewController: self)
        tabPagingView.addSubview(tabPagingViewController.view)
        
        tabPagingViewController.view.snp.makeConstraintsEqualToSuperview()
        layoutBaseView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
    
    private func initObserver() {
        // observe user data
        let user = store.state.user.asDriver().filter { $0.isNotNil }
        // observe stocked articles
        let stockList = store.state.stockList.asDriver()
        // observe following tags
        let followingTags = store.state.followingTags.asDriver()
        // observe followees
        let followees = store.state.followees.asDriver()
        
        Driver.combineLatest(user, stockList, followingTags, followees)
            .drive(onNext: { [weak self] in
                self?.headerView.set(user: $0!)
                self?.stockListViewController.set(articles: $1)
                self?.followingTagsViewController.set(tags: $2)
                self?.followeesViewController.set(followees: $3)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateConstraints() {
        let navBarHeight = navigationController?.navigationBar.bounds.height ?? 0
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let tabBarHeight = tabBarController?.tabBar.bounds.height ?? 0
        let headerHeight = headerView.bounds.height
        let height = view.bounds.height - statusBarHeight - navBarHeight - tabBarHeight - headerHeight
        tabPagingView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(height)
        }
    }
}

// MARK: -
extension MypageViewController: TabPagingViewControllerDataSource {
    func tabPagingViewControllerItems(_ vc: TabPagingViewController) -> [TabPageItem] {
        return [TabPageItem(title: "Stocks", vc: stockListViewController),
                TabPageItem(title: "FollowingTags", vc: followingTagsViewController),
                TabPageItem(title: "Followees", vc: followeesViewController),]
    }
    
    func tabPagingViewControllerDefaultPageIndex(_ vc: TabPagingViewController) -> Int {
        return 1
    }
}
