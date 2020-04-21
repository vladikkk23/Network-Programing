//
//  AlbumsRequests.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 03/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

class AlbumsRequests {
    // MARK: Properties
    
    // Singleton
    static let shared = AlbumsRequests()
    
    private let webService = WebService.shared
    private let usersRequests = UsersRequests.shared
    
    var albums = [Album]()
    private var urlString = "http://localhost:8011/albums"
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (ALBUMS)
    
    // List all albums
    func GET_ALL_ALBUMS(fromPage: Int, toPage: Int) {
        for page in stride(from: fromPage, to: toPage - 1, by: -1) {
            self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: "page=\(page)") { (data) in
                guard let jsonData = data else { return }
                
                guard let albumsResult = try? JSONDecoder().decode(Albums_Result.self, from: jsonData) else { return }
                
                self.albums.append(contentsOf: albumsResult.albums)
            }
        }
    }
    
    // Return the albums of the user with userID == '$id'
    func GET_ALBUMS_FOR_USER(withID id: Int) {
        let verb = "user_id=\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: verb) { (data) in
            guard let jsonData = data else { return }
            
            guard let albumsResult = try? JSONDecoder().decode(Albums_Result.self, from: jsonData) else { return }
            
            for album in albumsResult.albums {
                print(album)
            }
        }
    }
    
    // Return the posts wich containt '$content' in title
    func GET_ALBUMS_WITH_TITLE(containing content: String) {
        let verb = "title=\(content)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: verb) { (data) in
            guard let jsonData = data else { return }
            
            guard let albumsResult = try? JSONDecoder().decode(Albums_Result.self, from: jsonData) else { return }
            
            for album in albumsResult.albums {
                print(album)
            }
        }
    }
    
    // MARK: Methods -> GET (ALBUM)
    
    // Return the details of the album with id == '$id'
    func GET_ALBUM_BY_ID(id: Int) {
        var urlString = "\(self.urlString)/\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let albumResult = try? JSONDecoder().decode(Album_Result.self, from: jsonData) else { return }
            
            print(albumResult.album)
        }
    }
    
    // MARK: Methods -> POST (ALBUMS)
    
    // Add a new comment with data = '$album'
    func POST_NEW_ALBUM(withData album: New_Album) {
        let urlString = "\(self.urlString)?access-token=\(self.webService.token)"
        
        guard let url = URL(string: urlString) else { return }
        
        let body = ["user_id": album.userID, "title": album.title]
        
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
                NSLog("New Album Added Successfuly!")
            } else {
                guard let resData = try? JSONDecoder().decode(POST_Resp.self, from: data) else { return }
                
                NSLog("Failed to Add New Album")
                NSLog(resData.meta.code.description)
                NSLog(resData.meta.message)
                NSLog(resData.result[0].field)
                NSLog(resData.result[0].message)
            }
        }.resume()
    }
}
