//
//  AppConfig.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/26.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

struct AppConfig {
    // APIクライアント特定のためのID
    static let clientId = "c92d8ca3ed2aeef69f5dd800c96fe4f5a9a59a5a"
    // APIクライアント特定のためのSecret Key
    static let clientSecret = "832ec0b9b4411a416fdc0fd8b03265241d46779a"
    // 権限情報
    static let oauthScope = "read_qiita+write_qiita"
    // CSRF対策のための認可後にリダイレクトするURLのクエリに含まれるコード
    static let oauthState = "bb17785d811bb1913ef54b0a7657de780defaa2d"
    // 認証完了後のリダイレクトURL
    static let oauthRedirectUrl = "hey-qiita://mht-code.com"
}
