//
//  LoadingStatusObservable.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/11.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift

protocol LoadingStatusObservable where Self: UIViewController {
    var loadingIndicator: LoadingIndicator { get }
    var tableFooterLoadingView: TableFooterLoadingView? { get }
    var refreshControl: RefreshControl? { get }
    var loadingStore: LoadingStore { get }
}

extension LoadingStatusObservable {
    var loadingIndicator: LoadingIndicator { return LoadingIndicator() }
    var tableFooterLoadingView: TableFooterLoadingView? { return nil }
    var refreshControl: RefreshControl? { return nil }
}

extension LoadingStatusObservable {
    func observeLoadingStatus() {
        _ = loadingStore.state.loadStatus
            .asObservable()
            .skip(1)
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .initFetching:
                    self?.loadingIndicator.show()
                case .moreFetching:
                    self?.tableFooterLoadingView?.startLoadingAnimation()
                case .refreshing:
                    self?.refreshControl?.beginRefreshing()
                default:
                    self?.loadingIndicator.dismiss()
                    self?.tableFooterLoadingView?.stopLoadingAnimation()
                    self?.refreshControl?.endRefreshing()
                }
            })
    }
}

final class RefreshControl: UIRefreshControl {
    private let disposeBag = DisposeBag()
    var selector: (() -> Void)?
    
    override init() {
        super.init()
        
        tintColor = .primary
        attributedTitle = NSAttributedString(string: "Refreshing...")
        rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.selector?()
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
