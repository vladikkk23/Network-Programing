//
//  ChatView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @State var typingMessage = ""
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataHolder: Data_Holder
    @Binding var user: User?
    
    let chatRoom = ChatRoom.shared
    
    var body: some View {
        VStack {
            TopBarView(presentationMode: self.presentationMode, typingMessage: self.$typingMessage)
            
            Divider()
                .offset(y: -20)
            
            List {
                ForEach(self.dataHolder.messages, id: \.self) { message in
                    MessageView(currentMessage: message)
                }
            }
            
            Divider()
            
            BottomBarView(typingMessage: self.$typingMessage)
        }
        .keyboardAdaptive() 
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear {
            ChatRoom.shared.setupNetworkConnection()
            // Join ChatRoom
            ChatRoom.shared.joinChat(user: self.user!)
        }
        .onDisappear {
            self.chatRoom.stopChatSession()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: .constant(User(name: "Cat")))
    }
}
