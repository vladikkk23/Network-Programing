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
        HStack(alignment: .bottom, spacing: 15) {
            if !self.currentMessage.user.isCurrentUser {
                HStack(alignment: .bottom, spacing: 15) {
                    Image(currentMessage.user.avatar)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                    
                    MessageContentView(contentMessage: currentMessage.content, isCurrentUser: currentMessage.user.isCurrentUser)
                }
            } else {
                HStack(alignment: .bottom) {
                    Spacer() 
                    MessageContentView(contentMessage: currentMessage.content, isCurrentUser: currentMessage.user.isCurrentUser)
                    
                    Image(currentMessage.user.avatar)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .cornerRadius(20)
                }
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(currentMessage: Message(content: "Test Message", user: User(name: "Cat", avatar: "Cat-Avatar", isCurrentUser: true)))
    }
}
