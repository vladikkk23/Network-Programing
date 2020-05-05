//
//  Data_Holder.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 05/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

class Data_Holder: ObservableObject {
    
    // MARK: Properties
    static let shared = Data_Holder()
    
    // Messages store
    @Published var messages = [Message]()
    @Published var users = [User]()
    
    private var userAvatars = ["" : ""]
    private var userTypes = ["" : Bool()]
    
    private init() {}
    
    // MARK: Methods
    func newUserJoined(user: User) {
        if !self.users.contains(user) {
            // Save new user
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                var newUser = user
                
                newUser.avatarLink = ImageUploader.shared.imageURL
                self.users.append(newUser)
                //                self.saveUserInfo(user: newUser)
            }
            NSLog("New user joined: \(user.name)")
        } else {
            // Update user
            guard let index = (self.users.firstIndex { (usr) -> Bool in usr.name == user.name }) else { return }
            
            self.users[index].avatarLink = user.avatarLink
            
            NSLog("User joined: \(user.name)")
        }
    }
    
    func messageReceived(newMessage message: Message) {
        NSLog("New message: \(message.content) From: \(message.user.name)")
        
        let user = message.user
        
        if !self.users.contains(user) {
            self.users.append(user)
        }
        
        self.messages.append(message)
    }
    
    private func saveUserInfo(user: User) {
        self.saveUserType(user: user)
        self.saveUserAvatar(user: user)
    }
    
    private func saveUserAvatar(user: User) {
        self.userAvatars["\(user.name)-Avatar"] = user.avatarLink
    }
    
    private func saveUserType(user: User) {
        self.userTypes["\(user.name)-Type"] = user.isCurrentUser
    }
}
