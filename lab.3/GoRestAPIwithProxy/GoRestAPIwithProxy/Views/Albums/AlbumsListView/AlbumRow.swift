//
//  AlbumRow.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct AlbumRow: View {
    
    var album: Album
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack(spacing: 30) {
                    Image(systemName: "livephoto")
                        .resizable()
                        .foregroundColor(.blue)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                        .overlay(Circle().stroke(Color.orange, lineWidth: 3))
                        .padding(.leading, 5)
                    
                    VStack(alignment: .leading) {
                        Text(album.title)
                            .allowsTightening(true)
                            .lineLimit(1)
                            .font(Font(UIFont(name: "times new roman", size: 20)!).bold().italic())
                            .foregroundColor(.blue)
                        
                        Text("Album ID: \(album.id)")
                            .foregroundColor(Color.gray)
                            .font(.subheadline)
                    }
                }
                Spacer()
                
                Text("User ID: \(album.userID)").foregroundColor(Color.gray)
                    .font(.subheadline)
                    .padding(.horizontal, 30)
            }
            
            Image("landscape")
                .frame(width: 415, height: 415, alignment: .center)
                .clipped()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct AlbumRow_Previews: PreviewProvider {
    static var previews: some View {
        AlbumRow(album: Album(id: "1", userID: "5441", title: "Test", links: Post_Links(linksSelf: Href(href: "LINK"), edit: Href(href: "LINK"))))
    }
}
