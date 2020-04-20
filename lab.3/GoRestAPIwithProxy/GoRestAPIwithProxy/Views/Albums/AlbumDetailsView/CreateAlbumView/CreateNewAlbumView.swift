//
//  CreateNewAlbumView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct CreateNewAlbumView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            CreateAlbumBottomView(presentationMode: self.presentationMode)
        }
    }
}

struct CreateNewAlbumView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewAlbumView()
    }
}
