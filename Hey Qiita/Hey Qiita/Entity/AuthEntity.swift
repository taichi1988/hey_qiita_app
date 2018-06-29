//
//  Auth.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/28.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import ObjectMapper

struct AuthEntity: Mappable {
    var clientId: String = ""
    var scopes: [String] = []
    var accessToken: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        clientId <- map["client_id"]
        scopes <- map["scopes"]
        accessToken <- map["token"]
    }
}

