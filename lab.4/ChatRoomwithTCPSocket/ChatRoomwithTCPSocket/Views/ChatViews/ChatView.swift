//
//  ChatView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    let messages = [Message(content: "Hello, Dog!", user: User(name: "Cat", avatar: "Cat-Avatar", isCurrentUser: true)),
                    Message(content: "What, do u want Cat?", user: User(name: "Dog", avatar: "Dog-Avatar", isCurrentUser: false))]
    
    let chatRoom = ChatRoom()
    
    @State var typingMessage = ""
    @Environment(\.presentationMode) var presentationMode
    @Binding var username: String
    
    var body: some View {
        VStack {
            TopBarView(presentationMode: self.presentationMode, typingMessage: self.$typingMessage)
            
            Divider()
            
            List {
                ForEach(self.messages, id: \.self) { message in
                    MessageView(currentMessage: message)
                }
            }
            
            Divider()
            
            BottomBarView(typingMessage: self.$typingMessage)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .keyboardAdaptive()
        .onAppear {
            self.chatRoom.setupNetworkCommunication()
            self.chatRoom.joinChat(username: self.username)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(username: .constant("Cat"))
    }
}
