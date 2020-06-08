//
//  New_Album.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 10/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

struct New_Album: Codable {
    let userID, title: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case title
    }
}
