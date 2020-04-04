//
//  User_Requests.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 03/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

class UsersRequests {
    // MARK: Properties
    
    // Singleton
    static let shared = UsersRequests()
    
    private let webService = WebService.shared
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (USER)
    
    // List all users
    func GET_ALL_USERS() {
        var urlString = "http://localhost:8011/users"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let userResult = try? JSONDecoder().decode(Users_Result.self, from: jsonData) else { return }
            
            for user in userResult.users {
                print(user)
            }
        }
    }
    
    // List all users where first_name contains '$name'
    func GET_USER_BY_FIRST_NAME(name: String) {
        var urlString = "http://localhost:8011/users"
        let verb = "first_name=\(name)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let userResult = try? JSONDecoder().decode(Users_Result.self, from: jsonData) else { return }
            
            print(userResult.users[0])
        }
    }
    
    // MARK: Methods -> GET (USER)
    
    // Return the details of the user with id == '$id'
    func GET_USER_BY_ID(id: Int) {
        var urlString = "http://localhost:8011/users/\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let userResult = try? JSONDecoder().decode(User_Result.self, from: jsonData) else { return }
            
            print(userResult.user)
        }
    }
    
    // MARK: Methods -> POST (USER)
}
