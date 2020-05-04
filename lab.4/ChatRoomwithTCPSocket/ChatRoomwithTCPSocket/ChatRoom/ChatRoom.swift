//
//  ChatRoom.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

class ChatRoom: NSObject {
    // MARK: Properties
    
    // Use for socket based connection
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    // Store the name of the current user
    var username = ""
    
    // How much data can be sent in a single message
    let maxReadLength = 4096
    
    // MARK: Methods
    func setupNetworkCommunication() {
        // Sockets setup.
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        // Binding sockets.
        // Connect to 'localhost' socket using port '80'.
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "localhost" as CFString, 80, &readStream, &writeStream)
        
        // Init sockets stream.
        self.inputStream = readStream!.takeRetainedValue()
        self.outputStream = writeStream!.takeRetainedValue()
        self.inputStream.schedule(in: .current, forMode: .common)
        self.outputStream.schedule(in: .current, forMode: .common)
        
        // Open sockets stream.
        self.inputStream.open()
        self.outputStream.open()
        
        NSLog("Sockets are opened")
    }
    
    // Communication Protocol
    func joinChat(username: String) {
        // Constructing message.
        let data = "iam:\(username)".data(using: .utf8)!
        
        // Saving username, for future use while in active session.
        self.username = username
        
        // Check if username is valid.
        _ = data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                NSLog("Error Joining Chat \n \(#line)")
                return
            }

            // Join chat room.
            outputStream.write(pointer, maxLength: data.count)
        }
    }
}
