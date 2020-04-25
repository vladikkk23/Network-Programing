//
//  PhotosData.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 21/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//  https://ibb.co/album/m0bynS

import UIKit

/*
 A Singleton for extracting Photos.
 */
class PhotosData: ObservableObject {
    
    // MARK: Properties
    
    // Singleton
    static let shared = PhotosData()
    
    private let albumsData = AlbumsData.shared
    private let contentLoader = ContentLoader.shared
    let contentUploader = ContentUploader.shared
    
    // Published Photos
    @Published var photos = [Photo]()
    @Published var images = [UIImage]()
    
    private let albumRequests = AlbumsRequests.shared
    private let photoRequests = PhotosRequests.shared
    
    var imgurUrls = [String]()
    var thmbUrls = [String]()
    
    private init() {}
    
    // MARK: Methods
    
    // Fetching all Photos for '$album'
    func fetchAlbumPhotos(album: Album) {
        let albumID = Int(album.id)!
        let delay = DispatchTime.now() + .milliseconds(3500)
        
        self.photoRequests.GET_PHOTOS_FROM_ALBUM(withID: albumID)
        
        DispatchQueue.main.asyncAfter(deadline: delay) {            
            self.contentLoader.content = self.contentLoader.tempImages
            
            self.photos = self.photoRequests.photos
            self.images = self.contentLoader.content
            
            while self.images.count < self.photos.count {
                self.images.append(UIImage(named: "NoImage")!)
            }
        }
    }
    
    func uploadAlbumPhotos(images: [UIImage?]) {
        var sortedImages = images as! [UIImage]
        let imagesCount = CaptureImageView.index
        
        sortedImages = sortedImages.removingDuplicates()
        
        if imagesCount > -1 {
            if imagesCount == 0 {
                self.contentUploader.uploadImageToImgur(image: sortedImages[imagesCount])
                self.contentUploader.uploaThumbnail(image: sortedImages[imagesCount])
            } else {
                for it in 0...imagesCount {
                    self.contentUploader.uploadImageToImgur(image: sortedImages[it])
                    self.contentUploader.uploaThumbnail(image: sortedImages[it])
                }
            }
            
            let delay = DispatchTime.now() + .seconds(7)
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: delay) {
                self.imgurUrls = self.contentUploader.imgurUrls
                self.thmbUrls = self.contentUploader.thmbUrls
                
                self.contentUploader.imgurUrls = []
                self.contentUploader.thmbUrls = []
            }
        }
    }
}
