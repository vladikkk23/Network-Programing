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
    @State var count = [Int]()
    
    @State var showPhotos = false
    @State var showEmptyPhotos = false
    @State var showAlbumInfo = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                AlbumInfoView(album: self.album, user: self.userData.userInfo)
                
                Divider()
                
                ZStack {
                    List(self.count, id: \.self) { it in
                        PhotoRow(photo: self.photoData.photos[it], image: self.photoData.images[it])
                    }
                    .opacity(self.showPhotos ? 1 : 0)
                    .offset(x: -10)
                    
                    EmptyAlbumView()
                        .opacity(self.showEmptyPhotos ? 1 : 0)
                        .frame(width: 410, height: 200, alignment: .center)
                }
            }.opacity(self.showAlbumInfo ? 1 : 0)
            
            ProgressBarView()
                .opacity(self.showAlbumInfo ? 0 : 1)
                .frame(width: 200, height: 200, alignment: .center)
                .navigationBarTitle(Text(self.album.title), displayMode: .inline)
        }
        .onAppear {
            self.photoData.fetchAlbumPhotos(album: self.album)
            self.userData.fetchUserInfo(forAlbum: self.album)
            
            let delay = DispatchTime.now() + .milliseconds(3600)
            
            DispatchQueue.main.asyncAfter(deadline: delay) {
                if !self.photoData.photos.isEmpty {
                    self.showPhotos.toggle()
                    self.countPhotos()
                } else {
                    NSLog("THIS ALBUM HAS NO PHOTOS!")
                    self.showEmptyPhotos.toggle()
                }
                self.showAlbumInfo.toggle()
            }
        }
    }
    
    private func countPhotos() {
        for it in 0..<self.photoData.photos.count {
            self.count.append(it)
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
