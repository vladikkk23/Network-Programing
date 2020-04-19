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
        GeometryReader { geometry in
            VStack{
                HStack(spacing: 90) {
                    Button(action: {}){
                        Image(systemName: "arrow.2.circlepath")
                            .resizable()
                            .frame(width: 40, height: 35)
                            .foregroundColor(.blue)
                    }
                    
                    Text("ALBUMS")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                    
                    Button(action: {}){
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    
                }.frame(width: 410, height: 50)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 15) {
                        ForEach(self.albumsData.topAlbums) { album in
                            TopAlbumsPreview(album: album)
                                .foregroundColor(.gray)
                        }
                    }.frame(height: 90)
                }.frame(width: 410)
            }
        }
    }
}

struct AlbumsListTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsListTopBarView()
    }
}
