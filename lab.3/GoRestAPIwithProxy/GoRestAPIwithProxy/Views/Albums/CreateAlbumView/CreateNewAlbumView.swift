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
    
    @State var showCaptureImageView: Bool = false
    @State var images: [Image?] = [
        Image(systemName: "photo"), Image(systemName: "photo"),
        Image(systemName: "photo"), Image(systemName: "photo"),
        Image(systemName: "photo"), Image(systemName: "photo")
    ]
    
    var body: some View {
        ZStack {
            VStack {
                NewAlbumForm()
                
                Spacer()
                
                Divider()
                
                AddPhotosView(showCaptureImageView: self.$showCaptureImageView, images: self.$images)
                
                Spacer()
                
                Divider()
                
                CreateAlbumBottomView(presentationMode: self.presentationMode)
            }
            
            if (showCaptureImageView) {
                CaptureImageView(isShown: self.$showCaptureImageView, images: self.$images)
                    .offset(y: 30)
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
