//
//  AlbumsListTopBarView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 19/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct AlbumsListTopBarView: View {
    
    @ObservedObject var albumsData = AlbumsData.shared
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.albumsData.updateAlbums()
                }){
                    Image(systemName: "arrow.2.circlepath")
                        .resizable()
                        .frame(width: 40, height: 35)
                        .foregroundColor(.blue)
                }
                
                HStack(alignment: .bottom) {
                    Text("ALBUMS")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                    
                    Text("(\(albumsData.albums.count))")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2)
                }.frame(width: 310)
                
                NavigationLink(destination: CreateNewAlbumView()) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                }
                
            }.frame(width: 410, height: 50)
            
            Divider()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 15) {
                    ForEach(self.albumsData.topAlbums) { album in
                        NavigationLink(destination: AlbumDetailsView(album: album)) {
                            TopAlbumsPreview(album: album)
                                .foregroundColor(.gray)
                        }
                    }
                }.frame(height: 90)
            }
        }
    }
}

struct AlbumsListTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsListTopBarView()
    }
}
