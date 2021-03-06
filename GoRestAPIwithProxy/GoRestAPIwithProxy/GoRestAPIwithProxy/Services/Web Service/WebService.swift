//
//  WebService.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 02/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation

/*
 A singleton for making HTTP(S) Requests throw Proxy.
 Maximum number of requests per minute is set to 50.
 */

class WebService {
    
    // MARK: Properties
    
    // Config
    var session: URLSession?
    
    // Singleton
    static let shared = WebService()
    
    // Login Token
    let token = "YOUR-TOKEN"
    
    // Configure session details
    private init() {
        let configuration = URLSessionConfiguration.default
        
        configuration.connectionProxyDictionary = [
            kCFNetworkProxiesHTTPEnable: true,
            kCFNetworkProxiesHTTPProxy: "localhost",
            kCFNetworkProxiesHTTPPort: "8011",
        ]
        
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
        
        self.session = session
    }
    
    // MARK: Methods
    
    // Perfome a GET request with URL='$urlString' && query parameters='$verb'
    func makeRequestViaUrlSessionProxy(withURL urlString: inout String, verb: String?, completion: @escaping (_ result: Data?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let queryItemToken = URLQueryItem(name: "access-token", value: self.token)
        
        if verb != nil {
            
            var queryName = verb![...verb!.firstIndex(of: "=")!].description
            var queryValue = verb![verb!.firstIndex(of: "=")!...].description
            
            queryName.removeLast()
            queryValue.removeFirst()
            
            let queryItemQuery = URLQueryItem(name: queryName, value: queryValue)
            
            components?.queryItems = [queryItemToken, queryItemQuery]
        } else {
            components?.queryItems = [queryItemToken]
        }
        
        var request = URLRequest(url: (components?.url)!)
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language")
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        config.connectionProxyDictionary = [AnyHashable: Any]()
        config.connectionProxyDictionary?[kCFNetworkProxiesHTTPEnable as String] = 1
        config.connectionProxyDictionary?[kCFNetworkProxiesHTTPProxy as String] = "localhost"
        config.connectionProxyDictionary?[kCFNetworkProxiesHTTPPort as String] = 8011
        config.connectionProxyDictionary?[kCFStreamPropertyHTTPSProxyHost as String] = "localhost"
        config.connectionProxyDictionary?[kCFStreamPropertyHTTPSProxyPort as String] = 8011
        
        let session = URLSession.init(configuration: config, delegate: nil, delegateQueue: OperationQueue.current)
        
        NSLog("\(request.httpMethod ?? "UNKNOWN"): \(request.url?.absoluteString ?? "NONE")")
        
        session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                NSLog("Client-side error in request to \(url): \(error.debugDescription)")
                completion(nil)
                return
            }
            
            if data == nil {
                NSLog("Data from request to \(url) is nil")
                completion(nil)
                return
            }
            
            let httpResponse = response as? HTTPURLResponse        
            
            if httpResponse?.statusCode != 200 {
                NSLog("Server-side error in request to \(url): \(httpResponse.debugDescription )")
                completion(nil)
                return
            }
            session.invalidateAndCancel()
            completion(data)
        }.resume()
    }
    
    // MARK: Methods -> HEAD
    
    // Check if any content is present (FOR -> users/posts/comments/albums/photos)
    func HEAD_GENERAL() {
        var urlString = "http://localhost:8011/users"
        
        self.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let userResult = try? JSONDecoder().decode(User_Result.self, from: jsonData) else { return }
            
            print(userResult.user)
        }
    }
    
    // Check if any details content is present (FOR -> user_withID/post_withID/comment_withID/album_withID/photo_withID)
    func HEAD_DETAILS(byID id: Int) {
        var urlString = "http://localhost:8011/users/\(id)"
        
        self.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let userResult = try? JSONDecoder().decode(User_Result.self, from: jsonData) else { return }
            
            print(userResult.user)
        }
    }
    
    // MARK: Methods -> OPTIONS
    
    // Return available general options (FOR -> users/posts/comments/albums/photos)
    func OPTIONS_GENERAL() {
        var urlString = "http://localhost:8011/users"
        
        self.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let userResult = try? JSONDecoder().decode(User_Result.self, from: jsonData) else { return }
            
            print(userResult.user)
        }
    }
    
    // Return available detail options (FOR -> user/post/comment/album/photo)
    func OPTIONS_DETAILS(byID id: Int) {
        var urlString = "http://localhost:8011/users/\(id)"
        
        self.makeRequestViaUrlSessionProxy(withURL: &urlString, verb: nil) { (data) in
            guard let jsonData = data else { return }
            
            guard let userResult = try? JSONDecoder().decode(User_Result.self, from: jsonData) else { return }
            
            print(userResult.user)
        }
    }
}
