//
//  Albums_Result.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 03/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

// MARK: - Albums_Result used when Result is an Array of Albums
struct Albums_Result: Codable {
    let meta: Meta
    let albums: [Album]

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case albums = "result"
    }
}

// MARK: - Album_Result used when Result is a single Album
struct Album_Result: Codable {
    let meta: Single_Meta
    let album: Album

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case album = "result"
    }
}

// MARK: - Album Model
struct Album: Codable {
    let id, userID, title: String
    let links: Post_Links

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title
        case links = "_links"
    }
}
