//
//  Group.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import ObjectMapper

struct Group: Mappable {
    var createdAt: Date?
    var id: Int = 0
    var name: String = ""
    var isPrivate: Bool = false
    var updatedAt: Date?
    var urlName: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        createdAt <- (map["created_at"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ssxxx"))
        id <- map["id"]
        name <- map["name"]
        isPrivate <- map["private"]
        updatedAt <- (map["updated_at"], CustomDateFormatTransform(formatString: "yyyy-MM-dd'T'HH:mm:ssxxx"))
        urlName <- map["url_name"]
    }
}
