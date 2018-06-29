//
//  WhatsNewStore.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/04.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: - State
struct WhatsNewState: StateType {
    internal(set) var articles = BehaviorRelay<[Article]>(value: [])
    internal(set) var error = BehaviorRelay<Error?>(value: nil)
}

// MARK: - Store
final class WhatsNewStore: Store<WhatsNewState> {
    override func reducer(action: Action, state: WhatsNewState) {
        guard let action = action as? WhatsNewAction else { return }

        switch action {
        case .fetchedArticles(let articles):
            var nextArticles = state.articles.value
            nextArticles.append(contentsOf: articles)
            state.articles.accept(nextArticles)
            
        case .refreshedArticles(let articles):
            state.articles.accept(articles)
            
        case .catchError(let error):
            state.error.accept(error)
        }
    }
}
