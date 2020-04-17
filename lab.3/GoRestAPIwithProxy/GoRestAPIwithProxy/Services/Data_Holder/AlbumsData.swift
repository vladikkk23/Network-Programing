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
    
    var timer: Timer?
    
    var currentPages = [178, 153]
    
    private init() {
        self.fetchAlbums()
    }
    
    // MARK: Methods
    
    // Fetching all albums
    @objc
    func fetchAlbums() {
        self.startTimer()
        print("~~~~~~~~~~~~~~~~~~~~")
        print("~~~~~~~~~~~~~~~~~~~~")
        print(self.currentPages)
        print("~~~~~~~~~~~~~~~~~~~~")
        print("~~~~~~~~~~~~~~~~~~~~")
        
        let delay = DispatchTime.now() + .seconds(2)
        self.requests.GET_ALL_ALBUMS(fromPage: self.currentPages[0], toPage: self.currentPages[1])
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.albums = self.sortAlbums(albums: self.requests.albums)
        }
        
        self.currentPages[0] = self.currentPages[1]
        
        if self.currentPages[1] > 3 {
            self.currentPages[1] -= 25
        } else if self.currentPages[1] == 3 {
            self.currentPages[1] = 0
        } else {
            self.currentPages = [178, 153]
            self.stopTimer()
        }
    }
    
    // Setup and Start timer
    private func startTimer() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 31, target: self, selector: #selector(self.fetchAlbums), userInfo: nil, repeats: true)
            NSLog("Timer Started.")
        }
    }
    
    // Stop timer
    private func stopTimer() {
        if self.timer != nil {
            self.timer!.invalidate()
            self.timer = nil
            
            NSLog("Timer Stopped.")
        }
    }
    
    private func sortAlbums(albums: [Album]) -> [Album] {
        
        var sortedAlbums = albums
        var count = 0
        var albumsRemoved = 0
                
        for album in albums {
            count += 1
            
            if album.id.isEmpty {
                sortedAlbums.remove(at: count)
                albumsRemoved += 1
            }
        }
        
        sortedAlbums = sortedAlbums.sorted(by: { (album1, album2) -> Bool in
            Int(album1.id)! > Int(album2.id)!
        })
        
        return sortedAlbums
    }
}
