//
//  ArticleDetailViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/11.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import Down

/// 記事詳細画面
final class ArticleDetailViewController: UIViewController {
    private lazy var markdownView = try? DownView(frame: .zero, markdownString: "")
    private lazy var headerView = ArticleDetailHeaderView()
    private let loadingIndicator = LoadingIndicator()
    private let article: Article
    private let disposeBag = DisposeBag()

    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
        
        headerView.set(article: article)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        initObserver()
        loadMarkdown()
    }
    
    private func initLayout() {
        view.addSubview(markdownView ?? UIView())
        markdownView?.snp.makeConstraintsEqualToSuperview()
        markdownView?.scrollView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalTo(view)
        }
    }
    
    private func initObserver() {
        headerView.updatedViewRectEvent
            .take(1)
            .map { $0.height }
            .subscribe(onNext: { [weak self] in
                self?.updateLayout(by: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func updateLayout(by height: CGFloat) {
        markdownView?.scrollView.contentInset.top = height
        headerView.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(-Float(height))
            make.left.right.equalTo(self.view)
        }
    }
    
    private func loadMarkdown() {
        loadingIndicator.show()
        try? markdownView?.update(markdownString: article.body, didLoadSuccessfully: { [weak self] in
            self?.loadingIndicator.dismiss()
        })
    }
}

// MARK: - Header view
private final class ArticleDetailHeaderView: UIView {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setCorner(radius: 3)
        return imageView
    }()
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .darkText
        return label
    }()
    private lazy var postedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
        return label
    }()
    private lazy var tagsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let updatedViewRectEvent = PublishSubject<CGRect>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updatedViewRectEvent.onNext(frame)
    }
    
    private func initLayout() {
        backgroundColor = .lightGray
        addSubviews(userImageView, userNameLabel,
                    postedDateLabel, titleLabel, tagsStackView)
        userImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16)
            make.width.equalTo(30)
            make.height.equalTo(userImageView.snp.width)
        }
        userNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(8)
        }
        postedDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userNameLabel)
            make.right.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
        }
        tagsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.left.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func makeTagButton() -> UIButton {
        let button = UIButton()
        button.setCorner(radius: 3)
        button.backgroundColor = .white
        button.setTitleColor(.darkText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 5, bottom: 3, right: 5)
        button.addTarget(self, action: #selector(tagTapped(_:)), for: .touchUpInside)
        return button
    }
    
    @objc
    private func tagTapped(_ sender: UIButton) {
        //TODO: tag tap action
    }
    
    func set(article: Article) {
        userImageView.setImage(with: article.user?.profileImageUrl)
        userNameLabel.text = article.user?.idWithAtmark ?? ""
        postedDateLabel.text = article.updatedAt?.yyyyMMdd
        titleLabel.text = article.title
        article.tags.forEach {
            let button = makeTagButton()
            button.setTitle($0.name, for: .normal)
            button.sizeToFit()
            self.tagsStackView.addArrangedSubview(button)
        }
    }
}
