//
//  TimelineCell.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

/// タイムライン共通セル
final class TimelineCell: UITableViewCell, CellReusable {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setCorner(radius: 2)
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .darkText
        return label
    }()
    private lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    private lazy var postedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .gray
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
        contentView.addSubviews(userImageView, titleLabel, tagsLabel, postedDateLabel)
        userImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(16)
            make.width.equalTo(userImageView.snp.height)
            make.height.equalTo(60).priority(.required - 1)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(8)
            make.right.equalToSuperview().inset(8)
        }
        tagsLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(userImageView)
        }
        postedDateLabel.snp.makeConstraints { make in
            make.left.equalTo(tagsLabel.snp.right).offset(8)
            make.right.equalTo(titleLabel)
            make.bottom.equalTo(tagsLabel)
        }
    }
    
    func set(article: Article) {
        userImageView.setImage(with: article.user?.profileImageUrl)
        titleLabel.text = article.title
        tagsLabel.text = article.tags.map { $0.name }.joined(separator: " ")
        postedDateLabel.text = article.updatedAt?.yyyyMMdd
    }
}
