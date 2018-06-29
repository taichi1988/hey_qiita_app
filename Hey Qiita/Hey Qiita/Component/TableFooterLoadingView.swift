//
//  TableFooterLoadingView.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/09.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

// MARK: -
final class TableFooterLoadingView: UIView {
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.top.bottom.centerX.equalToSuperview()
            make.height.equalTo(50).priority(.required - 1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoadingAnimation() {
        loadingIndicator.startAnimating()
    }
    
    func stopLoadingAnimation() {
        loadingIndicator.stopAnimating()
    }
}
