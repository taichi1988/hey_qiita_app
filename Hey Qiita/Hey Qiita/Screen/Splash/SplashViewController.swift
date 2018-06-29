//
//  SplashViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/30.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// スプラッシュ画面
final class SplashViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey Qiita"
        label.textColor = .primary
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 70)
        return label
    }()
    
    private let disposeBag = DisposeBag()
    private let action = SplashActionCreator()
    private let store = SplashStore()
    private var isLoggedin: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        initObserver()
        action.checkAccessToken()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        transitLoginViewIfNeeded()
    }
    
    private func initLayout() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func initObserver() {
        // observe is logged in
        store.state.isLoggedin
            .do(onNext: { [weak self] in self?.isLoggedin = $0 })
            .filter { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.action.fetchUser()
            })
            .disposed(by: disposeBag)
        
        // observe did save user id event
        let didSaveUserIdEvent = store.state.didSaveUserIdEvent
            .asDriver(onErrorJustReturn: ())
        // x秒以上遅延させてから画面遷移を実行
        Driver.zip(Driver.just(()).delay(2), didSaveUserIdEvent) {_, _ in }
            .drive(onNext: { [weak self] _ in
                self?.transitMainView()
            })
            .disposed(by: disposeBag)
    }
    
    private func transitLoginViewIfNeeded() {
        guard !isLoggedin else { return }
        let vc = LoginViewController()
        appDelegate().replaceRootViewController(to: vc, animated: false)
    }
    
    private func transitMainView() {
        let vc = MainViewController()
        appDelegate().replaceRootViewController(to: vc)
    }
}
