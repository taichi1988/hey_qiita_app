//
//  TagCell.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/13.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

final class TagCell: UITableViewCell, CellReusable {
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        contentView.addSubviews(iconImageView, titleLabel)
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(iconImageView.snp.height)
            make.height.equalTo(34).priority(.required - 1)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(16)
            make.centerY.equalTo(iconImageView)
        }
    }
    
    func set(tag: Tag) {
        titleLabel.text = tag.id
        iconImageView.setImage(with: tag.iconUrl)
    }
}
