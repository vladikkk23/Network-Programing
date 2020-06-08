//
//  BottomBarView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct BottomBarView: View {
    @Binding var typingMessage: String
    
    var body: some View {
        HStack {
            TextField("Message...", text: $typingMessage)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(minHeight: 30)
        }
        .frame(minHeight: 50)
        .padding(.horizontal)
    }
}
