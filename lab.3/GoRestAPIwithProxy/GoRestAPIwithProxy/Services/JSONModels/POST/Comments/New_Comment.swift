//
//  New_Comment.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 10/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

struct New_Comment: Codable {
    let postID, name, email, body: String
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case name, email, body
    }
}
