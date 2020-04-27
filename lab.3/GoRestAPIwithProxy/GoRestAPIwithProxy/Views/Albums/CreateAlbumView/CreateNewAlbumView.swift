//
//  CreateNewAlbumView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct CreateNewAlbumView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var userID = ""
    @State var albumTitle = ""
    @State var showCaptureImageView: Bool = false
    @State var images: [UIImage?] = [
        UIImage(systemName: "photo"), UIImage(systemName: "photo"),
        UIImage(systemName: "photo"), UIImage(systemName: "photo"),
        UIImage(systemName: "photo"), UIImage(systemName: "photo")
    ]
    @State var photoTitles = ["", "", "", "", "", ""]
    
    var body: some View {
        ZStack {
            VStack {
                NewAlbumForm(userID: self.$userID, AlbumTitle: self.$albumTitle)
                
                Divider()
                
                AddPhotosView(showCaptureImageView: self.$showCaptureImageView, images: self.$images, photoTitles: self.$photoTitles)
                    .frame(width: 400)
                
                Divider()
                
                CreateAlbumBottomView(presentationMode: self.presentationMode, userID: self.$userID, albumTitle: self.$albumTitle, images: self.$images, imageTitles: self.$photoTitles)
            }
            
            if (showCaptureImageView) {
                CaptureImageView(isShown: self.$showCaptureImageView, images: self.$images)
                    .offset(y: 50)
            }
        }
        .onDisappear {
            CaptureImageView.self.index = -1
        }
    }
}

struct CreateNewAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewAlbumView()
    }
}
