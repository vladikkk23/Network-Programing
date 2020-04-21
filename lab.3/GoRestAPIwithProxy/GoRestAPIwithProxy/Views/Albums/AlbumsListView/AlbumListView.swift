//
//  AlbumListView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct AlbumListView: View {
    
    var photoData = PhotosData.shared
    @ObservedObject var albumsData = AlbumsData.shared
    
    var body: some View {
        NavigationView {
            VStack {
                AlbumsListTopBarView()
                
                Divider()
                
                List {
                    ForEach(self.albumsData.albums) { album in
                        NavigationLink(destination: AlbumDetailsView(album: album)) {
                            AlbumRow(album: album)
                        }
                    }
                }.offset(x: -10)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
