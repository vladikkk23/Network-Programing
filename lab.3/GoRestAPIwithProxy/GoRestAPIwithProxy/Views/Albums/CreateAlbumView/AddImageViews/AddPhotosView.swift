//
//  AddPhotosView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 23/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

private struct AddPhotoButton: View {
    
    @Binding var showCaptureImageView: Bool
    @Binding var image: Image?
    
    var body: some View {
        VStack {
            image?.resizable()
                .frame(width: 125, height: 100)
                .padding()
                .foregroundColor(.black)
                .cornerRadius(25)
        }
    }
}

struct AddPhotosView: View {
    
    @Binding var showCaptureImageView: Bool
    @Binding var images: [Image?]
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 50) {
                    HStack(spacing: 50) {
                        ForEach(0..<2){ it in
                            AddPhotoButton(showCaptureImageView: self.$showCaptureImageView, image: self.$images[it])
                        }
                    }
                    
                    HStack(spacing: 50) {
                        ForEach(2..<4){ it in
                            AddPhotoButton(showCaptureImageView: self.$showCaptureImageView, image: self.$images[it])
                        }
                    }
                    
                    HStack(spacing: 50) {
                        ForEach(4..<6){ it in
                            AddPhotoButton(showCaptureImageView: self.$showCaptureImageView, image: self.$images[it])
                        }
                    }
                }
                
                Button(action: {
                    self.showCaptureImageView.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.orange)
                }
            }
        }
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddPhotosView(showCaptureImageView: .constant(false), images: .constant([Image(systemName: "photo")]))
    }
}
