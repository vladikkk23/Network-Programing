//
//  LoginView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    let textLabelColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    @State var username = ""
    @State var password = ""
    @State var showChatRoom = false
    @State var showCaptureImageView = false
    @State var showingAlert = false
    @State var image: Image?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    NavigationLink(destination: ChatView(username: self.$username), isActive: $showChatRoom) {
                        EmptyView()
                    }
                    
                    WelcomeTextView()
                    
                    UserImageView(image: $image, showCaptureImageView: $showCaptureImageView)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .background(self.textLabelColor)
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    Button(action: {
                        // show chat room if access is granted.
                        if !self.username.isEmpty {
                            self.showChatRoom.toggle()
                        } else {
                            self.showingAlert.toggle()
                        }
                    }) {
                        LoginButtonView()
                    }
                    .alert(isPresented: self.$showingAlert) {
                        Alert(title: Text("Don't be an animal!"), message: Text("Please enter a username."), dismissButton: .default(Text("Got it!")))
                    }
                }
                .padding()
                
                if (showCaptureImageView) {
                    CaptureImageView(isShown: $showCaptureImageView, image: $image)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
