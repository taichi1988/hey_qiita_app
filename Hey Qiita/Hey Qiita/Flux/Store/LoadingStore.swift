//
//  LoadingStore.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: - State
struct LoadingState: StateType {
    enum Status {
        case undefined
        case initFetching // 初回取得中
        case moreFetching // 追加取得中
        case refreshing // 引っ張って再取得中
        case updated // 取得完了
        case allFetched // 全て取得済み
    }
    
    internal(set) var loadStatus = BehaviorRelay<Status>(value: .undefined)
}

// MARK: - Store
final class LoadingStore: Store<LoadingState> {
    override func reducer(action: Action, state: LoadingState) {
        guard let action = action as? LoadingAction else { return }
        
        switch action {
        case .updateStatus(let status):
            state.loadStatus.accept(status)
        }
    }
}
