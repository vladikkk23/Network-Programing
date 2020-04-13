//
//  CreateNewAlbumView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct CreateNewAlbumView: View {
    var body: some View {
        Button(action: {
            //                    PostsRequests.shared.GET_POST_BY_ID(id: 173)
            //                    CommentsRequests.shared.GET_COMMENTS_FOR_USER(withName: "Anderson Jaskolski")
            //                    AlbumsRequests.shared.GET_ALBUM_BY_ID(id: 1)
            //                    PhotosRequests.shared.GET_PHOTO_BY_ID(id: 2)
            let newAlbum = New_Album(userID: "1717", title: "Test Album")
            AlbumsRequests.shared.POST_NEW_ALBUM(withData: newAlbum)
        }) {
            Text("POST NEW ALBUM")
                .foregroundColor(.blue)
        }
    }
}

struct CreateNewAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewAlbumView()
    }
}
