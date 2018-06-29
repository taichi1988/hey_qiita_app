//
//  MypageStore.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/09.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift
import RxCocoa

struct MypageState: StateType {
    internal(set) var user = BehaviorRelay<User?>(value: nil)
    internal(set) var stockList = BehaviorRelay<[Article]>(value: [])
    internal(set) var followingTags = BehaviorRelay<[Tag]>(value: [])
    internal(set) var followees = BehaviorRelay<[User]>(value: [])
    internal(set) var error = BehaviorRelay<Error?>(value: nil)
}

final class MypageStore: Store<MypageState> {
    override func reducer(action: Action, state: MypageState) {
        guard let action = action as? MypageAction else { return }
        
        switch action {
        case .fetchedUser(let user):
            state.user.accept(user)
            
        case .fetchedStockList(let articles):
            state.stockList.accept(articles)
            
        case .fetchedFollowingTags(let tags):
            state.followingTags.accept(tags)
            
        case .fetchedFollowees(let users):
            state.followees.accept(users)
            
        case .catchError(let error):
            state.error.accept(error)
        }
    }
}
