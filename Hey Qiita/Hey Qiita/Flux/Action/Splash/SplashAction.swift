//
//  SplashAction.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/30.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

// MARK: - Action
enum SplashAction: Action {
    case checkAccessToken(exist: Bool)
    case saveUserId(String)
    case catchError(Error?)
}

// MARK: - ActionCreator
final class SplashActionCreator {
    private let disposeBag = DisposeBag()
    
    func checkAccessToken() {
        let action = SplashAction.checkAccessToken(exist: KeychainUtil.accessToken.isNotEmpty)
        dispatcher.onNext(action)
    }
    
    func fetchUser() {
        ApiClient.request(UserRequest())
            .map { SplashAction.saveUserId($0.id) }
            .subscribe(onSuccess: {
                dispatcher.onNext($0)
            })
            .disposed(by: disposeBag)
    }
}
