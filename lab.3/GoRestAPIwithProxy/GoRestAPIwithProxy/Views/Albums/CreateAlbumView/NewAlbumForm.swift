//
//  NewAlbumForm.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 22/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct NewAlbumForm: View {
    
    @State var userID = ""
    @State var AlbumTitle = ""
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Album Info")
                .font(Font(UIFont(name: "Avenir", size: 30)!)).bold()
                .foregroundColor(.blue)
            
            TextField("User ID", text: self.$userID)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(20.0)
            
            TextField("Album Title", text: self.$AlbumTitle)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(20.0)
        }.frame(width: 400, height: 200, alignment: .center)
    }
}

struct NewAlbumForm_Previews: PreviewProvider {
    static var previews: some View {
        NewAlbumForm()
    }
}
