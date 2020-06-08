//
//  ChatRoom.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 05/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import UIKit

class ChatRoom: NSObject {
    
    // MARK: Properties
    static let shared = ChatRoom()
    
    private let dataHolder = Data_Holder.shared
    
    // Set connection config
    private var hostname = "192.168.0.47" as CFString
    private var port: UInt32 = 8080
    
    // Streams
    private var inputStream: InputStream!
    private var outputStream: OutputStream!
    
    // Current username
    private var username = ""
    private var avatarURL = ""
    
    // How much data can be sent in a single message
    private var maxReadLength = 4096
    
    private override init() {}
    
    // MARK: Methods
    func setupNetworkConnection() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, self.hostname, self.port, &readStream, &writeStream)
        
        self.inputStream = readStream?.takeRetainedValue()
        self.outputStream = writeStream?.takeRetainedValue()
        
        self.inputStream?.delegate = self
        self.outputStream?.delegate = self
        
        self.inputStream.schedule(in: .current, forMode: .common)
        self.outputStream.schedule(in: .current, forMode: .common)
        
        self.inputStream?.open()
        self.outputStream?.open()
    }
    
    // MARK: Client-Server Communication Protocol -> 'Joining Server'
    func joinChat(user: User) {
        // Connect to server
        let data = "username>\(user.name)>avatarURL>\(user.avatarLink)".data(using: .utf8)!
        
        self.username = user.name
        
        _ = data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                NSLog("Error joining chat")
                return
            }
            
            outputStream.write(pointer, maxLength: data.count)
            self.dataHolder.userJoined(user: user)
        }
    }
    
    // MARK: Client-Server Communication Protocol -> 'Sending a Message'
    func sendMessage(message: String) {
        let data = "message>\(message)".data(using: .utf8)!
        
        _ = data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                NSLog("Error sending message")
                return
            }
            
            outputStream.write(pointer, maxLength: data.count)
        }
    }
    
    // Close session
    func stopChatSession() {
        if let stream = self.inputStream {
            stream.close();
            stream.remove(from: .current, forMode: .common)
        }
        
        if let stream = self.outputStream {
            stream.close();
            stream.remove(from: .current, forMode: .common)
        }
        
        self.inputStream = nil;
        self.outputStream = nil;
    }
}

// Conform to stream delegate
extension ChatRoom: StreamDelegate {
    
    // MARK: Server-Client Communication Protocol -> 'Handling Message Types'
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
            NSLog("New message received")
            self.readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            NSLog("Connection closed")
            self.stopChatSession()
        case .errorOccurred:
            NSLog("Error occurred")
            self.stopChatSession()
        case .hasSpaceAvailable:
            NSLog("Has space available")
        default:
            NSLog("Some other event...")
        }
    }
    
    // MARK: Server-Client Communication Protocol -> 'Receiving a Message'
    private func readAvailableBytes(stream: InputStream) {
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: self.maxReadLength)
        
        while stream.hasBytesAvailable {
            let bytes = self.inputStream.read(buffer, maxLength: self.maxReadLength)
            
            if bytes < 0, let error = stream.streamError {
                NSLog(error.localizedDescription)
                break
            }
            
            NSLog("Reading \(bytes.description) bytes")
            
            if let message = self.getMessageAsString(buffer: buffer, length: bytes) {
                self.dataHolder.messageReceived(newMessage: message)
            }
        }
    }
    
    private func getMessageAsString(buffer: UnsafeMutablePointer<UInt8>, length: Int) -> Message? {
        guard let stringArray = String(bytesNoCopy: buffer, length: length, encoding: .utf8, freeWhenDone: true)?.components(separatedBy: "|") else { return nil }
        
        guard let senderName = stringArray.first?.components(separatedBy: " ").first else { return nil }
        guard var messageContent = stringArray.last?.withoutWhitespace() else { return nil }
        
        if stringArray.first!.contains("Joined") {
            if messageContent == " " {
                messageContent = "\(senderName) Joined"
            } else if messageContent.contains("http") {
                messageContent.removeFirst()
                self.avatarURL = messageContent
            }
        }
        
        if senderName.isEmpty || messageContent.isEmpty {
            return nil
        }
        
        // Check if sender is a new User
        if let sender = self.dataHolder.users.first(where: { (user) -> Bool in
            user.name == senderName
        }) {
            let message = Message(content: messageContent, user: sender)
            
            return message
        } else {
            let sender = User(name: senderName, avatarLink: self.avatarURL, isCurrentUser: (senderName == self.username ? true : false))
            
            let message = Message(content: messageContent, user: sender)
            
            return message
        }
    }
}
