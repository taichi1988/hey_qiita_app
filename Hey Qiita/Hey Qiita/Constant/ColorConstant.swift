//
//  ColorConstant.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/05.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00ff00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000ff) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

// MARK: - Color Constants
extension UIColor {
    static var primary: UIColor { return UIColor(hex: 0x54C501) }
    static var lightGray: UIColor { return UIColor(hex: 0xEBEBEB) }
}
