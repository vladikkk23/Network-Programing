//
//  UsersData.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 22/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

import Foundation

/*
 A Singleton for extracting Photos.
 */
class UsersData: ObservableObject {
    
    // MARK: Properties
    
    // Singleton
    static let shared = UsersData()
    
    // Published Photos
    @Published var userInfo = UserInfo(firstName: "", lastName: "")
    
    private let userRequests = UsersRequests.shared
    
    private init() {}
    
    // MARK: Methods
    
    // Fetching all Photos for '$album'
    func fetchUserInfo(forAlbum album: Album) {
        let userID = Int(album.userID)!
        let delay = DispatchTime.now() + .milliseconds(1500)
        
        self.userRequests.GET_USER_BY_ID(id: userID)
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            self.userInfo = self.userRequests.userInfo
        }
    }
}
