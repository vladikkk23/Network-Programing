//
//  PhotosRequests.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 04/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

class PhotosRequests {
    // MARK: Properties
    
    // Singleton
    static let shared = PhotosRequests()
    
    private let webService = WebService.shared
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (PHOTOS)
    
    // List all posts
    func GET_ALL_PHOTOS() {
        var urlString = "http://localhost:8011/photos"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let photosResult = try? JSONDecoder().decode(Photos_Result.self, from: jsonData) else { return }
            
            for photo in photosResult.photos {
                print(photo)
            }
        }
    }
    
    // Return the photos form album with albumID == '$id'
    func GET_PHOTOS_FROM_ALBUM(withID id: Int) {
        var urlString = "http://localhost:8011/photos"
        let verb = "album_id=\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let photosResult = try? JSONDecoder().decode(Photos_Result.self, from: jsonData) else { return }
            
            for photo in photosResult.photos {
                print(photo)
            }
        }
    }
    
    // Return the photos wich containt '$content' in title
    func GET_PHOTOS_WITH_TITLE(containing content: String) {
        var urlString = "http://localhost:8011/photos"
        let verb = "title=\(content)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let photosResult = try? JSONDecoder().decode(Photos_Result.self, from: jsonData) else { return }
            
            for photo in photosResult.photos {
                print(photo)
            }
        }
    }
    
    // MARK: Methods -> GET (PHOTO)
    
    // Return the details of the photo with id == '$id'
    func GET_PHOTO_BY_ID(id: Int) {
        var urlString = "http://localhost:8011/photos/\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let photoResult = try? JSONDecoder().decode(Photo_Result.self, from: jsonData) else { return }
            
            print(photoResult.photo)
        }
    }
    
    // MARK: Methods -> POST (PHOTO)
}
