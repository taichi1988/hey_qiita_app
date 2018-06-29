//
//  UILayoutPriorityExtension.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import SnapKit

func + (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
    return UILayoutPriority(lhs.rawValue + rhs)
}

func - (lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
    return UILayoutPriority(lhs.rawValue - rhs)
}

extension ConstraintMakerEditable {
    @discardableResult
    func priority(_ amount: UILayoutPriority) -> ConstraintMakerFinalizable {
        return priority(amount.rawValue)
    }
}

extension ConstraintViewDSL {
    func makeConstraintsEqualToSuperview(insets: UIEdgeInsets, file: String = #file, line: UInt = #line) {
        makeConstraints { make in
            make.edges.equalToSuperview(file, line).inset(insets)
        }
    }
    
    func makeConstraintsEqualToSuperview(insets: CGFloat = 0, file: String = #file, line: UInt = #line) {
        makeConstraints { make in
            make.edges.equalToSuperview(file, line).inset(insets)
        }
    }
}
