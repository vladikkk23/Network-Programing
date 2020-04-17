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
    private var urlString = "http://localhost:8011/photos"
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (PHOTOS)
    
    // List all posts
    func GET_ALL_PHOTOS() {
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let photosResult = try? JSONDecoder().decode(Photos_Result.self, from: jsonData) else { return }
            
            for photo in photosResult.photos {
                print(photo)
            }
        }
    }
    
    // Return the photos form album with albumID == '$id'
    func GET_PHOTOS_FROM_ALBUM(withID id: Int) {
        let verb = "album_id=\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: verb) { (data) in
            guard let jsonData = data else { return }
            
            guard let photosResult = try? JSONDecoder().decode(Photos_Result.self, from: jsonData) else { return }
            
            for photo in photosResult.photos {
                print(photo)
            }
        }
    }
    
    // Return the photos wich containt '$content' in title
    func GET_PHOTOS_WITH_TITLE(containing content: String) {
        let verb = "title=\(content)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: verb) { (data) in
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
        var urlString = "\(self.urlString)/\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let photoResult = try? JSONDecoder().decode(Photo_Result.self, from: jsonData) else { return }
            
            print(photoResult.photo)
        }
    }
    
    // MARK: Methods -> POST (PHOTO)
    
    // Add a new photo with data = '$photo'
    func POST_NEW_ALBUM(withData photo: New_Photo) {
        let urlString = "\(self.urlString)?access-token=\(self.webService.token)"
        
        guard let url = URL(string: urlString) else { return }
        
        let body = ["album_id": photo.albumID, "title": photo.title, "url": photo.url, "thumbnail": photo.thumb]
        
        let jsonString = body.reduce("") { "\($0)\($1.0)=\($1.1)&" }
        
        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let err = error {
                fatalError("An error ocurred: \(err)")
            }
            
            guard let _ = response as? HTTPURLResponse else { return }
            
            guard let data = data else { return }
            
            if let _ = try? JSONDecoder().decode(POST_Response.self, from: data) {
                NSLog("New Photo Added Successfuly!")
            } else {
                guard let resData = try? JSONDecoder().decode(POST_Resp.self, from: data) else { return }
                
                NSLog("Failed to Add New Photo")
                NSLog(resData.meta.code.description)
                NSLog(resData.meta.message)
                NSLog(resData.result[0].field)
                NSLog(resData.result[0].message)
            }
        }.resume()
    }
}
