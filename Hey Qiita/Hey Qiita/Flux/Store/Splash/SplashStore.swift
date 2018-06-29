//
//  SplashStore.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/30.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: - State
struct SplashState: StateType {
    internal(set) var isLoggedin = PublishSubject<Bool>()
    internal(set) var didSaveUserIdEvent = PublishSubject<Void>()
    internal(set) var error = BehaviorRelay<Error?>(value: nil)
}

// MARK: - Store
final class SplashStore: Store<SplashState> {
    override func reducer(action: Action, state: SplashState) {
        guard let action = action as? SplashAction else { return }
        
        switch action {
        case .checkAccessToken(let exist):
            state.isLoggedin.onNext(exist)
            
        case .saveUserId(let id):
            UserDefaults.userId = id
            state.didSaveUserIdEvent.onNext(())
            
        case .catchError(let error):
            state.error.accept(error)
        }
    }
}
