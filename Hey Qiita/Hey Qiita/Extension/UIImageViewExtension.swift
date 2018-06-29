//
//  UIImageViewExtension.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        guard let url = url else { return }
        af_setImage(withURL: url, placeholderImage: placeholder, imageTransition: .crossDissolve(0.2))
    }
}

extension UIButton {
    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        guard let url = url else { return }
        af_setImage(for: .normal, url: url)
    }
}
