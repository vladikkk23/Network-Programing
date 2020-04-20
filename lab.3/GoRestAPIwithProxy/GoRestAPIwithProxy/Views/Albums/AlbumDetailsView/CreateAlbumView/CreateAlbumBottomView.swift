//
//  CreateAlbumBottomView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 20/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct CreateAlbumBottomView: View {
    
    @Binding var presentationMode: PresentationMode
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                let newAlbum = New_Album(userID: "1717", title: "Test Album")
                AlbumsRequests.shared.POST_NEW_ALBUM(withData: newAlbum)
                
                let delay = DispatchTime.now() + .seconds(2)
                
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    self.presentationMode.dismiss()
                }
            }) {
                Text("POST")
                    .font(.system(size: 25)).bold()
                    .frame(width: 150)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(25)
            }
                        
            Button(action: {
                self.presentationMode.dismiss()
            }) {
                Text("CANCEL")
                    .font(.system(size: 25)).bold()
                    .frame(width: 150)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(25)
            }
        }.frame(height: 50)
    }
}
