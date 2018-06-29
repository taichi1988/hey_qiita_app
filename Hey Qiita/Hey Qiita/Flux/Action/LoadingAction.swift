//
//  LoadingAction.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

// MARK: - Loading Action
enum LoadingAction: Action {
    case updateStatus(LoadingState.Status)
}
