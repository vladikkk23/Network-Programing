//
//  Photos_Result.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 04/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

// MARK: - Photos_Result used when Result is an Array of Photos
struct Photos_Result: Codable {
    let meta: Meta
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case photos = "result"
    }
}

// MARK: - Photo_Result used when Result a single Photo
struct Photo_Result: Codable {
    let meta: Single_Meta
    let photo: Photo

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case photo = "result"
    }
}

// MARK: - Photo Model
struct Photo: Codable,Identifiable, Hashable {
    let id, albumID, title: String
    let url, thumbnail: String
    let links: Post_Links
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case title, url, thumbnail
        case links = "_links"
    }
}
