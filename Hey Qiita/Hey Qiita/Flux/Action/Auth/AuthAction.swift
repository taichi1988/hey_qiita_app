//
//  AuthAction.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/28.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

// MARK: - Action
enum AuthAction: Action {
    case succeedSaveAccessToken
    case faildSaveAccessToken
    case dismissed
    case catchError(Error)
}

// MARK: - ActionCreator
final class AuthActionCreator {
    private let disposeBag = DisposeBag()
    
    func requestAccessToken(by code: String?) {
        guard let code = code else { return }
        
        dispatcher.onNext(LoadingAction.updateStatus(.initFetching))
        
        ApiClient.request(AuthRequest(code: code))
            .do(onSuccess: { KeychainUtil.accessToken = $0.accessToken })
            .map { auth -> AuthAction in AuthAction.succeedSaveAccessToken }
            .subscribe(
                onSuccess: {
                    dispatcher.onNext($0)
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                },
                onError: {
                    dispatcher.onNext(AuthAction.faildSaveAccessToken)
                    dispatcher.onNext(AuthAction.catchError($0))
                    dispatcher.onNext(LoadingAction.updateStatus(.updated))
                })
            .disposed(by: disposeBag)
    }
    
    func dismissed() {
        dispatcher.onNext(AuthAction.dismissed)
    }
}
