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
            VStack {
                AlbumsListTopBarView()
                BottomView()
            }
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}

//List(self.albumsData.topAlbums) { album in
//    NavigationLink(destination: AlbumDetailsView(album: album)) {
//        AlbumRow(album: album)
//    }
//}
