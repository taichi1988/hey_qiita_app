//
//  ArticleListRequest.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Alamofire
import ObjectMapper

enum ArticleListRequest: RequestProtocol {
    typealias ResponseType = [Article]
    
    case fetchAll(page: Int)
    case searchByWord(page: Int, query: String)
    case searchByTag(id: String, page: Int)
    case fetchStocks(userId: String, page: Int)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .fetchAll, .searchByWord: return APIConstant.items.path
        case .searchByTag(let id, _): return APIConstant.searchByTag(id: id).path
        case .fetchStocks(let userId, _): return APIConstant.stocks(id: userId).path
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchAll(let page):
            return ["page": page.description,
                    "per_page": "20"]
        case .searchByWord(let page, let query):
            return ["page": page.description,
                    "per_page": "20",
                    "query": query]
        case .searchByTag(_, let page):
            return ["page": page.description,
                    "per_page": "20"]
        case .fetchStocks(_, page: let page):
            return ["page": page.description,
                    "per_page": "20"]
        }
    }
    
    // TODO: ここで定義するべきじゃない。共通化したい
    func fromJson(_ json: AnyObject) -> Result<[Article]> {
        if let value: [Article] = Mapper<Article>().mapArray(JSONObject: json) {
            return .success(value)
        } else {
            let errorInfo = [NSLocalizedDescriptionKey: "Mapping object failed",
                             NSLocalizedRecoverySuggestionErrorKey: "Rainy days never stay."]
            let error = NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: errorInfo)
            return .failure(error)
        }
    }
}
