//
//  APIConstant.swift
//  Hey Qiita
//
//  Created by 行木太一 on 2018/05/03.
//  Copyright © 2018年 ManhattanCode.Inc. All rights reserved.
//
import Alamofire

enum APIConstant {
    // MARK: - API Base URL
    static let baseUrl = "https://qiita.com/api/v2"
    
    // MARK: - case
    case auth
    case accessToken
    case authenticatedUser
    case items
    case item(id: String)
    case users
    case stocks(id: String)
    case followingTags(userId: String)
    case followees(userId: String)
    case tags
    case searchByTag(id: String)
    
    // MARK: - API Path
    var path: String {
        switch self {
        case .auth: return "/oauth/authorize"
        case .accessToken: return "/access_tokens"
        case .authenticatedUser: return "/authenticated_user"
        case .items: return "/items"
        case .item(let id): return "/items/\(id)"
        case .users: return "/users"
        case .stocks(let id): return "/users/\(id)/stocks"
        case .followingTags(let userId): return "/users/\(userId)/following_tags"
        case .followees(let userId): return "/users/\(userId)/followees"
        case .tags: return "/tags"
        case .searchByTag(let id): return "/tags/\(id)/items"
        }
    }
}
