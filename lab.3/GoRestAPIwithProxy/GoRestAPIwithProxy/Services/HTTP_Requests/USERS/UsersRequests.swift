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
    
    // Add a new user with data = '$user'
    func POST_NEW_USER(withData user: New_User) {
        let urlString = "http://localhost:8011/users?access-token=\(self.webService.token)"
        
        guard let url = URL(string: urlString) else { return }
        
        let userDOBString = Date.getFormattedDate(date: user.dob, format: "yyyy-MM-dd")
        
        let body = ["email": user.email, "first_name": user.first_name, "last_name": user.last_name, "gender": user.gender.rawValue, "dob": userDOBString, "phone": user.phone, "website": user.website.href, "address": user.address, "status": user.status.rawValue]
        
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
                print("New User Added Successfuly!")
                print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                print(user)
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
