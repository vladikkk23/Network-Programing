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
    
    // Store last 10 albums
    @Published var topAlbums = [Album(id: "1", userID: "1234", title: "Test", links: Post_Links(linksSelf: Href(href: "LINK"), edit: Href(href: "LINK")))]
    var published = false
    
    private let requests = AlbumsRequests.shared
    
    var timer: Timer?
    
    var currentPages = [180, 165]
    
    private init() {
        //        self.fetchAlbums()
    }
    
    // MARK: Methods
    
    func addNewAlbum(withData album: Album) {
        
    }
    
    // Fetching top '$albumsCount' albums
    private func fetchTopAlbums(albumsCount: Int) {
        NSLog("Fetching Top 10 Albums")
        var topAlbums = [Album]()
        
        for it in 0..<albumsCount {
            topAlbums.append(self.albums[it])
        }
        
        DispatchQueue.main.async {
            self.topAlbums = topAlbums
        }
    }
    
    // Updating albums with newly added
    func updateAlbums() {
        NSLog("Updating Albums")
        
        let delay = DispatchTime.now() + .seconds(2)
        
        // Check last 5 pages for new Albums
        self.requests.GET_ALL_ALBUMS(fromPage: self.currentPages[0], toPage: self.currentPages[0] - 5)
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.albums = self.sortAlbums(albums: self.requests.albums)
            
            if self.albums.count > 10 {
                self.fetchTopAlbums(albumsCount: 10)
            } else {
                self.fetchTopAlbums(albumsCount: self.albums.count)
            }
        }
    }
    
    // Fetching all albums
    @objc
    func fetchAlbums() {
        self.startTimer()
        
        NSLog("Fetching Albums")
        
        let delay = DispatchTime.now() + .seconds(4)
        self.requests.GET_ALL_ALBUMS(fromPage: self.currentPages[0], toPage: self.currentPages[1])
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.albums = self.sortAlbums(albums: self.requests.albums)
            
            if !self.published {
                self.fetchTopAlbums(albumsCount: 10)
                self.published.toggle()
            }
        }
        
        self.currentPages[0] = self.currentPages[1] - 1
        
        if self.currentPages[1] > 15 {
            self.currentPages[1] -= 15
        } else if self.currentPages[1] == 15 {
            self.currentPages[1] = 1
        } else {
            self.currentPages = [180, 165]
            self.stopTimer()
        }
    }
    
    // Setup and Start timer
    private func startTimer() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.fetchAlbums), userInfo: nil, repeats: true)
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
    
    private func removeEmptyAlbums(fromArray albums: [Album]) -> [Album] {
        var sortedAlbums = albums
        var count = 0
        var emptyAlbumsRemoved = 0
        
        for album in albums {
            count += 1
            if album.id.isEmpty {
                sortedAlbums.remove(at: count)
                emptyAlbumsRemoved += 1
            }
        }
        
        return sortedAlbums
    }
    
    private func sortAlbums(albums: [Album]) -> [Album] {
        let sortedAlbums = self.removeEmptyAlbums(fromArray: albums)
        var uniqueAlbums = sortedAlbums.removingDuplicates()
        
        uniqueAlbums = uniqueAlbums.sorted(by: { (album1, album2) -> Bool in
            Int(album1.id)! > Int(album2.id)!
        })
        
        return uniqueAlbums
    }
}
