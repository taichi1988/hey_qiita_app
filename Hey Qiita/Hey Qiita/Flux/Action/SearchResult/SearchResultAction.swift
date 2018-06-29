//
//  SearchResultAction.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/10.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

enum SearchType {
    case freeWord(word: String)
    case tag(id: String)
    
    var title: String {
        switch self {
        case .freeWord(let word): return "\"\(word)\""
        case .tag(let id): return id
        }
    }
    
    func request(currentPage: Int) -> ArticleListRequest {
        switch self {
        case .freeWord(let word):
            return .searchByWord(page: currentPage, query: word)
        case .tag(let id):
            return .searchByTag(id: id, page: currentPage)
        }
    }
}

// MARK: - Actions
enum SearchResultAction: Action {
    case fetchedArticles([Article])
    case catchError(Error)
}

// MARK: - ActionCreator
final class SearchResultActionCreator {
    private let disposeBag: DisposeBag = DisposeBag()
    private var currentPage: Int = 1
    
    func search(type: SearchType) {
        // 記事は50ページまでしか読み込まない
        guard currentPage < 50 else {
            dispatcher.onNext(LoadingAction.updateStatus(.allFetched))
            return
        }
        dispatcher.onNext(LoadingAction.updateStatus(currentPage <= 1 ? .initFetching : .moreFetching))
        
        ApiClient.request(type.request(currentPage: currentPage))
            .map { articles -> SearchResultAction in
                return SearchResultAction.fetchedArticles(articles)
            }
            .subscribe(
                onSuccess: { [weak self] action in
                    self?.currentPage += 1
                    dispatcher.onNext(action)
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                },
                onError: { error in
                    dispatcher.onNext(SearchResultAction.catchError(error))
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
            })
            .disposed(by: disposeBag)
    }
}
