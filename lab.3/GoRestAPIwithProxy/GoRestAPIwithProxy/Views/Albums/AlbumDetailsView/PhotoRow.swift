//
//  PhotoRow.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 21/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct PhotoRow: View {
    var photo: Photo
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text(self.photo.title)
                .font(Font(UIFont(name: "times new roman", size: 20)!).bold().italic())
                .foregroundColor(.blue)
            
            Image("landscape")
                .frame(width: 415, height: 415, alignment: .center)
                .clipped()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Text("Photo ID: \(self.photo.id)")
                    .foregroundColor(Color.gray)
                    .font(.subheadline)
                
                Spacer()
                
                Text("Album ID: \(self.photo.albumID)").foregroundColor(Color.gray)
                    .font(.subheadline)
            }.padding(.horizontal, 30)
        }
    }
}

struct PhotoRow_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRow(photo: Photo(id: "1", albumID: "2", title: "TEST", url: "", thumbnail: "", links: Post_Links(linksSelf: Href(href: ""), edit: Href(href: ""))))
    }
}
