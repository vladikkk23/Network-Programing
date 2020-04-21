//
//  PhotosData.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 21/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//  https://ibb.co/album/m0bynS

import Foundation
import SwiftUI

/*
 A Singleton for extracting Albums.
 */
class PhotosData: ObservableObject {
    
    // MARK: Properties
    
    // Singleton
    static let shared = PhotosData()
    
    private let albumsData = AlbumsData.shared
    
    // Published Albums
    @Published var photos = [Photo]()
    
    private let albumRequests = AlbumsRequests.shared
    private let photoRequests = PhotosRequests.shared
            
    private init() {}
    
    // MARK: Methods
    
    // Fetching all photos for '$album'
    func fetchAlbumPhotos(album: Album) {
        let albumID = Int(album.id)!
        let delay = DispatchTime.now() + .seconds(2)
        
        self.photoRequests.GET_PHOTOS_FROM_ALBUM(withID: albumID)
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.photos = self.photoRequests.photos
        }
    }
}
