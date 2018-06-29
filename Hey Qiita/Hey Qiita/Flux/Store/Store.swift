//
//  Store.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/04.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

protocol StoreProtocol {
    associatedtype State
    var disposeBag: DisposeBag { get set }
    var state: State { get set }
    func reducer(action: Action, state: State)
}

protocol StateType {
    init()
}

// MARK: - Store
class Store<State: StateType>: StoreProtocol {
    var disposeBag: DisposeBag = DisposeBag()
    var state: State = State()
    func reducer(action: Action, state: State) {
        fatalError("must call reducer from successor")
    }
    
    init() {
        dispatcher
            .asObserver()
            .subscribe(
                onNext: { [weak self] in
                    guard let me = self else { return }
                    me.reducer(action: $0, state: me.state)
                },
                onError: { error in
                    print(error.localizedDescription) // TODO:
                })
            .disposed(by: disposeBag)
    }
}
