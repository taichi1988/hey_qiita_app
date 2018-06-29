//
//  SearchViewComponent.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Components
extension SearchViewController {
    // MARK: -
    final class FreeFormCell: UITableViewCell, CellReusable {
        private let textField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Search words"
            textField.textColor = .darkText
            textField.borderStyle = .roundedRect
            textField.returnKeyType = .search
            return textField
        }()
        
        private var returnKeyAction: ((String) -> Void)?
        private let disposeBag = DisposeBag()
        
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            initLayout()
            initObserver()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func initLayout() {
            selectionStyle = .none
            contentView.addSubview(textField)
            textField.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.top.bottom.equalToSuperview().inset(8)
            }
        }
        
        private func initObserver() {
            textField.rx.controlEvent(.editingDidEndOnExit)
                .subscribe(onNext: { [weak self] in
                    guard let text = self?.textField.text else { return }
                    self?.returnKeyAction?(text)
                })
                .disposed(by: disposeBag)
        }
        
        func setReturnKeyAction(action: @escaping (String) -> Void) {
            returnKeyAction = action
        }
    }
}
