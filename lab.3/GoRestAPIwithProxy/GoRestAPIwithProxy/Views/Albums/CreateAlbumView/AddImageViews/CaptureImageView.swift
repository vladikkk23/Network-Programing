//
//  CaptureImageView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 23/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct CaptureImageView: View {
    // MARK: - Properties
    @Binding var isShown: Bool
    @Binding var images: [Image?]
    
    static var index = -1
    
    // MARK: - Methods
    func makeCoordinator() -> Coordinator {
        CaptureImageView.self.index += 1
        return Coordinator(isShown: $isShown, image: $images[CaptureImageView.self.index])
    }
}

extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}
