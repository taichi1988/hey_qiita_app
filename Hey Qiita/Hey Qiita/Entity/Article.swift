//
//  Article.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import ObjectMapper

struct Article: Mappable {
    var renderedBody: String = ""
    var body: String = ""
    var coediting: Bool = false
    var commentsCount: Int = 0
    var createdAt: Date?
    var group: Group?
    var id: String = ""
    var likesCount: Int = 1
    var isPrivate: Bool = false
    var reactionsCount: Int = 0
    var tags: [ArticleTag] = []
    var title: String = ""
    var updatedAt: Date?
    var url: URL?
    var user: User?
    var pageViewsCount: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        renderedBody <- map["rendered_body"]
        body <- map["body"]
        coediting <- map["coediting"]
        commentsCount <- map["comments_count"]
        createdAt <- (map["created_at"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ssxxx"))
        group <- map["group"]
        id <- map["id"]
        likesCount <- map["likes_count"]
        isPrivate <- map["private"]
        reactionsCount <- map["reactions_count"]
        tags <- map["tags"]
        title <- map["title"]
        updatedAt <- (map["updated_at"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ssxxx"))
        url <- (map["url"], URLTransform())
        user <- map["user"]
        pageViewsCount <- map["page_views_count"]
    }
}

struct ArticleTag: Mappable {
    var name: String = ""
    var versions: [String] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        versions <- map["versions"]
    }
}
