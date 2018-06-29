//
//  SearchViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// 検索画面
final class SearchViewController: UIViewController, TableHeaderViewAnimatable, LoadingStatusObservable {
    private enum Section {
        case freeForm
        case tags
    }

    private let sections: [Section] = [.freeForm, .tags]
    private let disposeBag = DisposeBag()
    private let store = SearchStore()
    private let action = SearchActionCreator()
    private var tags: [Tag] = []
    
    // override
    let loadingStore: LoadingStore = LoadingStore()
    let screenName: String = "Search"
    let titleLabel: UILabel = UILabel()
    let referenceTableView: UITableView = UITableView()
    let tableHeaderView: TableHeaderTitleView = TableHeaderTitleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
        initLayout()
        initObserver()
        observeScrollTopAnimation()
        action.fetchTags()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        ajustTableHeaderFooterHeight()
    }
    
    private func initLayout() {
        navigationItem.titleView = titleLabel
        view.addSubview(referenceTableView)
        referenceTableView.delegate = self
        referenceTableView.dataSource = self
        referenceTableView.estimatedRowHeight = 44
        referenceTableView.rowHeight = UITableViewAutomaticDimension
        referenceTableView.tableFooterView = tableFooterLoadingView
        referenceTableView.register(FreeFormCell.self, TagCell.self)
        referenceTableView.snp.makeConstraintsEqualToSuperview()
    }
    
    private func initObserver() {
        // observe tags
        store.state.tags
            .asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] in
                self?.tags = $0
                self?.referenceTableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        // observe load status
        observeLoadingStatus()
    }
}

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .freeForm: return 1
        case .tags: return tags.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .freeForm:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: FreeFormCell.self)
            cell.setReturnKeyAction { [weak self] in
                let vc = SearchResultViewController(searchWord: $0)
                self?.show(vc, sender: nil)
            }
            return cell
        case .tags:
            let cell = tableView.dequeueReusableCell(for: indexPath, as: TagCell.self)
            cell.set(tag: tags[indexPath.row])
            return cell
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SearchResultViewController(tagId: tags[indexPath.row].id)
        show(vc, sender: nil)
    }
}
