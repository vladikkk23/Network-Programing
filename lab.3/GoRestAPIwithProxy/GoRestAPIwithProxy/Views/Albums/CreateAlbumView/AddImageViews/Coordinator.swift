//
//  Coordinator.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 23/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Properties
    @Binding var isCoordinatorShown: Bool
    @Binding var imageInCoordinator: UIImage?
    
    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
        _isCoordinatorShown = isShown
        _imageInCoordinator = image
    }
    
    // MARK: Methods
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageInCoordinator = unwrapImage
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        CaptureImageView.self.index -= 1
        isCoordinatorShown = false
    }
}
