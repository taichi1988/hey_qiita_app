//
//  SearchResultStore.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/10.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: - State
struct SearchResultState: StateType {
    internal(set) var articles = BehaviorRelay<[Article]>(value: [])
    internal(set) var error = BehaviorRelay<Error?>(value: nil)
}

// MARK: - Store
final class SearchResultStore: Store<SearchResultState> {
    override func reducer(action: Action, state: SearchResultState) {
        guard let action = action as? SearchResultAction else { return }
        
        switch action {
        case .fetchedArticles(let articles):
            var nextArticles = state.articles.value
            nextArticles.append(contentsOf: articles)
            state.articles.accept(nextArticles)
            
        case .catchError(let error):
            state.error.accept(error)
        }
    }
}
