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
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (COMMENTS)
    
    // List all comments
    func GET_ALL_COMMENTS() {
        var urlString = "http://localhost:8011/comments"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let commentsResult = try? JSONDecoder().decode(Comments_Result.self, from: jsonData) else { return }
            
            for comment in commentsResult.comments {
                print(comment)
            }
        }
    }
    
    // Return the comments of the post with post_id == '$postID'
    func GET_COMMENTS_FOR_POST(withID postID: Int) {
        var urlString = "http://localhost:8011/comments"
        let verb = "post_id=\(postID)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let commentsResult = try? JSONDecoder().decode(Comments_Result.self, from: jsonData) else { return }
            
            for comment in commentsResult.comments {
                print(comment)
            }
        }
    }
    
    // Return the comments of the user with Full Name == '$name'
    func GET_COMMENTS_FOR_USER(withName name: String) {
        var urlString = "http://localhost:8011/comments"
        let verb = "name=\(name)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let commentsResult = try? JSONDecoder().decode(Comments_Result.self, from: jsonData) else { return }
            
            for comment in commentsResult.comments {
                print(comment)
            }
        }
    }
    
    // Return the comments of the user with Email == '$email'
    func GET_COMMENTS_FOR_USER(withEmail email: String) {
        var urlString = "http://localhost:8011/comments"
        let verb = "email=\(email)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
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
        var urlString = "http://localhost:8011/comments/\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let commentResult = try? JSONDecoder().decode(Comment_Result.self, from: jsonData) else { return }
            
            print(commentResult.comment)
        }
    }
    
    // MARK: Methods -> POST (COMMENTS)
    
}
