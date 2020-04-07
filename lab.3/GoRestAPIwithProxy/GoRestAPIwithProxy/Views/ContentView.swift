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
                    //                    AlbumsRequests.shared.GET_ALL_ALBUMS()
                    //                    PhotosRequests.shared.GET_ALL_PHOTOS()
                    let newUser = New_User(email: "example02@mail.com", first_name: "lexy", last_name: "butch", gender: .female, dob: .init(timeIntervalSinceNow: .init(integerLiteral: -662256000)), phone: "00112233445", website: .init(href: "https://bit.ly/IqT6zt"), address: "Platform 3/4 end of rainbow street", status: .active)
                    UsersRequests.shared.POST_NEW_User(withData: newUser)
                }) {
                    Text("POST NEW USER")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    //                    UsersRequests.shared.GET_USER_BY_ID(id: 632)
                    //                    PostsRequests.shared.GET_POSTS_FOR_USER(withID: 632)
                    //                    CommentsRequests.shared.GET_COMMENT_BY_ID(id: 4)
                    //                    AlbumsRequests.shared.GET_ALBUMS_FOR_USER(withID: 1642)
                    PhotosRequests.shared.GET_PHOTOS_FROM_ALBUM(withID: 1007)
                }) {
                    Text("GET POSTS FOR USER WITH ID 632")
                        .foregroundColor(.yellow)
                }
                
                Button(action: {
                    //                    UsersRequests.shared.GET_USER_BY_FIRST_NAME(name: "john")
                    //                    PostsRequests.shared.GET_POSTS_WITH_TITLE(containing: "Veritatis sed soluta omnis.")
                    //                    CommentsRequests.shared.GET_COMMENTS_FOR_POST(withID: 3218)
                    //                    AlbumsRequests.shared.GET_ALBUMS_WITH_TITLE(containing: "Enim est quis veniam reprehenderit dicta.")
                    PhotosRequests.shared.GET_PHOTOS_WITH_TITLE(containing: "Aut ad veniam facilis aliquam voluptatum eum. Rerum distinctio sint consequatur et ut nihil.")
                }) {
                    Text("GET ALL POSTS WITH TITLE: \"Veritatis sed soluta\" ")
                        .foregroundColor(.green)
                }
                
                Button(action: {
                    //                    PostsRequests.shared.GET_POST_BY_ID(id: 173)
                    //                    CommentsRequests.shared.GET_COMMENTS_FOR_USER(withName: "Anderson Jaskolski")
                    //                    AlbumsRequests.shared.GET_ALBUM_BY_ID(id: 1)
                    PhotosRequests.shared.GET_PHOTO_BY_ID(id: 2)
                }) {
                    Text("GET POST BY ID")
                        .foregroundColor(.blue)
                }
                
                Button(action: {
                    CommentsRequests.shared.GET_COMMENTS_FOR_USER(withEmail: "wiegand.myrtie@yahoo.com")
                }) {
                    Text("GET POST BY ID")
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
