//
//  LoginViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/25.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// ログイン画面
final class LoginViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey Qiita"
        label.textColor = .primary
        label.font = UIFont(name: "HelveticaNeue-UltraLight", size: 70)
        return label
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 24)
        button.setCorner(radius: 5)
        button.setBorder(width: 0.7, color: .primary)
        return button
    }()
    private lazy var laterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Later", for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        return button
    }()
    
    private let disposeBag = DisposeBag()
    private let store = AuthStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        initLayout()
        initObservar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTitleAnimation()
    }
    
    private func initLayout() {
        view.backgroundColor = .white
        view.addSubviews(titleLabel, loginButton, laterButton)
        loginButton.alpha = 0
        laterButton.alpha = 0
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(80)
            make.width.equalTo(90)
            make.height.equalTo(50)
        }
        laterButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
    
    private func initObservar() {
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.presentAuthView()
            })
            .disposed(by: disposeBag)
        
        laterButton.rx.tap
            .subscribe(onNext: {
                appDelegate().replaceRootViewController(to: MainViewController())
            })
            .disposed(by: disposeBag)
        
        store.state.dismissedEvent
            .asSignal(onErrorJustReturn: ())
            .emit(onNext: {
                appDelegate().replaceRootViewController(to: MainViewController())
            })
            .disposed(by: disposeBag)
    }
    
    private func startTitleAnimation() {
        UIView.animate(withDuration: 1.5, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -80)
        }, completion: { _ in
            UIView.animate(withDuration: 0.7, animations: {
                self.loginButton.alpha = 1
                self.laterButton.alpha = 1
            })
        })
    }
    
    private func presentAuthView() {
        let vc = UINavigationController(rootViewController: OauthViewController())
        present(vc, animated: true, completion: nil)
    }
}
