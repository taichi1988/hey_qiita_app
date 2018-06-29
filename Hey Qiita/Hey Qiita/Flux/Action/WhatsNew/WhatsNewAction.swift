//
//  WhatsNewAction.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/04.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

// MARK: - Actions
enum WhatsNewAction: Action {
    case fetchedArticles([Article])
    case refreshedArticles([Article])
    case catchError(Error)
}


// MARK: - ActionCreator
final class WhatsNewActionCreator {
    private let disposeBag: DisposeBag = DisposeBag()
    private var currentPage: Int = 1
    
    func fetch() {
        // 記事は50ページまでしか読み込まない
        guard currentPage < 50 else {
            dispatcher.onNext(LoadingAction.updateStatus(.allFetched))
            return
        }
        
        dispatcher.onNext(LoadingAction.updateStatus(currentPage <= 1 ? .initFetching : .moreFetching))
        
        ApiClient.request(ArticleListRequest.fetchAll(page: currentPage))
            .map { articles -> WhatsNewAction in
                return WhatsNewAction.fetchedArticles(articles)
            }
            .subscribe(
                onSuccess: { [weak self] action in
                    self?.currentPage += 1
                    dispatcher.onNext(action)
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                },
                onError: { error in
                    dispatcher.onNext(WhatsNewAction.catchError(error))
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                })
            .disposed(by: disposeBag)
    }
    
    func refresh() {
        currentPage = 1
        dispatcher.onNext(LoadingAction.updateStatus(.refreshing))
        
        ApiClient.request(ArticleListRequest.fetchAll(page: currentPage))
            .map { articles -> WhatsNewAction in
                return WhatsNewAction.refreshedArticles(articles)
            }
            .subscribe(
                onSuccess: { [weak self] action in
                    self?.currentPage += 1
                    dispatcher.onNext(action)
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                },
                onError: { error in
                    dispatcher.onNext(WhatsNewAction.catchError(error))
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                })
            .disposed(by: disposeBag)
    }
}
