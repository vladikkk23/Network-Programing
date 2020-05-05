//
//  ChatRoom.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 05/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

class ChatRoom: NSObject {
    // MARK: Properties
    
    static let shared = ChatRoom()
    
    // Streams
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    // Current username
    var username = ""
    
    // How much data can be sent in a single message
    var maxReadLength = 4096
    
    private override init() {}
    
    // MARK: Methods
    
}
