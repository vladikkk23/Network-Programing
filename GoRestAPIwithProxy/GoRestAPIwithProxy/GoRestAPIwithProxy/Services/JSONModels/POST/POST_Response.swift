//
//  General.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 07/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

// MARK: - Response returned when a POST Request was made
struct POST_Response: Codable {
    let meta: POST_Response_Meta
    let result: Response_Body
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
}

// MARK: - Response returned when a POST Request was made
struct POST_Resp: Codable {
    let meta: Single_Meta
    let result: [POST_Warning]
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
}

// MARK: - Meta
struct POST_Response_Meta: Codable {
    let success: Bool
    let code: Int
    let message: String
}

// MARK: - Body
struct Response_Body: Codable {
    let name, message: String
    let code, status: Int
}

struct POST_Warning: Codable {
    let field: String
    let message: String
}
