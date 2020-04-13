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
    
    var albums = [Album]()
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (ALBUMS)
    
    // List all albums
    func GET_ALL_ALBUMS() {
        var urlString = "http://localhost:8011/albums"
        
        for page in stride(from: 179, to: 2, by: -1) {
            self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: "page=\(page)") { (data) in
                print(#function)
                print(data ?? "EMPTY")
                
                guard let jsonData = data else { return }
                
                guard let albumsResult = try? JSONDecoder().decode(Albums_Result.self, from: jsonData) else { return }
                
                self.albums.append(contentsOf: albumsResult.albums)
                
                AlbumsData.shared.albums = self.albums.sorted(by: { (album1, album2) -> Bool in
                    return album1.id > album2.id
                })
            }
        }
    }
    
    // Return the albums of the user with userID == '$id'
    func GET_ALBUMS_FOR_USER(withID id: Int) {
        var urlString = "http://localhost:8011/albums"
        let verb = "user_id=\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let albumsResult = try? JSONDecoder().decode(Albums_Result.self, from: jsonData) else { return }
            
            for album in albumsResult.albums {
                print(album)
            }
        }
    }
    
    // Return the posts wich containt '$content' in title
    func GET_ALBUMS_WITH_TITLE(containing content: String) {
        var urlString = "http://localhost:8011/albums"
        let verb = "title=\(content)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
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
        var urlString = "http://localhost:8011/albums/\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let albumResult = try? JSONDecoder().decode(Album_Result.self, from: jsonData) else { return }
            
            print(albumResult.album)
        }
    }
    
    // MARK: Methods -> POST (ALBUMS)
    
    // Add a new comment with data = '$album'
    func POST_NEW_ALBUM(withData album: New_Album) {
        let urlString = "http://localhost:8011/albums?access-token=\(self.webService.token)"
        
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
                print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                print("New Album Added Successfuly!")
                print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                print(album)
            } else {
                guard let resData = try? JSONDecoder().decode(POST_Resp.self, from: data) else { return }
                print(resData.meta.success)
                print(resData.meta.code)
                print(resData.meta.message)
                print(resData.meta.rateLimit ?? "NO Rate Limit")
                print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                for field in resData.result {
                    print(field.field)
                    print(field.message)
                }
            }
        }.resume()
    }
}
