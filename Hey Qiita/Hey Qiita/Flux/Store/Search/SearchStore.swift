//
//  SearchStore.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift
import RxCocoa

struct SearchState: StateType {
    internal(set) var tags = BehaviorRelay<[Tag]>(value: [])
    internal(set) var error = BehaviorRelay<Error?>(value: nil)
}

final class SearchStore: Store<SearchState> {
    override func reducer(action: Action, state: SearchState) {
        guard let action = action as? SearchAction else { return }
        
        switch action {
        case .fetchedTags(let tags):
            state.tags.accept(tags)
            
        case .catchError(let error):
            state.error.accept(error)
        }
    }
}
