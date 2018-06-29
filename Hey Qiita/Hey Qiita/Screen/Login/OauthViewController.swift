//
//  OauthViewController.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/25.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

/// Qiita認証WebView
final class OauthViewController: UIViewController {
    private lazy var webView = WKWebView()
    private let loadingIndicator = LoadingIndicator()
    private let disposeBag = DisposeBag()
    private let action = AuthActionCreator()
    private let loadingStore = LoadingStore()
    private let store = AuthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        initObserver()
        loadWebView()
    }
    
    private func initLayout() {
        title = "Authorization"
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.snp.makeConstraintsEqualToSuperview()
    }
    
    private func initObserver() {
        // observe isSucceedSaveAccessToken
        store.state.isSucceedSaveAccessToken
            .skip(1)
            .filter { $0 }
            .asSignal(onErrorJustReturn: false)
            .emit(onNext: { [weak self] _ in
                self?.dismiss(animated: true) { [weak self] in
                    self?.action.dismissed()
                }
            })
            .disposed(by: disposeBag)
        
        // observe loading
        loadingStore.state.loadStatus
            .asObservable()
            .subscribe(onNext: { [weak self] in
                switch $0 {
                case .initFetching: self?.loadingIndicator.show()
                case .updated: self?.loadingIndicator.dismiss()
                default: break
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func loadWebView() {
        let url = URL(string: APIConstant.baseUrl + APIConstant.auth.path)!
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: nil != url.baseURL) else { return }
        components.queryItems = [URLQueryItem(name: "client_id", value: AppConfig.clientId),
                                 URLQueryItem(name: "scope", value: AppConfig.oauthScope),
                                 URLQueryItem(name: "state", value: AppConfig.oauthState)]
        webView.load(URLRequest(url: components.url!))
    }
}

// MARK: - WKNavigationDelegate
extension OauthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        let code = webView.url?.queryParameters["code"]
        action.requestAccessToken(by: code)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        loadingIndicator.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIndicator.dismiss()
    }
}
