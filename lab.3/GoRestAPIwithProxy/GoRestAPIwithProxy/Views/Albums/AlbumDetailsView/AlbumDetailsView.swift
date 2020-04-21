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
    var album: Album
    
    @State var showPhotos = false
    
    var body: some View {
        NavigationView {
            VStack {
                AlbumInfoView(album: self.album)
                
                Divider()
                
                List(self.photoData.photos) { photo in
                    PhotoRow(photo: photo)
                }
                .offset(x: -10)
                .opacity(self.showPhotos ? 1 : 0)
            }
            .navigationBarTitle(Text(self.album.title), displayMode: .inline)
        }
        .onAppear {
            self.photoData.fetchAlbumPhotos(album: self.album)
            
            let delay = DispatchTime.now() + .seconds(2)
            
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.showPhotos.toggle()
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
