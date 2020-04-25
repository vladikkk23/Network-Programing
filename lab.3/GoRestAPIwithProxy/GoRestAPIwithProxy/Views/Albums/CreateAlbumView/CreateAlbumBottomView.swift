//
//  CreateAlbumBottomView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 20/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct CreateAlbumBottomView: View {
    
    var albumData = AlbumsData.shared
    
    @Binding var presentationMode: PresentationMode
    @Binding var userID: String
    @Binding var albumTitle: String
    @Binding var images: [UIImage?]
    @Binding var imageTitles: [String]
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                let newAlbum = New_Album(userID: self.userID, title: self.albumTitle)
                self.albumData.addNewAlbum(withAlbumData: newAlbum, withPhotoData: self.images, withPhotoTitles: self.imageTitles)
                
                self.presentationMode.dismiss()
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
