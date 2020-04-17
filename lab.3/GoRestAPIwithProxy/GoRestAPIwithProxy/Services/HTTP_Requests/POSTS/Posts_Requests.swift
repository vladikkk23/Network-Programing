//
//  Posts_Requests.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 03/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

class PostsRequests {
    // MARK: Properties
    
    // Singleton
    static let shared = PostsRequests()
    
    private let webService = WebService.shared
    
    // Init
    private init() {}
    
    // MARK: Methods -> GET (POSTS)
    
    // List all posts
    func GET_ALL_POSTS() {
        var urlString = "http://localhost:8011/posts"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let userResult = try? JSONDecoder().decode(Posts_Result.self, from: jsonData) else { return }
            
            for post in userResult.posts {
                print(post)
            }
        }
    }
    
    // Return the posts of the user with userID == '$id'
    func GET_POSTS_FOR_USER(withID id: Int) {
        var urlString = "http://localhost:8011/posts"
        let verb = "user_id=\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let postsResult = try? JSONDecoder().decode(Posts_Result.self, from: jsonData) else { return }
            
            for post in postsResult.posts {
                print(post)
            }
        }
    }
    
    // Return the posts wich containt '$content' in title
    func GET_POSTS_WITH_TITLE(containing content: String) {
        var urlString = "http://localhost:8011/posts"
        let verb = "title=\(content)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let postsResult = try? JSONDecoder().decode(Posts_Result.self, from: jsonData) else { return }
            
            for post in postsResult.posts {
                print(post)
            }
        }
    }
    
    // Return the posts wich containt '$content' in body
    //    func GET_POSTS_WITH_BODY(containing content: String) {
    //        var urlString = "http://localhost:8011/posts"
    //        let verb = "body=\(content)"
    //
    //        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: verb) { (data) in
    //            print(#function)
    //            print(data ?? "EMPTY")
    //
    //            guard let jsonData = data else { return }
    //
    //            guard let postsResult = try? JSONDecoder().decode(Posts_Result.self, from: jsonData) else { return }
    //
    //            for post in postsResult.posts {
    //                print(post)
    //            }
    //        }
    //    }
    
    // MARK: Methods -> GET (POST)
    
    // Return the details of the post with id == '$id'
    func GET_POST_BY_ID(id: Int) {
        var urlString = "http://localhost:8011/posts/\(id)"
        
        self.webService.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            print(#function)
            print(data ?? "EMPTY")
            
            guard let jsonData = data else { return }
            
            guard let postResult = try? JSONDecoder().decode(Post_Result.self, from: jsonData) else { return }
            
            print(postResult.post)
        }
    }
    
    // MARK: Methods -> POST (POST)
    
    // Add a new post with data = '$post'
    func POST_NEW_POST(withData post: New_Post) {
        let urlString = "http://localhost:8011/posts?access-token=\(self.webService.token)"
        
        guard let url = URL(string: urlString) else { return }
                
        let body = ["user_id": post.userID, "title": post.title, "body": post.body]
        
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
                print("New Post Added Successfuly!")
                print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
                print(post)
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
