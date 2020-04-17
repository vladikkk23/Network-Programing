//
//  User_Result.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 02/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

// MARK: - Users_Result used when Result is an Array of Users
struct Users_Result: Codable {
    let meta: Meta
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case users = "result"
    }
}

// MARK: - User_Result used when Result is a single User
struct User_Result: Codable {
    let meta: Single_Meta
    let user: User

    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case user = "result"
    }
}

// MARK: - User Model
struct User: Codable {
    let id, firstName, lastName: String
    let gender: Gender
    let dob, email, phone: String
    let website: String
    let address: String
    let status: Status
    let links: Links

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case gender, dob, email, phone, website, address, status
        case links = "_links"
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}
