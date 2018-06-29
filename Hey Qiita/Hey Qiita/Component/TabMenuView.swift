//
//  TabMenuView.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Tab menu view
final class TabMenuView: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var focusIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .primary
        return view
    }()
    
    private let disposeBag = DisposeBag()
    private var titles: [String] = []
    private var tabWidth: CGFloat {
        guard titles.isNotEmpty else { return 0 }
        return collectionView.bounds.width / CGFloat(titles.count)
    }
    
    let didTurnPageEvent = PublishSubject<Int>()
    let didTapTabEvent = PublishSubject<Int>()
    let tabHeight: CGFloat = 40
    var currentPage: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayout()
        initObserver()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height: CGFloat = 2
        focusIndicator.frame = CGRect(x: tabWidth * CGFloat(currentPage), y: tabHeight - height, width: tabWidth, height: height)
    }
    
    private func initLayout() {
        addSubviews(collectionView, bottomLine, focusIndicator)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TabCell.self)
        collectionView.snp.makeConstraintsEqualToSuperview()
        bottomLine.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(collectionView)
            make.height.equalTo(1)
        }
    }
    
    private func initObserver() {
        didTurnPageEvent.asDriver(onErrorJustReturn: 0)
            .drive(onNext: { [weak self] in
                self?.changeFocus(on: $0)
            })
            .disposed(by: disposeBag)
    }
    
    private func changeFocus(on page: Int) {
        currentPage = page
        UIView.animate(withDuration: 0.2, animations: {
            self.focusIndicator.frame.origin.x = self.tabWidth * CGFloat(page)
        }, completion: { _ in
            self.collectionView.reloadData()
        })
    }
    
    func set(titles: [String]) {
        self.titles = titles
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource
extension TabMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, as: TabCell.self)
        cell.set(title: titles[indexPath.item])
        cell.isSelected = indexPath.item == currentPage
        return cell
    }
}

// MARK: - UICollectionView Delegate
extension TabMenuView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tabWidth, height: tabHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        changeFocus(on: indexPath.item)
        didTapTabEvent.onNext(indexPath.item)
    }
}

// MARK: - Cell
extension TabMenuView {
    final class TabCell: UICollectionViewCell, CellReusable {
        override var isSelected: Bool {
            get { return super.isSelected }
            set {
                super.isSelected = newValue
                titleLabel.textColor = newValue ? .primary : .gray
            }
        }
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 14)
            label.textColor = .gray
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func set(title: String) {
            titleLabel.text = title
        }
    }
}
