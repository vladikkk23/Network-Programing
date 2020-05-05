//
//  TopBarView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct TopBarView: View {
    @Binding var presentationMode: PresentationMode
    @Binding var typingMessage: String

    var body: some View {
        HStack(spacing: 50) {
            Button(action: {
                self.presentationMode.dismiss()
            }) {
                Text("QUIT")
                    .font(Font(UIFont(name: "AvenirNext-DemiBold", size: 20)!))
                    .frame(width: 60, height: 40)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.leading, 5)
            }
            .padding(.vertical)
            
            Text("Animals Chat Room")
                .font(Font(UIFont(name: "AvenirNext-DemiBold", size: 20)!))
            
            Button(action: sendMessage) {
                Text("SEND")
                    .font(Font(UIFont(name: "AvenirNext-DemiBold", size: 20)!))
                    .frame(width: 60, height: 40)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.trailing, 5)
            }
        }
        .frame(minHeight: 50)
    }
    
    
    
    private func sendMessage() {
        self.typingMessage = ""
    }
}
