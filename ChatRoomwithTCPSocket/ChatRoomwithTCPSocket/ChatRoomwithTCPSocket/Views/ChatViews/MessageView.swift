//
//  MessageView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    var currentMessage: Message
    
    var body: some View {
        VStack {
            if currentMessage.content.contains(currentMessage.user.name) {
                UserJoinedNotificationView(message: currentMessage)
            } else {
                if !self.currentMessage.user.isCurrentUser {
                    HStack(alignment: .bottom) {
                        Image(uiImage: currentMessage.user.avatar!)
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .cornerRadius(20)
                        
                        MessageContentView(contentMessage: currentMessage.content, senderName: currentMessage.user.name, isCurrentUser: currentMessage.user.isCurrentUser)
                            .offset(y: -10)
                        Spacer()
                    }
                    .offset(x: -10)
                    .padding()
                } else {
                    HStack(alignment: .bottom) {
                        Spacer()
                        MessageContentView(contentMessage: currentMessage.content, senderName: currentMessage.user.name, isCurrentUser: currentMessage.user.isCurrentUser)
                            .offset(y: -10)
                        
                        Image(uiImage: currentMessage.user.avatar!)
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .cornerRadius(20)
                    }
                    .offset(x: 10)
                    .padding()
                }
            }
        }
        .padding(.vertical, -10)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(currentMessage: Message(content: "Ola, ANTA!", user: User(name: "Cat", avatar: UIImage(named: "Cat"), isCurrentUser: true)))
    }
}
