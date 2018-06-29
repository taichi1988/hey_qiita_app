//
//  SearchAction.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

// MARK: - Actions
enum SearchAction: Action {
    case fetchedTags([Tag])
    case catchError(Error)
}

// MARK: - ActionCreator
final class SearchActionCreator {
    private let disposeBag = DisposeBag()
    
    func fetchTags() {
        dispatcher.onNext(LoadingAction.updateStatus(.initFetching))
        
        ApiClient.request(TagRequest.all(page: 1, sort: .count))
            .map { tags -> SearchAction in
                return SearchAction.fetchedTags(tags)
            }
            .subscribe(
                onSuccess: {
                    dispatcher.onNext($0)
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                },
                onError: {
                    dispatcher.onNext(SearchAction.catchError($0))
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                })
            .disposed(by: disposeBag)
    }
}
