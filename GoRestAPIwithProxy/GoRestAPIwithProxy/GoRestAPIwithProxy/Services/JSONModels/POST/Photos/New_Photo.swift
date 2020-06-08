//
//  New_Photo.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 10/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

struct New_Photo: Codable {
    let albumID, title, url, thumb: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case title, url
        case thumb = "thumbnail"
    }
}
