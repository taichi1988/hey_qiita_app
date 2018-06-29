//
//  UserRequest.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/11.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Alamofire

struct UserRequest: RequestProtocol {
    typealias ResponseType = User
    
    var path: String {
        return APIConstant.authenticatedUser.path
    }
    
    var method: HTTPMethod {
        return .get
    }
}
