//
//  PreviewView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 19/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct PreviewView: View {
    
    let preview: Preview
    
    var body: some View {
        Image(preview.imageUrl)
            .resizable()
            .frame(width: 136, height: 136)
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(preview: Preview(id: 1, imageUrl: ""))
    }
}
