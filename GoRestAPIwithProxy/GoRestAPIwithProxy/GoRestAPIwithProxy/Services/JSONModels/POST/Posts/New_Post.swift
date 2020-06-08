//
//  New_Post.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 07/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

struct New_Post: Codable {
    let userID, title, body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case title, body
    }
}
