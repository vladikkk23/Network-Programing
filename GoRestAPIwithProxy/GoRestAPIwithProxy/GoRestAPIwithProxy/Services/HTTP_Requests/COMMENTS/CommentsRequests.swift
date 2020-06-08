//
//  CommentsRequests.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 03/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

class CommentsRequests {
    // MARK: Properties
    
    // Singleton
    static let shared = CommentsRequests()
    
    private let webService = WebService.shared
    private var urlString = "http://localhost:8011/comments"
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (COMMENTS)
    
    // List all comments
    func GET_ALL_COMMENTS() {
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let commentsResult = try? JSONDecoder().decode(Comments_Result.self, from: jsonData) else { return }
            
            for comment in commentsResult.comments {
                print(comment)
            }
        }
    }
    
    // Return the comments of the post with post_id == '$postID'
    func GET_COMMENTS_FOR_POST(withID postID: Int) {
        let verb = "post_id=\(postID)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: verb) { (data) in
            guard let jsonData = data else { return }
            
            guard let commentsResult = try? JSONDecoder().decode(Comments_Result.self, from: jsonData) else { return }
            
            for comment in commentsResult.comments {
                print(comment)
            }
        }
    }
    
    // Return the comments of the user with Full Name == '$name'
    func GET_COMMENTS_FOR_USER(withName name: String) {
        let verb = "name=\(name)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: verb) { (data) in
            guard let jsonData = data else { return }
            
            guard let commentsResult = try? JSONDecoder().decode(Comments_Result.self, from: jsonData) else { return }
            
            for comment in commentsResult.comments {
                print(comment)
            }
        }
    }
    
    // Return the comments of the user with Email == '$email'
    func GET_COMMENTS_FOR_USER(withEmail email: String) {
        let verb = "email=\(email)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &self.urlString, verb: verb) { (data) in
            guard let jsonData = data else { return }
            
            guard let commentsResult = try? JSONDecoder().decode(Comments_Result.self, from: jsonData) else { return }
            
            for comment in commentsResult.comments {
                print(comment)
            }
        }
    }
    
    // MARK: Methods -> GET (COMMENT)
    
    // Return the details of the comment with id == '$id'
    func GET_COMMENT_BY_ID(id: Int) {
        var urlString = "\(self.urlString)/\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let commentResult = try? JSONDecoder().decode(Comment_Result.self, from: jsonData) else { return }
            
            print(commentResult.comment)
        }
    }
    
    // MARK: Methods -> POST (COMMENTS)
    
    // Add a new comment with data = '$comment'
    func POST_NEW_COMMENT(withData comment: New_Comment) {
        let urlString = "\(self.urlString)?access-token=\(self.webService.token)"
        
        guard let url = URL(string: urlString) else { return }
        
        let body = ["post_id": comment.postID, "name": comment.name, "email": comment.email, "body": comment.body]
        
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
                NSLog("New Comment Added Successfuly!")
            } else {
                guard let resData = try? JSONDecoder().decode(POST_Resp.self, from: data) else { return }
                
                NSLog("Failed to Add New Comment")
                NSLog(resData.meta.code.description)
                NSLog(resData.meta.message)
                NSLog(resData.result[0].field)
                NSLog(resData.result[0].message)
            }
        }.resume()
    }
}
