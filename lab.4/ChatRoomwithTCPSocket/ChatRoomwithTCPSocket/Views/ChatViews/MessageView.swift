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
                UserJoinedNotificationView(user: currentMessage.user)
            } else {
                if !self.currentMessage.user.isCurrentUser {
                    HStack(alignment: .bottom, spacing: 15) {
                        Image(uiImage: currentMessage.user.avatar!)
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .cornerRadius(20)
                        
                        MessageContentView(contentMessage: currentMessage.content, senderName: currentMessage.user.name, isCurrentUser: currentMessage.user.isCurrentUser)
                    }
                } else {
                    HStack(alignment: .bottom) {
                        Spacer()
                        MessageContentView(contentMessage: currentMessage.content, senderName: currentMessage.user.name, isCurrentUser: currentMessage.user.isCurrentUser)
                        
                        Image(uiImage: currentMessage.user.avatar!)
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(currentMessage: Message(content: "Cat, ANTA!", user: User(name: "Cat", avatar: UIImage(named: "Cat"), isCurrentUser: true)))
    }
}
