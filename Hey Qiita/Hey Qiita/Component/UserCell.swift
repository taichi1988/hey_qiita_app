//
//  UserCell.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/14.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

final class UserCell: UITableViewCell, CellReusable {
    private lazy var userImageView = UIImageView()
    private lazy var userNameLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        contentView.addSubviews(userImageView, userNameLabel, descriptionLabel)
        
        userImageView.setCorner(radius: 2)
        userNameLabel.font = .boldSystemFont(ofSize: 18)
        userNameLabel.textColor = .darkText
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textColor = .gray
        
        userImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualToSuperview().inset(16)
            make.width.equalTo(userImageView.snp.height)
            make.height.equalTo(60).priority(.required - 1)
        }
        userNameLabel.setContentHuggingPriority(.required - 1, for: .vertical)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(8)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.left.equalTo(userNameLabel)
            make.right.bottom.equalToSuperview().inset(16)
        }
    }
    
    func set(user: User) {
        userImageView.setImage(with: user.profileImageUrl)
        userNameLabel.text = user.idWithAtmark
        descriptionLabel.text = user.description
    }
}
