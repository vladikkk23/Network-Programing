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
        HStack {
            VStack(alignment: .leading) {
                Text(album.title)
                    .bold()
            }
            
            Spacer()
            
            Text("Album ID: \(album.id)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct AlbumRow_Previews: PreviewProvider {
    static var previews: some View {
        AlbumRow(album: Album(id: "1", userID: "1", title: "Test", links: Post_Links(linksSelf: Href(href: "LINK"), edit: Href(href: "LINK"))))
    }
}
