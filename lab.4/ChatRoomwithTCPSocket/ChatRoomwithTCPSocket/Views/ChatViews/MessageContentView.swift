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
    var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(Color.white)
            .background(isCurrentUser ? Color.blue : Color(UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}

struct MessageContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessageContentView(contentMessage: "Test Message", isCurrentUser: false)
    }
}
