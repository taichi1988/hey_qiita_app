//
//  ArticleRequest.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import Alamofire

struct ArticleRequest: RequestProtocol {
    typealias ResponseType = Article
    
    private let articleId: String
    
    init(articleId: String) {
        self.articleId = articleId
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return APIConstant.item(id: articleId).path
    }
}
