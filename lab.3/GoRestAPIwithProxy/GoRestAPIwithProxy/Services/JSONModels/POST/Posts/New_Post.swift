//
//  New_Post.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 07/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

struct New_Post: Codable {
    let id, userID, title, body: String
    let links: Post_Links
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, body
        case links = "_links"
    }
}
