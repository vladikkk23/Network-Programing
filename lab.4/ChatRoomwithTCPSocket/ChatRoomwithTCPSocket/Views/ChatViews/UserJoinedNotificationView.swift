//
//  UserJoinedNotificationView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 05/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct UserJoinedNotificationView: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(self.user.name) Joined")
                .padding(10)
                .foregroundColor(self.user.isCurrentUser ? .white : .black)
                .background(self.user.isCurrentUser ? Color.blue : Color.clear)
                .cornerRadius(10)
        }
    }
}
struct UserJoinedNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        UserJoinedNotificationView(user: User(name: "Cat"))
    }
}
