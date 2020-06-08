//
//  MessageContentView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct MessageContentView: View {
    var contentMessage: String
    var senderName: String
    var isCurrentUser: Bool
    
    var body: some View {
        HStack {
            if !isCurrentUser {
                VStack(alignment: .leading) {
                    Text(senderName.withoutWhitespace())
                        .font(.subheadline)
                        .foregroundColor(Color.gray)

                    Text(contentMessage.withoutWhitespace())
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color(UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0)))
                        .cornerRadius(10)
                }
            } else {
                VStack(alignment: .trailing) {
                    Text(contentMessage.withoutWhitespace())
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct MessageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessageContentView(contentMessage: "Test Message", senderName: "Cat", isCurrentUser: false)
    }
}
