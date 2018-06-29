//
//  Tag.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import ObjectMapper

struct Tag: Mappable {
    var followersCount: Int = 0
    var iconUrl: URL?
    var id: String = ""
    var itemsCount: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        followersCount <- map["followers_count"]
        iconUrl <- (map["icon_url"], URLTransform())
        id <- map["id"]
        itemsCount <- map["items_count"]
    }
}
