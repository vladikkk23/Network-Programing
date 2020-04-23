//
//  EmptyAlbumView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 23/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct EmptyAlbumView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            Image(systemName: "eye.slash")
                .resizable()
                .frame(width: 100, height: 70, alignment: .center)
                .foregroundColor(.gray)
            
            Text("Oops...")
                .foregroundColor(.orange)
                .font(Font(UIFont(name: "Avenir", size: 50)!)).bold()
            
            Text("Looks like this album has no photos")
                .foregroundColor(.blue)
                .font(Font(UIFont(name: "Avenir", size: 24)!)).bold()
        }
    }
}

struct EmptyAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyAlbumView()
    }
}
