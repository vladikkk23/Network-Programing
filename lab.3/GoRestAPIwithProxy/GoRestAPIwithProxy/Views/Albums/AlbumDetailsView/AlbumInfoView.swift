//
//  AlbumInfoView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 21/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct AlbumInfoView: View {
    var album: Album
    var user: UserInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack {
                    Text("Album ID: ")
                        .font(Font(UIFont(name: "Times New Roman", size: 18)!)).bold()
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                VStack {
                    Text(self.album.id)
                        .font(Font(UIFont(name: "Times New Roman", size: 18)!)).bold()
                        .foregroundColor(.orange)
                }
            }.frame(height: 20)
            
            HStack {
                VStack {
                    Text("User ID:")
                        .font(Font(UIFont(name: "Times New Roman", size: 18)!)).bold()
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                VStack {
                    Text(self.album.userID)
                        .font(Font(UIFont(name: "Times New Roman", size: 18)!)).bold()
                        .foregroundColor(.orange)
                }
            }.frame(height: 20)
            
            HStack {
                VStack {
                    Text("User Name:")
                        .font(Font(UIFont(name: "Times New Roman", size: 18)!)).bold()
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                VStack {
                    Text("\(self.user.firstName) \(self.user.lastName)")
                        .font(Font(UIFont(name: "Times New Roman", size: 18)!)).bold()
                        .foregroundColor(.orange)
                }
            }.frame(height: 20)
        }.frame(width: 400)
    }
}

struct AlbumInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumInfoView(album: Album(id: "9999", userID: "99999", title: "Voluptatibus quasi doloremque sapiente. Enim labore facilis optio incidunt reiciendis.", links: Post_Links(linksSelf: Href(href: "LINK"), edit: Href(href: "LINK"))), user: UserInfo(firstName: "TEST", lastName: "USER"))
    }
}
