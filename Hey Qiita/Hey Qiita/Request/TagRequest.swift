//
//  TagRequest.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/08.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Alamofire
import ObjectMapper

enum TagRequest: RequestProtocol {
    typealias ResponseType = [Tag]
    
    enum SortType: String {
        case count // 投稿数順
        case name // 名前順
    }
    
    case all(page: Int, sort: SortType)
    case following(userId: String, page: Int)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .all: return APIConstant.tags.path
        case .following(let userId, _): return APIConstant.followingTags(userId: userId).path
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .all(let page, let sort):
            return ["page": page.description,
                    "per_page": "20",
                    "sort": sort.rawValue]
        case .following(_, let page):
            return ["page": page.description,
                    "per_page": "20"]
        }
    }
    
    // TODO: ここで定義するべきじゃない。共通化したい
    func fromJson(_ json: AnyObject) -> Result<[Tag]> {
        if let value: [Tag] = Mapper<Tag>().mapArray(JSONObject: json) {
            return .success(value)
        } else {
            let errorInfo = [NSLocalizedDescriptionKey: "Mapping object failed",
                             NSLocalizedRecoverySuggestionErrorKey: "Rainy days never stay."]
            let error = NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: errorInfo)
            return .failure(error)
        }
    }
}
