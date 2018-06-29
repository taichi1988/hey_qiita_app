//
//  TableHeaderViewAnimatable.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol TableHeaderViewAnimatable where Self: UIViewController {
    var screenName: String { get }
    var titleLabel: UILabel { get }
    var referenceTableView: UITableView { get }
    var tableHeaderView: TableHeaderTitleView { get }
}

extension TableHeaderViewAnimatable {
    func setTitle() {
        titleLabel.text = screenName
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        titleLabel.alpha = 0
        referenceTableView.tableHeaderView = tableHeaderView
        tableHeaderView.titleLabel.text = screenName
    }
    
    func ajustTableHeaderFooterHeight() {
        guard let headerView = referenceTableView.tableHeaderView else { return }
        referenceTableView.tableHeaderView?.frame.size.height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        guard let footerView = referenceTableView.tableFooterView else { return }
        referenceTableView.tableFooterView?.frame.size.height = footerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
    }
    
    func observeScrollTopAnimation() {
        _ = referenceTableView.rx.contentOffset
            .subscribe(onNext: { [weak self] offset in
                UIView.animate(withDuration: 0.2) {
                    self?.titleLabel.alpha = offset.y > 0 ? 1 : 0
                }
            })
    }
}
