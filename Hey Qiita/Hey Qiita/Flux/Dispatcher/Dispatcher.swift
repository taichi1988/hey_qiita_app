//
//  Dispatcher.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/04.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import RxSwift

public let dispatcher: PublishSubject<Action> = PublishSubject<Action>()
