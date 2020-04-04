//
//  Comments_Result.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 04/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

// MARK: - Comments_Result used when Result is an Array of Comments
struct Comments_Result: Codable {
    let meta: Meta
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case comments = "result"
    }
}

// MARK: - Comments_Result used when Result a single Comment
struct Comment_Result: Codable {
    let meta: Single_Meta
    let comment: Comment

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case comment = "result"
    }
}

// MARK: - Comment Model
struct Comment: Codable {
    let id, postID, name, email: String
    let body: String
    let links: Post_Links

    enum CodingKeys: String, CodingKey {
        case id
        case postID = "post_id"
        case name, email, body
        case links = "_links"
    }
}
