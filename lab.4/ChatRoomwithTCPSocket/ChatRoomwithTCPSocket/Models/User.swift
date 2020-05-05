//
//  User.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import UIKit

struct User: Hashable {
    var name: String
    var avatar: UIImage?
    var avatarLink = ""
    var isCurrentUser: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
