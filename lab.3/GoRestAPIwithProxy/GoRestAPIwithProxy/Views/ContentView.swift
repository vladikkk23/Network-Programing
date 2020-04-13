//
//  ContentView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 02/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Button(action: {
                    //                    UsersRequests.shared.GET_ALL_USERS()
                    //                    PostsRequests.shared.GET_ALL_POSTS()
                    //                    CommentsRequests.shared.GET_ALL_COMMENTS()
                    AlbumsRequests.shared.GET_ALL_ALBUMS()
                    //                    PhotosRequests.shared.GET_ALL_PHOTOS()
                    //                    let newUser = New_User(email: "example02@mail.com", first_name: "lexy", last_name: "butch", gender: .female, dob: .init(timeIntervalSinceNow: .init(integerLiteral: -662256000)), phone: "00112233445", website: .init(href: "https://bit.ly/IqT6zt"), address: "Platform 3/4 end of rainbow street", status: .active)
                    //                    UsersRequests.shared.POST_NEW_USER(withData: newUser)
                }) {
                    Text("POST NEW USER")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    //                    UsersRequests.shared.GET_USER_BY_ID(id: 632)
                                        PostsRequests.shared.GET_POSTS_FOR_USER(withID: 632)
                    //                    CommentsRequests.shared.GET_COMMENT_BY_ID(id: 4)
                    //                    AlbumsRequests.shared.GET_ALBUMS_FOR_USER(withID: 1642)
                    //                    PhotosRequests.shared.GET_PHOTOS_FROM_ALBUM(withID: 1007)
//                    let newPost = New_Post(userID: "1717", title: "Test Title", body: "Test Body")
//                    PostsRequests.shared.POST_NEW_POST(withData: newPost)
                }) {
                    Text("POST NEW POST")
                        .foregroundColor(.yellow)
                }
                
                Button(action: {
                    //                    UsersRequests.shared.GET_USER_BY_FIRST_NAME(name: "john")
                    //                    PostsRequests.shared.GET_POSTS_WITH_TITLE(containing: "Veritatis sed soluta omnis.")
                    //                    CommentsRequests.shared.GET_COMMENTS_FOR_POST(withID: 3218)
                    //                    AlbumsRequests.shared.GET_ALBUMS_WITH_TITLE(containing: "Enim est quis veniam reprehenderit dicta.")
                    //                    PhotosRequests.shared.GET_PHOTOS_WITH_TITLE(containing: "Aut ad veniam facilis aliquam voluptatum eum. Rerum distinctio sint consequatur et ut nihil.")
                    let newComment = New_Comment(postID: "2330", name: "Tiana Bergnaum III", email: "jamie93@koepp.com", body: "Test Body")
                    CommentsRequests.shared.POST_NEW_COMMENT(withData: newComment)
                }) {
                    Text("POST NEW COMMENT")
                        .foregroundColor(.green)
                }
                
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
                
                Button(action: {
                    //                    CommentsRequests.shared.GET_COMMENTS_FOR_USER(withEmail: "wiegand.myrtie@yahoo.com")
                    let newPhoto = New_Photo(albumID: "4512", title: "Test Photo", url: "https://www.google.md/url?sa=i&url=https%3A%2F%2Fmicrosoft.github.io%2FELL%2Ftutorials%2FGetting-started-with-object-detection-using-region-of-interest-networks%2F&psig=AOvVaw0oAlG2yxOR_fwQgtTvQtC1&ust=1586610949238000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKi528T43egCFQAAAAAdAAAAABAD", thumb: "https://i.ibb.co/C53mSWN/thumbnail.png")
                    PhotosRequests.shared.POST_NEW_ALBUM(withData: newPhoto)
                }) {
                    Text("POST NEW PHOTO")
                        .foregroundColor(.blue)
                }
            }
            .navigationBarTitle("USERS")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
