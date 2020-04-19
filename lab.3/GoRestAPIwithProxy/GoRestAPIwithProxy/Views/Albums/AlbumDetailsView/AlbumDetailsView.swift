//
//  AlbumDetailsView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct AlbumDetailsView: View {
        
    var album: Album
    
    var body: some View {
        Text(album.title)
    }
}

struct AlbumDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailsView(album: Album(id: "1", userID: "1", title: "Test", links: Post_Links(linksSelf: Href(href: "LINK"), edit: Href(href: "LINK"))))
    }
}
