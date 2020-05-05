//
//  Message.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

struct Message: Hashable {
    var content: String
    var user: User
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(content)
    }
}
