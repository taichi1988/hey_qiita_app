//
//  AuthRequest.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/28.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Alamofire

struct AuthRequest: RequestProtocol {
    typealias ResponseType = AuthEntity
    
    private let clientId: String
    private let clientSecret: String
    private let code: String
    
    init(code: String) {
        self.code = code
        self.clientId = AppConfig.clientId
        self.clientSecret = AppConfig.clientSecret
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        return APIConstant.accessToken.path
    }
    
    var parameters: Parameters? {
        return ["client_id": clientId,
                "client_secret": clientSecret,
                "code": code]

    }
}
