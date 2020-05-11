//
//  UserJoinedNotificationView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 05/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct UserJoinedNotificationView: View {
    var message: Message
    
    var body: some View {
        HStack(alignment: .center) {
            Text(self.message.content.withoutWhitespace())
                .font(.subheadline)
                .padding(10)
                .foregroundColor(self.message.user.isCurrentUser ? .blue : .gray)
                .cornerRadius(10)
        }
        .frame(width: 400)
    }
}
struct UserJoinedNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        UserJoinedNotificationView(message: Message(content: "Cat has joined", user: User(name: "Cat", avatar: UIImage(named: "Cat"), avatarLink: "", isCurrentUser: false)))
    }
}
