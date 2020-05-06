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
    
    @EnvironmentObject var dataHolder: Data_Holder
    
    @State var username = ""
    @State var showChatRoom = false
    @State var showCaptureImageView = false
    @State var showingAlert = false
    @State var image: UIImage?
    @State var user: User?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    NavigationLink(destination: ChatView(user: self.$user), isActive: $showChatRoom) {
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
                        // Show chat room if access is granted.
                        if !self.username.isEmpty {
                            self.user = User(name: self.username, avatar: self.image, isCurrentUser: true)
                            
                            self.showChatRoom.toggle()
                            self.username = ""
                            self.image = UIImage(systemName: "person.crop.circle.badge.plus")
                        } else {
                            self.showingAlert.toggle()
                        }
                    }) {
                        LoginButtonView()
                    }
                    .alert(isPresented: self.$showingAlert) {
                        Alert(title: Text("Don't be an animal!"), message: Text("Enter your username."), dismissButton: .default(Text("Got it!")))
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
