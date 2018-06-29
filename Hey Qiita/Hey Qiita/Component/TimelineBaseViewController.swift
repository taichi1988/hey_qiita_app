//
//  TimelineBaseViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/09.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

/// 記事一覧 共通レイアウトのベースクラス
class TimelineBaseViewController: UIViewController {
    //MARK: override
    let tableView = UITableView()
    var articles: [Article] = []
    func fetchMoreAction() { }
    func didSelectRow(at indexPath: IndexPath) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = tableView.tableHeaderView else { return }
        tableView.tableHeaderView?.frame.size.height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        guard let footerView = tableView.tableFooterView else { return }
        tableView.tableFooterView?.frame.size.height = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(TimelineCell.self)
        tableView.snp.makeConstraintsEqualToSuperview()
    }
}

extension TimelineBaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, as: TimelineCell.self)
        cell.set(article: articles[indexPath.row])
        return cell
    }
}

extension TimelineBaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = articles.count - 1
        if indexPath.row == lastRow {
            fetchMoreAction()
        }
    }
}
