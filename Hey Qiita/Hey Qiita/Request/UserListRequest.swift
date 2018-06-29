//
//  UserListRequest.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/06/14.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Alamofire
import ObjectMapper

struct UserListRequest: RequestProtocol {
    typealias ResponseType = [User]
    
    private let userId: String
    private let page: Int
    private let perPage: Int
    
    init(userId: String, page: Int = 1, perPage: Int = 20) {
        self.userId = userId
        self.page = page
        self.perPage = perPage
    }
    
    var path: String {
        return APIConstant.followees(userId: userId).path
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        return ["page": page.description,
                "per_page": perPage.description]
    }
    
    // TODO: ここで定義するべきじゃない。共通化したい
    func fromJson(_ json: AnyObject) -> Result<[User]> {
        if let value: [User] = Mapper<User>().mapArray(JSONObject: json) {
            return .success(value)
        } else {
            let errorInfo = [NSLocalizedDescriptionKey: "Mapping object failed",
                             NSLocalizedRecoverySuggestionErrorKey: "Rainy days never stay."]
            let error = NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: errorInfo)
            return .failure(error)
        }
    }
}

