//
//  AuthStore.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/29.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: - State
struct AuthState: StateType {
    internal(set) var isSucceedSaveAccessToken = BehaviorRelay<Bool>(value: false)
    internal(set) var dismissedEvent = PublishSubject<Void>()
    internal(set) var error = BehaviorRelay<Error?>(value: nil)
}

// MARK: - Store
final class AuthStore: Store<AuthState> {
    override func reducer(action: Action, state: AuthState) {
        guard let action = action as? AuthAction else { return }
        
        switch action {
        case .succeedSaveAccessToken:
            state.isSucceedSaveAccessToken.accept(true)
        
        case .faildSaveAccessToken:
            state.isSucceedSaveAccessToken.accept(false)
            
        case .dismissed:
            state.dismissedEvent.onNext(())
            
        case .catchError(let error):
            state.error.accept(error)
        }
    }
}
