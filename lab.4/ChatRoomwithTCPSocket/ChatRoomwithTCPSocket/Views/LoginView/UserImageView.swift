//
//  UserImageView.swift
//  ChatRoomwithTCPSocket
//
//  Created by vladikkk on 04/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct UserImageView : View {
    @Binding var image: UIImage?
    @Binding var showCaptureImageView: Bool
    
    var body: some View {
        VStack {
            if self.image != nil {
                Image(uiImage: self.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 200)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
            } else {
                Image(systemName: "person.crop.circle.badge.plus")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipped()
            }
            
            Button(action: {
                self.showCaptureImageView.toggle()
            }) {
                Text("Choose Photo")
            }
        }
        .padding(.bottom, 75)
    }
}

struct UserImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserImageView(image: .constant(UIImage(named: "Cat")), showCaptureImageView: .constant(false))
    }
}
