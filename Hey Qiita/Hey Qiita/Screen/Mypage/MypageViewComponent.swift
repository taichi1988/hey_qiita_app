//
//  MypageViewComponent.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/06.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit

/// Mypage components
extension MypageViewController {
    //MARK: - User info header view
    final class HeaderView: UIView {
        private lazy var userImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.setCorner(radius: 35)
            return imageView
        }()
        private lazy var userNameLabel: UILabel = {
            let label = UILabel()
            label.text = " " // for layout
            label.font = .boldSystemFont(ofSize: 18)
            label.textColor = .darkText
            return label
        }()
        private lazy var countViewsStackView: UIStackView = {
            let subviews = [followerView, followeeView, postView]
            let stackView = UIStackView(arrangedSubviews: subviews)
            stackView.axis = .horizontal
            stackView.spacing = 12
            return stackView
        }()
        private lazy var followerView = CountView(kind: .follower)
        private lazy var followeeView = CountView(kind: .follow)
        private lazy var postView = CountView(kind: .post)
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            initLayout()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func initLayout() {
            backgroundColor = .lightGray
            addSubviews(userImageView, userNameLabel, countViewsStackView)
            userImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(22)
                make.centerX.equalToSuperview()
                make.width.equalTo(70)
                make.height.equalTo(userImageView.snp.width)
            }
            userNameLabel.snp.makeConstraints { make in
                make.top.equalTo(userImageView.snp.bottom).offset(8)
                make.centerX.equalToSuperview()
            }
            countViewsStackView.snp.makeConstraints { make in
                make.top.equalTo(userNameLabel.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview().inset(16)
            }
        }
        
        func set(user: User) {
            userImageView.setImage(with: user.profileImageUrl)
            userNameLabel.text = user.idWithAtmark
            followerView.set(count: user.followersCount)
            followeeView.set(count: user.followeesCount)
            postView.set(count: user.itemsCount)
        }
    }
    
    //MARK: - Kinds of count view
    private final class CountView: UIView {
        enum Kind: String {
            case follower = "Followers"
            case follow = "Follows"
            case post = "Posts"
        }
        
        private lazy var countLabel: UILabel = {
            let label = UILabel()
            label.text = " " // 初期レイアウトのために空スペースをセット
            label.font = .boldSystemFont(ofSize: 14)
            label.textColor = .darkText
            return label
        }()
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12)
            label.textColor = .gray
            return label
        }()
        private lazy var layoutStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [countLabel, titleLabel])
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 2
            return stackView
        }()
        
        init(kind: Kind) {
            super.init(frame: .zero)
            
            titleLabel.text = kind.rawValue
            backgroundColor = .white
            setCorner(radius: 5)
            addSubview(layoutStackView)
            snp.makeConstraints { make in
                make.width.equalTo(65)
                make.height.equalTo(snp.width)
            }
            layoutStackView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func set(count: Int) {
            countLabel.text = count.description
        }
    }
}
