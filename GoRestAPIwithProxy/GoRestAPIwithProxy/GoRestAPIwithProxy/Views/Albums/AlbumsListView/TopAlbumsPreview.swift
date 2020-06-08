//
//  TopAlbumsPreview.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 19/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct TopAlbumsPreview: View {
    
    var album: Album
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "livephoto")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(radius: 3)
                    .overlay(Circle().stroke(Color.orange, lineWidth: 3))
                
                HStack {
                    Text("User ID: \(album.userID)")
                        .font(.caption)
                }
            }
        }
    }
}

struct TopAlbumsPreview_Previews: PreviewProvider {
    static var previews: some View {
        TopAlbumsPreview(album: Album(id: "1", userID: "10", title: "Test", links: Post_Links(linksSelf: Href(href: "LINK"), edit: Href(href: "LINK"))))
    }
}
