//
//  AlbumDetailsView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct AlbumDetailsView: View {
    
    var photoData = PhotosData.shared
    var userData = UsersData.shared
    var album: Album
    
    @State var showPhotos = false
    
    var body: some View {
        ZStack {
            VStack {
                AlbumInfoView(album: self.album, user: self.userData.userInfo)
                
                Divider()
                
                ZStack {
                    List(self.photoData.photos) { photo in
                        PhotoRow(photo: photo)
                    }
                    .opacity(self.showPhotos ? 1 : 0)
                    .offset(x: -10)
                }
            }.opacity(self.showPhotos ? 1 : 0)
            
            ProgressBarView()
                .opacity(self.showPhotos ? 0 : 1)
                .frame(width: 200, height: 200, alignment: .center)
                .navigationBarTitle(Text(self.album.title), displayMode: .inline)
        }
        .onAppear {
            self.photoData.fetchAlbumPhotos(album: self.album)
            self.userData.fetchUserInfo(forAlbum: self.album)
            
            let delay = DispatchTime.now() + .seconds(3)
            
            DispatchQueue.main.asyncAfter(deadline: delay) {
                if !self.photoData.photos.isEmpty {
                    self.showPhotos.toggle()
                } else {
                    NSLog("THIS ALBUM HAS NO PHOTOS!")
                }
            }
        }
    }
}

struct AlbumDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailsView(album: Album(id: "1", userID: "1", title: "Test", links: Post_Links(linksSelf: Href(href: "LINK"), edit: Href(href: "LINK")), photos: [
            Photo(id: "1", albumID: "2", title: "TEST", url: "", thumbnail: "", links: Post_Links(linksSelf: Href(href: ""), edit: Href(href: ""))),
            Photo(id: "2", albumID: "2", title: "TEST", url: "", thumbnail: "", links: Post_Links(linksSelf: Href(href: ""), edit: Href(href: ""))),
            Photo(id: "3", albumID: "2", title: "TEST", url: "", thumbnail: "", links: Post_Links(linksSelf: Href(href: ""), edit: Href(href: "")))
        ]))
    }
}
