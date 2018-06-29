//
//  MypageActiion.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/09.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

// MARK: - Actions
enum MypageAction: Action {
    case fetchedUser(User)
    case fetchedStockList([Article])
    case fetchedFollowingTags([Tag])
    case fetchedFollowees([User])
    case catchError(Error)
}

// MARK: - ActionCreator
final class MypageActionCreator {
    private let disposeBag: DisposeBag = DisposeBag()
    private var userId: String { return UserDefaults.userId ?? "" }
    
    func fetchUser() {
        dispatcher.onNext(LoadingAction.updateStatus(.initFetching))
        
        ApiClient.request(UserRequest())
            .map { MypageAction.fetchedUser($0) }
            .subscribe(onSuccess: {
                dispatcher.onNext($0)
                dispatcher.onNext(LoadingAction.updateStatus(.updated))
            }, onError: {
                dispatcher.onNext(MypageAction.catchError($0))
                dispatcher.onNext(LoadingAction.updateStatus(.updated))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchStockList() {
        dispatcher.onNext(LoadingAction.updateStatus(.initFetching))
        
        ApiClient.request(ArticleListRequest.fetchStocks(userId: userId, page: 1))
            .map { MypageAction.fetchedStockList($0) }
            .subscribe(onSuccess: {
                dispatcher.onNext($0)
                dispatcher.onNext(LoadingAction.updateStatus(.updated))
            }, onError: {
                dispatcher.onNext(MypageAction.catchError($0))
                dispatcher.onNext(LoadingAction.updateStatus(.updated))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchFollowingTags() {
        dispatcher.onNext(LoadingAction.updateStatus(.initFetching))
        
        ApiClient.request(TagRequest.following(userId: userId, page: 1))
            .map { MypageAction.fetchedFollowingTags($0) }
            .subscribe(onSuccess: {
                dispatcher.onNext($0)
                dispatcher.onNext(LoadingAction.updateStatus(.updated))
            }, onError: {
                dispatcher.onNext(MypageAction.catchError($0))
                dispatcher.onNext(LoadingAction.updateStatus(.updated))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchFollowees() {
        dispatcher.onNext(LoadingAction.updateStatus(.initFetching))
        
        ApiClient.request(UserListRequest(userId: userId))
            .map { MypageAction.fetchedFollowees($0) }
            .subscribe(onSuccess: {
                dispatcher.onNext($0)
                dispatcher.onNext(LoadingAction.updateStatus(.updated))
            }, onError: {
                dispatcher.onNext(MypageAction.catchError($0))
                dispatcher.onNext(LoadingAction.updateStatus(.updated))
            })
            .disposed(by: disposeBag)
    }
}
