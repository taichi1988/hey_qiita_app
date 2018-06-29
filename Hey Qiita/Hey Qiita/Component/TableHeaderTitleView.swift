//
//  TableHeaderTitleView.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

// MARK: -
final class TableHeaderTitleView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        label.textColor = .darkText
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16).priority(.required - 1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
