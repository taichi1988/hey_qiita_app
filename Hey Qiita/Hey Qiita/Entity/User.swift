//
//  User.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
    var description: String = ""
    var facebook_id: String = ""
    var followeesCount: Int = 0
    var followersCount: Int = 0
    var githubLoginName: String = ""
    var id: String = ""
    var itemsCount: Int = 0
    var linkedinId = ""
    var location: String = ""
    var name: String = ""
    var organization: String = ""
    var permanentId: Int = 0
    var profileImageUrl: URL?
    var twitterScreenName: String = ""
    var websiteUrl: URL?
    var imageMonthlyUploadLimit: Int = 0
    var imageMonthlyUploadRemaining: Int = 0
    var isTeamOnly: Bool = false
    
    var idWithAtmark: String { return "@\(id)" }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        description <- map["description"]
        facebook_id <- map["facebook_id"]
        followeesCount <- map["followees_count"]
        followersCount <- map["followers_count"]
        githubLoginName <- map["github_login_name"]
        id <- map["id"]
        itemsCount <- map["items_count"]
        linkedinId <- map["linkedin_id"]
        location <- map["location"]
        name <- map["name"]
        organization <- map["organization"]
        permanentId <- map["permanent_id"]
        profileImageUrl <- (map["profile_image_url"], URLTransform())
        twitterScreenName <- map["twitter_screen_name"]
        websiteUrl <- (map["website_url"], URLTransform())
        imageMonthlyUploadLimit <- map["image_monthly_upload_limit"]
        imageMonthlyUploadRemaining <- map["image_monthly_upload_remaining"]
        isTeamOnly <- map["team_only"]
    }
}

