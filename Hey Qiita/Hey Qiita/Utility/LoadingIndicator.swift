//
//  LoadingIndicator.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/07.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import KRProgressHUD
import KRActivityIndicatorView

final class LoadingIndicator {
    private let indicatorStyle: KRActivityIndicatorViewStyle
    
    init() {
        indicatorStyle = .gradationColor(head: .primary, tail: .lightGray)
    }
    
    // MARK: - show indicator
    func show(message: String? = nil, completion: (() -> Void)? = nil) {
        KRProgressHUD
            .set(activityIndicatorViewStyle: indicatorStyle)
            .show(withMessage: message ?? "Loading...", completion: completion)
    }
    
    // MARK: - dismiss indicator
    func dismiss(completion: (() -> Void)? = nil) {
        KRProgressHUD.dismiss(completion)
    }
}
