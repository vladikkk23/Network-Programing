//
//  AlbumListView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct AlbumListView: View {
    
    @ObservedObject var albumsData = AlbumsData.shared
    
    var body: some View {
        NavigationView {
            List(albumsData.albums) { album in
                NavigationLink(destination: AlbumDetailsView(album: album)) {
                    AlbumRow(album: album)
                }
            }
            .navigationBarTitle("ALBUMS (\(self.albumsData.albums.count))")
            .navigationBarItems(leading:
                Button(action: {
                    
                    let newAlbum = New_Album(userID: "1717", title: "Test Album")
                    AlbumsRequests.shared.POST_NEW_ALBUM(withData: newAlbum)
                    
                    self.albumsData.fetchAlbums()
                }, label: {
                    Text("Update ALBUMS")
                        .foregroundColor(.red)
                })
                , trailing:
                NavigationLink(destination: CreateNewAlbumView()) {
                    Text("CREATE New Album")
                        .foregroundColor(.blue)
            })
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
