//
//  General.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 02/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

// MARK: - Meta used when Result is an Array
struct Meta: Codable {
    let success: Bool
    let code: Int
    let message: String
    let totalCount, pageCount, currentPage, perPage: Int
    let rateLimit: RateLimit
}

// MARK: - Meta used when Result is a single Object
struct Single_Meta: Codable {
    let success: Bool
    let code: Int
    let message: String
    let rateLimit: RateLimit
}

// MARK: - RateLimit
struct RateLimit: Codable {
    let limit, remaining, reset: Int
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, edit, avatar: Href
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case edit, avatar
    }
}

// MARK: - Links
struct Post_Links: Codable {
    let linksSelf, edit: Href

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case edit
    }
}

// MARK: - Avatar
struct Href: Codable {
    let href: String
}

enum Status: String, Codable {
    case active = "active"
    case inactive = "inactive"
}
