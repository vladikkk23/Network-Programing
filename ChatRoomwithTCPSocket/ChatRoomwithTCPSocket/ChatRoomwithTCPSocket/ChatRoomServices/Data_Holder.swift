//
//  Data_Holder.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 05/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import UIKit

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
    func userJoined(user: User) {
        if !self.users.contains(user) {
            var newUser = user
            // Load user avatar if not current user
            if !user.isCurrentUser {
                let userImage = UIImageView(image: nil)
                userImage.load(imageFromURL: newUser.avatarLink)
                
                newUser.avatar = userImage.image
            }
            
            // Save new user
            self.users.append(newUser)
            
            NSLog("New user joined: \(user.name)")
        } else {
            guard let index = (self.users.firstIndex { (usr) -> Bool in usr.name == user.name }) else { return }
            
            // Update user's avatar
            if self.users[index].avatarLink != user.avatarLink {
                self.users[index].avatarLink = user.avatarLink
                
                let userImage = UIImageView(image: nil)
                userImage.load(imageFromURL: self.users[index].avatarLink)
                
                self.users[index].avatar = userImage.image
            }
            
            NSLog("User joined: \(user.name)")
        }
    }
    
    func messageReceived(newMessage message: Message) {
        NSLog("New message: \(message.content) From: \(message.user.name)")
        
        if !message.user.isCurrentUser {
            var newMessage = message
            
            guard let url = URL(string: newMessage.user.avatarLink) else { return }
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            newMessage.user.avatar = image
                            
                            if !newMessage.content.contains("http") {
                                self.messages.append(newMessage)
                            } else {
                                newMessage.content = "\(newMessage.user.name) Joined"
                                self.messages.append(newMessage)
                            }
                        }
                    }
                }
            }
        } else {
            if !message.content.contains("http") {
                self.messages.append(message)
            } else {
                var newMessage = message
                
                newMessage.content = "\(newMessage.user.name) Joined"
                self.messages.append(newMessage)
            }
        }
    }
}
