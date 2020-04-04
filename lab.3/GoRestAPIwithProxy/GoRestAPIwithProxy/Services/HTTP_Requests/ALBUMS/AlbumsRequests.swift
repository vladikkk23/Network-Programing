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
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (ALBUMS)
    
    // List all albums
    func GET_ALL_ALBUMS() {
        var urlString = "http://localhost:8011/albums"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let albumsResult = try? JSONDecoder().decode(Albums_Result.self, from: jsonData) else { return }
            
            for album in albumsResult.albums {
                print(album)
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
}
