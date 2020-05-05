//
//  ChatView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    var messages = [Message]()
        
    @State var typingMessage = ""
    @Environment(\.presentationMode) var presentationMode
    @Binding var username: String
    
    var body: some View {
        VStack {
            TopBarView(presentationMode: self.presentationMode, typingMessage: self.$typingMessage)
            
            Divider()
                .offset(y: -20)
            
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(username: .constant("Cat"))
    }
}
