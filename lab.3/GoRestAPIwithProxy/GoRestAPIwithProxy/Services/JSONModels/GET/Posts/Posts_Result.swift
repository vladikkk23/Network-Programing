//
//  Posts_Result.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 03/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

// MARK: - Posts_Result used when Result is an Array of Posts
struct Posts_Result: Codable {
    let meta: Meta
    let posts: [Post]
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case posts = "result"
    }
}

// MARK: - Post_Result used when Result is a single Post
struct Post_Result: Codable {
    let meta: Single_Meta
    let post: Post
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case post = "result"
    }
}

// MARK: - Post Model
struct Post: Codable {
    let id, userID, title, body: String
    let links: Post_Links
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, body
        case links = "_links"
    }
}
