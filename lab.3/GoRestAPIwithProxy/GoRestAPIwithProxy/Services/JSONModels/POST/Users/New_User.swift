//
//  New_User.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 07/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

struct New_User: Codable {
    let email, first_name, last_name: String
    let gender: Gender
    let dob: Date
    let phone: String
    let website: Href
    let address: String
    let status: Status
}
