//
//  AlbumsData.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 13/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

/*
A Singleton for extracting Albums.
*/
class AlbumsData: ObservableObject {
    
    // MARK: Properties
    
    // Singleton
    static let shared = AlbumsData()
    
    // Published Albums
    @Published var albums = [Album]()
    
    private let requests = AlbumsRequests.shared
    
    private init() {
        self.fetchAlbums()
    }
    
    // MARK: Methods
    
    // Fetching all albums
    func fetchAlbums() {
        DispatchQueue.main.async {
            self.requests.GET_ALL_ALBUMS()
        }
    }
}
