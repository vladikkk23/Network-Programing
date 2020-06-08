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
    @Binding var image: UIImage?
    @Binding var photoTitle: String
    
    var body: some View {
        VStack {
            Image(uiImage: self.image!)
                .resizable()
                .frame(width: 100, height: 75)
                .padding()
                .foregroundColor(.black)
                .cornerRadius(25)
            
            TextField("Photo Title", text: self.$photoTitle)
                .frame(width: 140, height: 10)
                .padding()
                .background(Color.gray.opacity(0.5))
                .cornerRadius(20.0)
        }
    }
}

struct AddPhotosView: View {
    
    @Binding var showCaptureImageView: Bool
    @Binding var images: [UIImage?]
    @Binding var photoTitles: [String]
    
    var body: some View {
        ZStack {
            VStack {
                VStack(spacing: 0) {
                    HStack(spacing: 50) {
                        ForEach(0..<2){ it in
                            AddPhotoButton(showCaptureImageView: self.$showCaptureImageView, image: self.$images[it], photoTitle: self.$photoTitles[it])
                        }
                    }
                    
                    HStack(spacing: 50) {
                        ForEach(2..<4){ it in
                            AddPhotoButton(showCaptureImageView: self.$showCaptureImageView, image: self.$images[it], photoTitle: self.$photoTitles[it])
                        }
                    }
                    
                    HStack(spacing: 50) {
                        ForEach(4..<6){ it in
                            AddPhotoButton(showCaptureImageView: self.$showCaptureImageView, image: self.$images[it], photoTitle: self.$photoTitles[it])
                        }
                    }
                }
                
                HStack(spacing: 150) {
                    Button(action: {
                        self.showCaptureImageView.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.blue)
                    }
                    
                    Button(action: {
                        let indexToRemove = CaptureImageView.index
                        
                        if indexToRemove > -1 {
                            self.images[indexToRemove] = UIImage(systemName: "photo")
                            
                            CaptureImageView.index -= 1
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                            .foregroundColor(.red)
                    }
                }.frame(height: 75)
            }
        }
    }
}

struct AddPhotosView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddPhotosView(showCaptureImageView: .constant(false), images: .constant([UIImage(systemName: "photo")]), photoTitles: .constant([""]))
    }
}
